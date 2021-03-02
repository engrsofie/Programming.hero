<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\User;
use App\Models\InventoryClient;
use App\Models\InventoryProductSales;
use App\Models\InventoryProductSalesItem;
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

class InventoryProductReturnController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Request $request)
    {

        $branchId=Auth::user()->fk_branch_id;
        $companyId=Auth::user()->fk_company_id;
        $clients = InventoryClient::orderBy('id','desc')->where(['fk_branch_id'=>$branchId,'fk_company_id'=>$companyId])->pluck('company_name','id');
        if(isset($request->id)){
            $client = InventoryClient::where('id',$request->id)->select('id','client_name','company_name','client_id','address','mobile_no','email_id')->first();
            $from=date('Y-m-d',strtotime($request->from));
            $to=date('Y-m-d',strtotime($request->to));
            $sales=InventoryProductSales::whereBetween('date',[$from,$to])->where('fk_client_id',$request->id)->get();
        }
        return view('pos.return.index',compact('clients','sales','client'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
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
       $getInvoiceData = InventoryProductSales::
        leftJoin('inventory_clients','inventory_product_sales.fk_client_id','=','inventory_clients.id')
        ->where('inventory_product_sales.id',$id)
        ->select('inventory_product_sales.id','inventory_product_sales.shipping_address','inventory_product_sales.invoice_id','inventory_product_sales.summary','inventory_product_sales.date','inventory_product_sales.total_amount','inventory_product_sales.paid_amount','inventory_product_sales.discount','inventory_clients.client_id','inventory_clients.client_name','inventory_clients.mobile_no','inventory_clients.address','inventory_clients.email_id','inventory_clients.company_name','prev_amount','prev_paid')
        ->first();
        if($getInvoiceData==null){
            return redirect()->back();
        }
        $getProductData = InventoryProductSalesItem::
        leftJoin('inventory_product_sales','inventory_product_sales_item.fk_sales_id','=','inventory_product_sales.id')
        ->leftJoin('inventory_product','inventory_product_sales_item.fk_product_id','=','inventory_product.id')
        ->leftJoin('inventory_product_model','inventory_product_sales_item.fk_model_id','=','inventory_product_model.id')
        ->leftJoin('inventory_small_unit','inventory_product.fk_small_unit_id','=','inventory_small_unit.id')
        ->where('inventory_product_sales.id',$id)
        ->select('inventory_product_sales_item.id','inventory_product_sales_item.product_price_amount','inventory_product_sales_item.sales_qty','inventory_product_sales_item.small_qty','inventory_product_sales_item.product_wise_discount','inventory_product_sales_item.product_paid_amount','inventory_product.product_name','inventory_product.specification','inventory_small_unit.small_unit_name','model_name')
        ->get();
        $payment=InventorySalesPaymentHistoryItem::leftJoin('inventory_payment_history','inventory_payment_history_item.fk_payment_id','inventory_payment_history.id')->where(['fk_sales_id'=>$id,'inventory_payment_history.type'=>1])->select('inventory_payment_history.*')->first();
        if($payment==null){
            $anotherPayment=InventorySalesPaymentHistoryItem::where(['fk_sales_id'=>$id])->first();
            if($anotherPayment!=null){
                return redirect()->back();
            }
        }
        $users=User::where(['fk_branch_id'=>$branchId,'fk_company_id'=>$companyId])->pluck('name','id');
        $account=AccountSetting::where('account_status',1)->pluck('account_name','id');
        $method=PaymentMethod::where('method_status',1)->pluck('method_name','id');
        return view('pos.return.show', compact('getInvoiceData','getProductData','users','account','method','payment'));
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
        //
    }
}
