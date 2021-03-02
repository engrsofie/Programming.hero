<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\InventoryProduct;
use App\Models\InventoryCategories;
use App\Models\InventoryUOM;
use App\Models\InventoryBrand;
use App\Models\InventorySmallUnit;
use Validator;
use Auth;

class InventoryProductController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {   
        
        $getProductData = InventoryProduct::leftJoin('product_category','inventory_product.fk_category_id','product_category.id')->select('inventory_product.*','product_category.category_name')->orderBy('id','desc')->paginate(25);
        $smallUnit = InventorySmallUnit::where('status','1')->get();
        $getCategories = InventoryCategories::where('status','1')->get();
        return view('pos.products.viewProducts', compact('getProductData','getBrand','getCategories','smallUnit'));
        
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $getUOM = InventoryUOM::where('status','1')->get();
        $smallUnit = InventorySmallUnit::where('status','1')->get();
        $getCategories = InventoryCategories::where('status','1')->get();
        return view('pos.products.index' ,compact('getUOM','getCategories','smallUnit'));
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
                'product_name' => 'required|unique:inventory_product',
                'category' => 'required',

        ]);
        if($validator->fails()){
            return "Error Found";
        }

        $input['product_id'] = "p-".rand(1,1000);
        
        try {
            InventoryProduct::create([
                'fk_category_id'=>$input['category'],
                'fk_small_unit_id'=>$input['unit'],
                'product_id'=>$input['product_id'],
                'product_name'=>$input['product_name'],
                'stock_limitation'=>0,
                'status'=>$input['status'],
                'created_by'=>Auth::user()->id,

            ]); 
            $bug = 0;
            
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return 'New product Created Successfully.';
        }else{
            return 'Something Error Found !, Please try again.';
        }
        /*if($bug == 0){
            return redirect('inventory-product/create')->with('success','New product Created Successfully.');
        }else{
            return redirect('inventory-product/create')->with('error','Something Error Found !, Please try again.'.$bug1);
        }*/

    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $data=InventoryProduct::where('product_name',$id)->first();
        if($data!=null){
            return 'Name already Exists!';
        }else{
            return 'Use This Name';
        }
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
         $productData = InventoryProduct::findOrFail($id);
        $validator = Validator::make($request->all(),[
                'product_name' => "required|unique:inventory_product,product_name,$id",
                'fk_category_id' => 'required'

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }

        $input = $request->all();
           
        try {
            $productData->update($input);
            $bug = 0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect("inventory-product")->with('success','product Info Updated successFully.');
        }else{
            return redirect("inventory-product")->with('error','Something Error Found !, Please try again.'.$bug1);
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
        $productData = InventoryProduct::findOrFail($id);
        
        try {
            
            $productData->delete();
            $bug = 0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect('inventory-product')->with('success', 'product Info Deleted Successfully .');
        }elseif($bug == 1451){
                return redirect('inventory-product')->with('error','This Data Used AnyWhere.');
            }else{
            return redirect('inventory-product')->with('error','Something Error Found !, Please try again.'.$bug1);
        }


    }

}
