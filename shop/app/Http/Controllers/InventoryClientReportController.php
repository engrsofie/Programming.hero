<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\InventoryClient;
use App\Models\InventorySupplier;
use App\Models\InventoryProductSales;
use App\Models\InventoryProductSalesItem;
use App\Models\InventoryProductOrder;
use App\Models\InventoryBranch;
use App\Models\InventorySalesPaymentHistory;
use App\Models\InventoryProductAdd;

use Validator;
use DB;
use Auth;

class InventoryClientReportController extends Controller
{
    public function index(){
        $companyId=Auth::user()->fk_company_id;
        $query=InventoryClient::where(['client_status'=>1]);
        if(Auth::user()->isRole('administrator')){
                $clients=$query->pluck('company_name','id');
        }else{
            $clients=$query->where(['fk_branch_id'=>Auth::user()->fk_branch_id,'fk_company_id'=>$companyId])->pluck('company_name','id');
        }
        $branch = InventoryBranch::where('status',1)->pluck('branch_name','id');
        return view('pos.report.client.index',compact('clients','branch'));
    }
    public function show(Request $request){
        $companyId=Auth::user()->fk_company_id;
        $input=$request->except('_token');
        $branch = InventoryBranch::where('status',1)->pluck('branch_name','id');
        $query=InventoryClient::where(['client_status'=>1]);
        if(Auth::user()->isRole('administrator')){
            if(isset($request->branch)){
                $query=$query->where('fk_branch_id',$request->branch);
            }
                $clients=$query->pluck('company_name','id');
        }else{
            $clients=$query->where(['fk_branch_id'=>Auth::user()->fk_branch_id,'fk_company_id'=>$companyId])->pluck('company_name','id');
        }
        $client = InventoryClient::where('id',$request->id)->select('company_name','client_id','address','mobile_no','email_id')->first();

        $prev=InventoryProductSales::select(DB::raw('SUM(total_amount) as total_amount'),DB::raw('SUM(paid_amount) as paid_amount'))
        ->where('fk_client_id',$request->id)
        ->where('date','<',$request->start_date)
        ->first();
        $next=InventoryProductSales::select(DB::raw('SUM(total_amount) as total_amount'),DB::raw('SUM(paid_amount) as paid_amount'))
        ->where('fk_client_id',$request->id)
        ->where('date','>',$request->end_date)
        ->first();
        $report  = InventoryProductSales::select('id','invoice_id','date','total_amount','paid_amount')
        ->where('fk_client_id',$request->id)
        ->whereBetween('date',[$request->start_date,$request->end_date,])
        ->orderBy('inventory_product_sales.id','ASC')
        ->get();
        foreach($report as $key1=> $rep){
            $result= InventoryProductSalesItem::leftJoin('inventory_product','inventory_product_sales_item.fk_product_id','inventory_product.id')->where('fk_sales_id',$rep->id)->select('product_name','sales_qty','product_price_amount','product_wise_discount','product_paid_amount')->get();
            $text='';
            $qty='';
            $subTotal='';
            $commission='';
            $price='';
            foreach($result as $key => $res){
                $text=($key>0)?$text.'<hr>'.$res->product_name:$res->product_name;
                $qty=($key>0)?$qty.'<hr>'.$res->sales_qty:$res->sales_qty;
                $price=($key>0)?$price.'<hr>'.round($res->product_price_amount,3):round($res->product_price_amount,3);
                $subTotal=($key>0)?$subTotal.'<hr>'.round($res->product_paid_amount,3):round($res->product_paid_amount,3);
                $commission=($key>0)?$commission.'<hr>'.round($res->product_wise_discount,3):round($res->product_wise_discount,3);
            }
            $report[$key1]['product']=$text;
            $report[$key1]['qty']=$qty;
            $report[$key1]['price']=$price;
            $report[$key1]['subTotal']=$subTotal;
            $report[$key1]['commission']=$commission;
        }
        return view('pos.report.client.index',compact('report','client','prev','next','input','clients','branch'));
    }
    public function supplier(){
    	$supplier = InventorySupplier::orderBy('id','desc')->pluck('company_name','id');
    	return view('pos.report.supplier.index',compact('supplier'));
    }
    public function supplierReport(Request $request){
        $input=$request->except('_token');
        $supplier = InventorySupplier::orderBy('id','desc')->pluck('company_name','id');
    	$supplierInfo = InventorySupplier::where('id',$request->id)->select('company_name','supplier_id','address','mobile_no','email_id')->first();
    	$prev=InventoryProductAdd::select(DB::raw('SUM(total_amount) as total_amount'),DB::raw('SUM(total_paid) as total_paid'))
        ->where('fk_supplier_id',$request->id)
        ->where('date','<',$request->start_date)
        ->first();
        $next=InventoryProductAdd::select(DB::raw('SUM(total_amount) as total_amount'),DB::raw('SUM(total_paid) as total_paid'))
        ->where('fk_supplier_id',$request->id)
        ->where('date','>',$request->end_date)
        ->first();
    	$report = InventoryProductAdd::select('inventory_order_id','date','total_amount','total_paid')
        ->where('fk_supplier_id',$request->id)
        ->whereBetween('date',[$request->start_date,$request->end_date,])
        ->orderBy('id','ASC')
        ->where('total_amount','>',0)
        ->get();
        return view('pos.report.supplier.index',compact('report','supplierInfo','prev','next','supplier','input'));
    }

    public function loadClient($id){
        $clients=InventoryClient::where(['client_status'=>1,'fk_branch_id'=>$id])->pluck('company_name','id');
        if($id==0){
             $clients=InventoryClient::where(['client_status'=>1])->pluck('company_name','id');
        }
        return view('pos.report.client.loadClients',compact('clients'));
    }

    public function account(Request $request){
        $companyId=Auth::user()->fk_company_id;
        $query=InventoryClient::where(['client_status'=>1]);
        if(Auth::user()->isRole('administrator')){
                $clients=$query->pluck('company_name','id');
        }else{
            $clients=$query->where(['fk_branch_id'=>Auth::user()->fk_branch_id,'fk_company_id'=>$companyId])->pluck('company_name','id');
        }
        $branch = InventoryBranch::where('status',1)->pluck('branch_name','id');
        $reports = '';
        $input = [];
        if(isset($request->id)){
        $input=$request->all();
            $reports=$this->accountShow($request);
        }
        return view('pos.report.clientAccount.index',compact('clients','branch','reports','input'));
    }
   static public function accountShow($request){
        $input=$request->all();
        $companyId=Auth::user()->fk_company_id;
       
        $client = InventoryClient::where('id',$request->id)->select('company_name','client_id','address','mobile_no','email_id')->first();

        $prev=InventoryProductSales::select(DB::raw('SUM(total_amount) as total_amount'),DB::raw('SUM(paid_amount) as paid_amount'))
        ->where('fk_client_id',$request->id)
        ->where('date','<',$request->start_date)
        ->first();
        $next=InventoryProductSales::select(DB::raw('SUM(total_amount) as total_amount'),DB::raw('SUM(paid_amount) as paid_amount'))
        ->where('fk_client_id',$request->id)
        ->where('date','>',$request->end_date)
        ->first();
        $report  = InventoryProductSales::select('id','invoice_id','date','total_amount','paid_amount')
        ->where('fk_client_id',$request->id)
        ->whereBetween('date',[$request->start_date,$request->end_date,])
        ->orderBy('inventory_product_sales.id','ASC')
        ->get();
        $payment  = InventorySalesPaymentHistory::select('id','invoice_id','payment_date','total_amount','paid')
        ->where('fk_client_id',$request->id)
        ->whereBetween('payment_date',[$request->start_date,$request->end_date,])
        ->orderBy('id','ASC')
        ->get();
        foreach($report as $key => $rep){
            foreach ($payment as $key1 => $value) {
                if($rep->invoice_id==$value->invoice_id){
                    $report[$key]['paid']=$value->paid;
                    unset($payment[$key1]);
                }
            }
        }
        
        return view('pos.report.clientAccount.loadReport',compact('report','client','prev','next','input','branch','payment'));
    }


}
