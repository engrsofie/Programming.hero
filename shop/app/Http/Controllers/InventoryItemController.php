<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\CompanyInfo;
use App\Models\EmailConfig;
use App\Models\TermsCondition;
use App\Models\InventoryProduct;
use App\Models\InventoryCategories;
use App\Models\InventoryUOM;
use App\Models\InventoryBrand;
use App\Models\InventoryClient;
use App\Models\InventoryProductOrder;
use App\Models\InventoryProductOrderItem;
use App\Models\Inventory;
use App\Models\InventoryProductSales;
use App\Models\InventoryProductSalesItem;
use App\Models\InventoryItem;
use App\Models\InventoryBranch;
use App\Models\InventorySalesChallan;
use App\Models\InventorySalesChallanItem;
use Yajra\DataTables\DataTables;
use Validator;
use DB;
use Auth;

class InventoryItemController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $getCompanyData = CompanyInfo::first();
        $branch = InventoryBranch::where('status',1)->pluck('branch_name','id');
        $category = InventoryCategories::where('status',1)->pluck('category_name','id');
        if(isset($request->branch)){
            $branchId = $request->branch;
        }else{
            
            $branchId = Auth::user()->fk_branch_id;
        }
        $categoryId = $request->category;

        $companyId=Auth::user()->fk_company_id;
         $query  = Inventory::join('inventory_product','inventory.fk_product_id','inventory_product.id')
         ->select(DB::raw('SUM(available_qty) as qty'),DB::raw('SUM(available_qty*cost_per_unit) as price'))->orderBy('inventory.id','desc')->where(['inventory.fk_branch_id'=>$branchId,'inventory.fk_company_id'=>$companyId]);
        if($categoryId!=null){
            $query=$query->where('inventory_product.fk_category_id',$categoryId);
        }
        $data= $query->first();

        return view('pos.inventory.viewInventoryItem',compact('getCompanyData','branch','category','branchId','categoryId','data'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Request $request)
    {
        $companyId=Auth::user()->fk_company_id;
        $branchId = $request->branch;
        $category = $request->category;

        $query  = Inventory::join('inventory_product','inventory.fk_product_id','inventory_product.id')
        ->leftJoin('inventory_branch','inventory.fk_branch_id','inventory_branch.id')
        ->leftJoin('inventory_product_model','inventory.fk_model_id','inventory_product_model.id')
        ->leftJoin('inventory_small_unit','inventory_product.fk_small_unit_id','=','inventory_small_unit.id')
        ->select('inventory.*','inventory_product.product_name','inventory_small_unit.small_unit_name','branch_name','model_name')->orderBy('product_name','ASC')->where(['inventory.fk_branch_id'=>$branchId,'inventory.fk_company_id'=>$companyId])->orderBy('available_qty','DESC');
        if($category!=null){
            $query=$query->where('inventory_product.fk_category_id',$category);
        }
        if(Auth::user()->isRole('administrator')){
            $inventory=$query;
        }else{
            $inventory=$query->where(['inventory.fk_branch_id'=>$branchId,'inventory.fk_company_id'=>$companyId]);
        }
        return Datatables::of($inventory)
        ->addColumn('last_qty','')
        ->addColumn('today_sale','')
        ->addColumn('today_qty','')
        ->addColumn('price','')
        ->editColumn('today_qty', function($data){
            $item = InventoryItem::where('fk_inventory_id',$data->id)->whereDate('created_at', '=', date('Y-m-d'))->select('fk_inventory_id',DB::raw('SUM(qty) as today_qty'))->groupBy('fk_inventory_id')->first();
            if($item['today_qty']==null){
               $item['today_qty']=0; 
            }
            return $item['today_qty'].' '.$data->small_unit_name;
        })
        ->editColumn('today_sale', function($data){
            $sales=InventorySalesChallanItem::leftJoin('inventory_product_sales_item','inventory_sales_challan_item.fk_sales_item_id','=','inventory_product_sales_item.id')
            ->leftJoin('inventory_product_sales','inventory_product_sales_item.fk_sales_id','=','inventory_product_sales.id')
            ->where(['fk_product_id'=>$data->fk_product_id,'fk_model_id'=>$data->fk_model_id])
            ->where(['fk_branch_id'=>Auth::user()->fk_branch_id,'fk_company_id'=>Auth::user()->fk_company_id,])
            ->whereDate('inventory_sales_challan_item.created_at', '=', date('Y-m-d'))
            ->select('fk_product_id',DB::raw('SUM(qty) as big_qty'))->groupBy('fk_product_id')
            ->first();
            

                return $sales['big_qty'].' '.$data->small_unit_name;
            

        })
        ->editColumn('available_qty', function($data){
            
                return $data->available_qty.' '.$data->small_unit_name;
        })
        ->editColumn('last_qty', function($data){
            $sales=InventorySalesChallanItem::leftJoin('inventory_product_sales_item','inventory_sales_challan_item.fk_sales_item_id','=','inventory_product_sales_item.id')
           ->where(['fk_product_id'=>$data->fk_product_id,'fk_model_id'=>$data->fk_model_id])
            ->whereDate('inventory_sales_challan_item.created_at', '=', date('Y-m-d'))
            ->select('fk_product_id',DB::raw('SUM(qty) as big_qty'),DB::raw('SUM(inventory_sales_challan_item.small_qty) as small_qty'))->groupBy('fk_product_id')
            ->first();
            $item = InventoryItem::where('fk_inventory_id',$data->id)->whereDate('created_at', '=', date('Y-m-d'))->select('fk_inventory_id',DB::raw('SUM(qty) as today_qty'))->groupBy('fk_inventory_id')->first();
            
                $last_qty=$data->available_qty+$sales['big_qty']-$item['today_qty'];
                return $last_qty.' '.$data->small_unit_name;
            
           


        })
        ->editColumn('price', function($data){
            
                return round($data->available_qty*$data->cost_per_unit,3);
            

        })
        
        ->rawColumns(['price','today_qty','last_qty'])
        ->make(true);
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
        //
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
        $getInventory = Inventory::findOrFail($id);
        $validator = Validator::make($request->all(),[
                'sales_per_unit' => 'required'
        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }

        $input = $request->all();
        try {
            $getInventory->update($input);
            
            $bug = 0;
            
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect()->back()->with('success','Product Price Updated Successfully.');
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
        //
    }
    public function totalInventory(Request $request)
    {
        $companyId=Auth::user()->fk_company_id;
        $branchId=$request->branch;
        $category=$request->category;
         $query  = Inventory::join('inventory_product','inventory.fk_product_id','inventory_product.id')
         ->select(DB::raw('SUM(available_qty) as qty'),DB::raw('SUM(available_qty*sales_per_unit) as price'))->orderBy('inventory.id','desc')->where(['inventory.fk_branch_id'=>$branchId,'inventory.fk_company_id'=>$companyId]);
        if($category!=null){
            $query=$query->where('inventory_product.fk_category_id',$category);
        }
        $data= $query->first();
        return $data;
    }
}
