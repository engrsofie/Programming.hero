<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\InventoryClient;
use App\Models\InventoryProductSales;
use Yajra\DataTables\DataTables;
use Validator;
use Auth;

class InventoryClientOpeningDueController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {

        return view('pos.clients.opening.viewAll');
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
        $clients = InventoryClient::orderBy('id','desc')->where(['fk_branch_id'=>$branchId,'fk_company_id'=>$companyId])->pluck('client_name','id');
        return view('pos.clients.opening.index',compact('clients'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $input = $request->except('_token');
         $validator = Validator::make($request->all(),[
                'fk_client_id' => 'required',
                'total_amount' => 'required'

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }
        $date = $input['date'];
        $newDate = date("Y-m-d", strtotime($date));
        $input['date'] = $newDate;
        $input['invoice_id'] ='opening-due-'.$input['fk_client_id'];
        
        try {
        if(isset($input['id'])){
            $id=$input['id'];
            $sales= InventoryProductSales::where('id',$id)->update([
            'summary'=>$input['summary'],
            'date'=>$input['date'],
            'total_amount'=>$input['total_amount'],
            'type'=>0,
            'created_by'=>Auth::user()->id
            ]);
        }else{

        $sales= InventoryProductSales::create([
            'fk_client_id'=>$input['fk_client_id'],
            'summary'=>$input['summary'],
            'invoice_id'=>$input['invoice_id'],
            'date'=>$input['date'],
            'total_amount'=>$input['total_amount'],
            'paid_amount'=>0,
            'type'=>0,
            'created_by'=>Auth::user()->id,
            'fk_branch_id'=>Auth::user()->fk_branch_id,
            'fk_company_id'=>Auth::user()->fk_company_id,
            ]);
        }
            $bug = 0;
            
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect()->back()->with('success','Previous due created Successfully.');
        }else{
            return redirect()->back()->with('error','Something Error Found ! Error: '.$bug1);
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
        $clients = InventoryClient::orderBy('id','desc')->where(['fk_branch_id'=>$branchId,'fk_company_id'=>$companyId])->pluck('client_name','id');
        $client = InventoryClient::where('id',$id)->select('id','client_name','client_id','address','mobile_no','email_id')->first();
        $openingDue=InventoryProductSales::where('fk_client_id',$id)->where('type',0)->first();
        return view('pos.clients.opening.index',compact('clients','client','openingDue'));
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
        
          $query  = InventoryProductSales::leftJoin('inventory_branch','inventory_product_sales.fk_branch_id','inventory_branch.id')
        ->leftJoin('inventory_clients','inventory_product_sales.fk_client_id','inventory_clients.id')
        ->select('inventory_product_sales.*','inventory_clients.client_name','branch_name')
        ->where('inventory_product_sales.type',0)
        ->orderBy('inventory_product_sales.id','desc');
        if(Auth::user()->isRole('administrator')){
            $sales=$query;
        }else{
            $sales=$query->where(['inventory_product_sales.fk_branch_id'=>$branchId,'inventory_product_sales.fk_company_id'=>$companyId]);
        }
        return Datatables::of($sales)
            ->addColumn('total_amount', '{{round($total_amount,2)}}')
            ->addColumn('paid_amount', '{{round($paid_amount,2)}}')
            ->addColumn('due_amount', '{{round($total_amount-$paid_amount,2)}}')
            ->addColumn('action', '
                <a href=\'{{URL::to("inventory-client-opening-due/$fk_client_id")}}\' class="btn btn-warning btn-xs"><i class="fa fa-pencil-square"></i></a>
                {!! Form::open(array(\'route\'=> [\'inventory-product-sales.destroy\',$id],\'method\'=>\'DELETE\')) !!}
                    <button type="submit" onclick="return confirmDelete();" class="btn btn-xs btn-danger">
                      <i class="fa fa-trash-o" aria-hidden="true"></i>
                    </button>
                {!! Form::close() !!}
                ')

            ->rawColumns(['action'])
            ->make(true);
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
        //
    }
}
