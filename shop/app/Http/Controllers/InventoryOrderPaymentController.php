<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\User;
use App\Models\InventoryClient;
use App\Models\InventoryProductSales;
use App\Models\AccountSetting;
use App\Models\PaymentMethod;
use App\Models\InventorySupplier;
use App\Models\InventoryOrderPayment;
use App\Models\InventoryProductAdd;
use App\Models\InventoryOrderPaymentItem;
use Yajra\DataTables\DataTables;
use Validator;
use Auth;

class InventoryOrderPaymentController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('pos.product_order.payment.viewAll');
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $branchId=Auth::user()->fk_branch_id;
        $companyId=Auth::user()->fk_company_id;
        $clients = InventorySupplier::orderBy('id','desc')->where(['fk_branch_id'=>$branchId,'fk_company_id'=>$companyId])->pluck('company_name','id');
        
        return view('pos.product_order.payment.index',compact('clients'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $input=$request->except('_token');
        $validator = Validator::make($request->all(),[
                'fk_supplier_id' => 'required',
                'fk_order_id' => 'required',
                'payment_date' => 'required',

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }
        
        $date = $input['payment_date'];
        $newDate = date("Y-m-d", strtotime($date));
        $input['payment_date'] = $newDate;
        $lastId=InventoryOrderPayment::max('id')+1;
        $invoice_id= date('ymd').$lastId;

        if($input['paid']==0){
            return redirect()->back()->with('error','Payment is not possible without paid!');
        }
        $paymentId = InventoryOrderPayment::create([
                'invoice_id'=>$invoice_id,
                'last_due'=>$input['last_due'],
                'fk_supplier_id'=>$input['fk_supplier_id'],
                'paid'=>$input['paid'],
                'type'=>0,
                'payment_date'=>$input['payment_date'],
                'created_by'=>\Auth::user()->id
                ])->id;
            $paid=$input['paid'];
            for ($i=0; $i < sizeof($input['fk_order_id']); $i++) { 
                $last_due=$input['order_last_due'][$i];
                $order_id=$input['fk_order_id'][$i];
                if($last_due>$paid){
                    $payable=$paid;
                    $paid=0;
                }else{
                    $payable=$last_due;
                    $paid=$paid-$last_due;
                }
                $sales=InventoryProductAdd::where('id',$order_id)->first();
                $sales->update([
                    'total_paid'=>$payable+$sales->total_paid,
                    ]);
                InventoryOrderPaymentItem::create([
                'fk_order_id'=>$order_id,
                'fk_order_payment_id'=>$paymentId,
                'type'=>0,
                'order_last_due'=> $last_due,
                'order_paid'=>$payable,
                ]);
            }
        try {
            
            $bug = 0;
            
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect("inventory-order-payment-invoice/$invoice_id")->with('success','New payment Created Successfully.');
        }else{
            return redirect()->back()->with('error','Something Error Found !, Please try again.'.$bug1);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
         $branchId=Auth::user()->fk_branch_id;
        $companyId=Auth::user()->fk_company_id;
        $clients = InventorySupplier::orderBy('id','desc')->where(['fk_branch_id'=>$branchId,'fk_company_id'=>$companyId])->pluck('company_name','id');
        $client = InventorySupplier::where('id',$id)->select('id','company_name','representative','supplier_id','address','mobile_no','email_id')->first();

        $allDue = InventoryProductAdd::select('id','inventory_order_id as invoice_id','date','total_amount','total_paid')
        ->where('fk_supplier_id',$id)
        ->whereColumn('total_amount','>','total_paid')
        ->orWhere('total_paid','=',null)
        ->orderBy('inventory_product_add.id','ASC')
        ->get();
        $account=AccountSetting::where('account_status',1)->pluck('account_name','id');
        $method=PaymentMethod::where('method_status',1)->pluck('method_name','id');
        $receiver = User::where('status',1)->where(['fk_branch_id'=>$branchId,'fk_company_id'=>$companyId])->pluck('name','id');
        return view('pos.product_order.payment.index',compact('clients','client','allDue','account','method','receiver'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
         $payment=InventoryOrderPayment::findOrFail($id);
        $paymentItem=InventoryOrderPaymentItem::where('fk_order_payment_id',$id)->get();
        foreach ($paymentItem as $key => $value) {
           $sales=InventoryProductAdd::where('id',$value->fk_order_id)->first();
            $sales->update([
                'total_paid'=>$sales->total_paid-$value->order_paid,
                ]);
            InventoryOrderPaymentItem::where('id',$value->id)->delete();

        }
        $payment->delete();
        try {
            
            $bug = 0;
            
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect()->back()->with('success','Deleted Successfully.');
        }else{
            return redirect()->back()->with('error','Something Error Found !, Please try again.'.$bug1);
        }
    }
    public function invoice($id)
        {
             $data=InventoryOrderPayment::where('inventory_order_payment.invoice_id',$id)->first();
                if($data==null){
                    return redirect()->back()->with('error',"Invoice ($id) is not found!");
                }
            
            return view('pos.product_order.payment.invoice', compact('data'));
        }

    public function allPayment(){
        
        $branchId=Auth::user()->fk_branch_id;
        $companyId=Auth::user()->fk_company_id;
        $all  = InventoryOrderPayment::leftJoin('inventory_supplier','inventory_order_payment.fk_supplier_id','inventory_supplier.id')
        ->select('inventory_order_payment.*','inventory_supplier.company_name')
        ->orderBy('inventory_order_payment.id','DESC');
        return Datatables::of($all)
            ->addColumn('invoice_id','<a href=\'<? echo URL::to("inventory-order-payment-invoice/$invoice_id") ?>\' title="View brochure">{{$invoice_id}}</a>')
           
            ->addColumn('total_amount', '{{round($last_due,2)}}')
            ->addColumn('paid', '{{round($paid,2)}}')
            ->addColumn('due_amount', '{{round($last_due-$paid,2)}}')
            ->addColumn('action', '
                
                {!! Form::open(array(\'route\'=> [\'inventory-order-payment.destroy\',$id],\'method\'=>\'DELETE\')) !!}
                    <button type="submit" onclick="return confirmDelete();" class="btn btn-xs btn-danger">
                      <i class="fa fa-trash-o" aria-hidden="true"></i>
                    </button>
                {!! Form::close() !!}
                ')
            ->rawColumns(['action','invoice_id'])
            ->make(true);
    }

}
