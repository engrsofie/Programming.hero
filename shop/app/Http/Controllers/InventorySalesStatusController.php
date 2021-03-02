<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\CompanyInfo;
use App\Models\InventoryProductSales;
use App\Models\InventoryProductSalesItem;
use App\Models\InventoryBrand;
use App\Models\InventoryClient;
use App\Models\InventoryBranch;
use DB;
use Auth;

class InventorySalesStatusController extends Controller
{
    public function daily(Request $request){
        date_default_timezone_set('Asia/Dhaka');
        $input=$request->all();
        $companyId=Auth::user()->fk_company_id;
        $query=InventoryClient::where(['client_status'=>1]);
        if(Auth::user()->isRole('administrator')){
            if(isset($request->branch)){
                $query=$query->where('fk_branch_id',$request->branch);
            }
                $clients=$query->pluck('company_name','id');
        }else{
            $clients=$query->where(['fk_branch_id'=>Auth::user()->fk_branch_id,'fk_company_id'=>$companyId])->pluck('company_name','id');
        }
        if(!isset($request->start)){
            $request=array(
                'start' => date('Y-m-d'),
                'end' => date('Y-m-d'),
                'branch' => '',
                'client' => '',
            );
            $request = (object) $request;
        }
        $mainData = $this->dailyResult($request);
        $branch = InventoryBranch::where('status',1)->pluck('branch_name','id');
        $companyInfo = CompanyInfo::first();
      return view('pos.status.daily',compact('mainData','clients','companyInfo','branch','input'));
    }

    static public function dailyResult($request){

        date_default_timezone_set('Asia/Dhaka');
        $start=$request->start;
        $end=$request->end;
        if(Auth::user()->isRole('administrator')){
        $branch=$request->branch;

        }else{
            
        $branch=Auth::user()->fk_branch_id;
        }
        $client=$request->client;
        $query=InventoryProductSalesItem::leftJoin('inventory_product_sales','inventory_product_sales_item.fk_sales_id','inventory_product_sales.id')
        ->leftJoin('inventory_product','inventory_product_sales_item.fk_product_id','inventory_product.id')
        ->leftJoin('product_brand','inventory_product.fk_brand_id','product_brand.id')
        ->groupBy('inventory_product_sales_item.fk_product_id')
        ->whereBetween('inventory_product_sales.date', [$start, $end]);
        if($branch>0){
            $query=$query->where('inventory_product_sales.fk_branch_id',$branch);
        }
        if($client>0){
            $query=$query->where('inventory_product_sales.fk_client_id',$client);
        }
        $allData=$query->select('inventory_product.product_name','product_brand.brand_name','inventory_product_sales_item.fk_product_id',DB::raw('SUM(inventory_product_sales_item.sales_qty) as total_qty'),DB::raw('SUM(inventory_product_sales_item.product_paid_amount) as total_amount'))
        ->get();

        $amount=InventoryProductSales::leftJoin('inventory_clients','inventory_product_sales.fk_client_id','inventory_clients.id')->leftJoin('inventory_branch','inventory_product_sales.fk_branch_id','inventory_branch.id')->select('inventory_clients.company_name as client_name','inventory_clients.company_name',DB::raw('SUM(total_amount) as total_amount'),DB::raw('SUM(paid_amount) as paid_amount'),'branch_name')
        ->whereBetween('inventory_product_sales.date', [$start, $end])->where('inventory_product_sales.type',null);
        if($branch>0){
            $amount=$amount->where('inventory_product_sales.fk_branch_id',$branch);
        }
        if($client>0){
            $amount=$amount->where('inventory_product_sales.fk_client_id',$client);
        }
    $total=$amount->first();
    $filterData=array(
        'start'=>date('d-M-Y',strtotime($start)),
        'end'=>date('d-M-Y',strtotime($end)),
        'client'=>$client,
        'branch'=>$branch,
        );
      return view('pos.status.loadResult',compact('allData','total','filterData'));
    }
    /*CLient Name Wise Sales Report*/
    public function dailySales(Request $request){
    	date_default_timezone_set('Asia/Dhaka');
        $fullUrl=explode('?',$request->fullUrl());
          if(count($fullUrl)==1){
            return redirect($request->path().'?branch='.Auth::user()->fk_branch_id);
          }
        $input=$request->all();
        $companyId=Auth::user()->fk_company_id;
    	$query=InventoryClient::where(['client_status'=>1]);
        if(Auth::user()->isRole('administrator')){
            if(isset($request->branch)){
                $query=$query->where('fk_branch_id',$request->branch);
            }
                $clients=$query->pluck('company_name','id');
        }else{
            $clients=$query->where(['fk_branch_id'=>Auth::user()->fk_branch_id,'fk_company_id'=>$companyId])->pluck('company_name','id');
        }
       
        $mainData = $this->dailySalesResult($request);
        $branch = InventoryBranch::where('status',1)->pluck('branch_name','id');
    	$companyInfo = CompanyInfo::first();
      return view('pos.status.clientWise.daily',compact('mainData','clients','companyInfo','branch','input'));
    }

    static public function dailySalesResult($request){

    	date_default_timezone_set('Asia/Dhaka');
        if(isset($request->start)){
      	 $start=$request->start;
         $end=$request->end;
        }else{
            $start=date('Y-m-d');
            $end=date('Y-m-d');
            
        }
        if(Auth::user()->isRole('administrator')){
            $branch=$request->branch;

        }else{
            
        $branch=Auth::user()->fk_branch_id;
        }
        if(isset($request->client)){
        $client=$request->client;
        }else{
            
      	$client=0;
        }
    	$query=InventoryProductSales::leftJoin('inventory_clients','inventory_product_sales.fk_client_id','inventory_clients.id')->leftJoin('inventory_branch','inventory_product_sales.fk_branch_id','inventory_branch.id')->select('inventory_clients.company_name as client_name',DB::raw('SUM(total_amount) as total_amount'),DB::raw('SUM(paid_amount) as paid_amount'),DB::raw('SUM(discount) as discount'),'branch_name')
        ->whereBetween('inventory_product_sales.date', [$start, $end])->where('inventory_product_sales.type',null)->groupBy('inventory_product_sales.fk_client_id');
        if($branch>0){
            $query=$query->where('inventory_product_sales.fk_branch_id',$branch);
        }
        if($client>0){
            $query=$query->where('inventory_product_sales.fk_client_id',$client);
        }
    	$allData=$query->get();

    	$amount=InventoryProductSales::leftJoin('inventory_clients','inventory_product_sales.fk_client_id','inventory_clients.id')->leftJoin('inventory_branch','inventory_product_sales.fk_branch_id','inventory_branch.id')->select('inventory_clients.company_name as client_name',DB::raw('SUM(total_amount) as total_amount'),DB::raw('SUM(paid_amount) as paid_amount'),DB::raw('SUM(discount) as discount'),'branch_name')
    	->whereBetween('inventory_product_sales.date', [$start, $end])->where('inventory_product_sales.type',null);
    	if($branch>0){
            $amount=$amount->where('inventory_product_sales.fk_branch_id',$branch);
        }
        if($client>0){
    		$amount=$amount->where('inventory_product_sales.fk_client_id',$client);
    	}
        $total=$amount->first();
        $filterData=array(
        	'start'=>date('d-M-Y',strtotime($start)),
        	'end'=>date('d-M-Y',strtotime($end)),
            'client'=>$client,
        	'branch'=>$branch,
        	);
      return view('pos.status.clientWise.loadResult',compact('allData','total','filterData'));
	}

    public function loadClient($id){
        $clients=InventoryClient::where(['client_status'=>1,'fk_branch_id'=>$id])->pluck('company_name','id');
        if($id==0){
             $clients=InventoryClient::where(['client_status'=>1])->pluck('company_name','id');
        }
        return view('pos.status.loadClient',compact('clients'));
    }

    public function monthlyResult(){}

}
