<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\User;
use App\Models\InventoryClient;
use App\Models\InventoryProductSales;
use App\Models\AccountSetting;
use App\Models\PaymentMethod;
use App\Models\InventoryReceiveExecutive;
use App\Models\InventorySalesPaymentHistory;
use App\Models\InventorySalesPaymentHistoryItem;
use App\Models\CompanyInfo;
use App\Models\EmailConfig;
use Yajra\DataTables\DataTables;
use Validator;
use Auth;

class InventorySalesPaymentController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('pos.sales.payment.viewAll');
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
        $clients = InventoryClient::orderBy('id','desc')->where(['fk_branch_id'=>$branchId,'fk_company_id'=>$companyId])->pluck('company_name','id');
        
        return view('pos.sales.payment.index',compact('clients'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $input = $request->all();
        $validator = Validator::make($request->all(),[
                'fk_client_id' => 'required',
                'fk_sales_id' => 'required',
                'payment_date' => 'required',

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }
        
        $date = $input['payment_date'];
        $newDate = date("Y-m-d", strtotime($date));
        $input['payment_date'] = $newDate;
        $lastId=InventorySalesPaymentHistory::max('id')+1;
        $input['invoice_id'] =date('ymd').$lastId;
        $invoice_id=$input['invoice_id'];
        if($input['paid']==0){
            return redirect()->back()->with('error','Payment is not possible without paid!');
        }
        $payment_id = InventorySalesPaymentHistory::create([
            'fk_client_id'=>$input['fk_client_id'],
            'invoice_id'=>$input['invoice_id'],
            'payment_date'=>$input['payment_date'],
            'total_amount'=>$input['total_amount'],
            'paid'=>$input['paid'],
            'last_due'=>$input['last_due'],
            'fk_account_id'=>$input['fk_account_id'],
            'fk_method_id'=>$input['fk_method_id'],
            'ref_id'=>$input['ref_id'],
            'fk_branch_id'=>Auth::user()->fk_branch_id,
            'fk_company_id'=>Auth::user()->fk_company_id,
            'created_by'=>Auth::user()->id,
            'fk_received_id'=>Auth::user()->id
            ])->id;
            $paid=$input['paid'];
            for ($i=0; $i < sizeof($input['fk_sales_id']); $i++) { 
                $last_due=$input['sales_last_due'][$i];
                $sales_id=$input['fk_sales_id'][$i];
                if($last_due>$paid){
                    $payable=$paid;
                    $paid=0;
                }else{
                    $payable=$last_due;
                    $paid=$paid-$last_due;
                }
                $sales=InventoryProductSales::where('id',$sales_id)->first();
                $sales->update([
                    'paid_amount'=>$payable+$sales->paid_amount,
                    ]);
                InventorySalesPaymentHistoryItem::create([
                    'fk_payment_id'=>$payment_id,
                    'fk_sales_id'=>$input['fk_sales_id'][$i],
                    'sales_last_due'=>$input['sales_last_due'][$i],
                    'sales_paid'=>$payable,

                    ]);
            }
        try {
            
            $bug = 0;
            
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect("inventory-sales-payment-invoice/$invoice_id")->with('success','New payment Created Successfully.');
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
        $clients = InventoryClient::orderBy('id','desc')->where(['fk_branch_id'=>$branchId,'fk_company_id'=>$companyId])->pluck('company_name','id');
        $client = InventoryClient::where('id',$id)->select('id','client_name','company_name','client_id','address','mobile_no','email_id')->first();
        $allDue  = InventoryProductSales::select('id','invoice_id','date','total_amount','paid_amount')
        ->where('fk_client_id',$id)
        ->whereColumn('total_amount','>','paid_amount')
        ->orderBy('inventory_product_sales.id','ASC')
        ->get();
        $account=AccountSetting::where('account_status',1)->pluck('account_name','id');
        $method=PaymentMethod::where('method_status',1)->pluck('method_name','id');
        $receiver = User::where('status',1)->where(['fk_branch_id'=>$branchId,'fk_company_id'=>$companyId])->pluck('name','id');
        return view('pos.sales.payment.index',compact('clients','client','allDue','account','method','receiver'));

    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $branchId=Auth::user()->fk_branch_id;
        $companyId=Auth::user()->fk_company_id;
        $getInvoiceData=InventorySalesPaymentHistory::leftJoin('inventory_clients','inventory_payment_history.fk_client_id','=','inventory_clients.id')
            ->select('inventory_payment_history.*','inventory_clients.client_name','inventory_clients.mobile_no','inventory_clients.address','inventory_clients.email_id','inventory_clients.company_name','inventory_clients.client_id')
            ->where('inventory_payment_history.id',$id)
            ->first();
            if($getInvoiceData==null){
                return redirect()->back()->with('error',"Invoice ($id) is not found!");
            }
        $getProductData = InventorySalesPaymentHistoryItem::
        leftJoin('inventory_product_sales','inventory_payment_history_item.fk_sales_id','=','inventory_product_sales.id')
        ->where('fk_payment_id',$getInvoiceData->id)
        ->select('inventory_payment_history_item.*','inventory_product_sales.total_amount','inventory_product_sales.invoice_id')
        ->get();
        $account=AccountSetting::where('account_status',1)->pluck('account_name','id');
        $method=PaymentMethod::where('method_status',1)->pluck('method_name','id');
        $receiver = User::where('status',1)->where(['fk_branch_id'=>$branchId,'fk_company_id'=>$companyId])->pluck('name','id');
        return view('pos.sales.payment.edit', compact('getInvoiceData','getProductData','account','method','receiver'));
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
        $input=$request->except('_token','_method');
        $validator = Validator::make($request->all(),[
                'fk_sales_id' => 'required',
                'payment_date' => 'required',

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }
        
        $date = $input['payment_date'];
        $newDate = date("Y-m-d", strtotime($date));
        $input['payment_date'] = $newDate;
        if($input['paid']==0){
            return redirect()->back()->with('error','Payment is not possible without paid!');
        }
        $payment=InventorySalesPaymentHistory::findOrFail($id);
        $payment->update([
            'payment_date'=>$input['payment_date'],
            'paid'=>$input['paid'],
            'last_due'=>$input['last_due'],
            'fk_account_id'=>$input['fk_account_id'],
            'fk_method_id'=>$input['fk_method_id'],
            'ref_id'=>$input['ref_id'],
            'created_by'=>Auth::user()->id,
            ]);
            $paid=$input['paid'];
            for ($i=0; $i < sizeof($input['fk_sales_id']); $i++) { 
                $last_due=$input['sales_last_due'][$i];
                $sales_id=$input['fk_sales_id'][$i];
                $item_id=$input['item_id'][$i];
                $sales_paid=$input['sales_paid'][$i];

                if($last_due>$paid){
                    $payable=$paid;
                    $paid=0;
                }else{
                    $payable=$last_due;
                    $paid=$paid-$last_due;
                }
                $paymentItem=InventorySalesPaymentHistoryItem::where('id',$item_id)->first();
                $sales=InventoryProductSales::where('id',$sales_id)->first();
                $sales->update([
                    'paid_amount'=>$payable+$sales->paid_amount-$paymentItem->sales_paid,
                    ]);
                $paymentItem->update([
                    'sales_paid'=>$payable,
                    ]);
            }
        try {
            
            $bug = 0;
            
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect("inventory-sales-payment-invoice/$payment->invoice_id")->with('success','Updated Successfully.');
        }else{
            return redirect()->back()->with('error','Something Error Found !, Please try again.'.$bug1);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $payment=InventorySalesPaymentHistory::findOrFail($id);
        $paymentItem=InventorySalesPaymentHistoryItem::where('fk_payment_id',$id)->get();
        foreach ($paymentItem as $key => $value) {
            $sales=InventoryProductSales::where('id',$value->fk_sales_id)->first();
            $sales->update([
                    'paid_amount'=>$sales->paid_amount-$value->sales_paid,
                    ]);
            InventorySalesPaymentHistoryItem::where('id',$value->id)->delete();

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
         $getInvoiceData=InventorySalesPaymentHistory::leftJoin('inventory_clients','inventory_payment_history.fk_client_id','=','inventory_clients.id')
            ->leftJoin('users','inventory_payment_history.fk_received_id','=','users.id')
            ->select('inventory_payment_history.*','inventory_clients.client_name','inventory_clients.mobile_no','inventory_clients.address','inventory_clients.email_id','inventory_clients.company_name','inventory_clients.client_id','users.name as received_by')
            ->where('inventory_payment_history.invoice_id',$id)
            ->first();
            if($getInvoiceData==null){
                return redirect()->back()->with('error',"Invoice ($id) is not found!");
            }
        $getProductData = InventorySalesPaymentHistoryItem::
        leftJoin('inventory_product_sales','inventory_payment_history_item.fk_sales_id','=','inventory_product_sales.id')
        ->where('fk_payment_id',$getInvoiceData->id)
        ->select('inventory_payment_history_item.*','inventory_product_sales.total_amount','inventory_product_sales.invoice_id')
        ->get();
        return view('pos.sales.payment.invoice', compact('getInvoiceData','getProductData'));
    }

    public function allPayment(){
        $branchId=Auth::user()->fk_branch_id;
        $companyId=Auth::user()->fk_company_id;
        $query  = InventorySalesPaymentHistory::leftJoin('inventory_branch','inventory_payment_history.fk_branch_id','inventory_branch.id')
        ->leftJoin('inventory_clients','inventory_payment_history.fk_client_id','inventory_clients.id')
        ->select('inventory_payment_history.*','inventory_clients.client_name','inventory_clients.company_name','branch_name')
        ->orderBy('inventory_payment_history.id','DESC');

        if(Auth::user()->isRole('administrator')){
            $sales=$query;
        }else{
            $sales=$query->where(['inventory_payment_history.fk_branch_id'=>$branchId,'inventory_payment_history.fk_company_id'=>$companyId]);
        }
            //return $customer;
        return Datatables::of($sales)
            ->addColumn('invoice_id','<a href=\'<? echo URL::to("inventory-sales-payment-invoice/$invoice_id") ?>\' target="_blank" title="View Browser">{{$invoice_id}}</a>')
            ->addColumn('total_amount', '{{round($last_due,2)}}')
            ->addColumn('paid', '{{round($paid,2)}}')
            ->addColumn('due_amount', '{{round($last_due-$paid,2)}}')
            ->addColumn('action', '
                <a href=\'{{URL::to("inventory-sales-payment/$id/edit")}}\' class="btn btn-warning btn-xs"><i class="fa fa-pencil-square"></i></a>
                {!! Form::open(array(\'route\'=> [\'inventory-sales-payment.destroy\',$id],\'method\'=>\'DELETE\')) !!}
                    <button type="submit" onclick="return confirmDelete();" class="btn btn-xs btn-danger">
                      <i class="fa fa-trash-o" aria-hidden="true"></i>
                    </button>
                {!! Form::close() !!}
                ')

            ->rawColumns(['invoice_id','action'])
            ->make(true);
    }

   







}
