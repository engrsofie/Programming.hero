<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\InventoryClient;
use App\Models\InventoryProduct;
use App\Models\InventoryProductSalePrice;
use App\Models\Inventory;
use Validator;
use Auth;

class InventoryProductSalePriceController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $clients = InventoryClient::where('client_status','1')->where('client_type','0')->pluck('client_name','id');
        
        return view('pos.salePrice.create',compact('clients'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
       $input= $request->except('_token');
       $validator = Validator::make($request->all(),[
                'fk_client_id' => 'required',
                'product_id' => 'required'

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }
        for ($i=0; $i <sizeof($input['product_id']) ; $i++) { 
                if($input['sales_price'][$i]>0){
                    InventoryProductSalePrice::create([
                        'fk_client_id'  => $input['fk_client_id'],
                        'fk_product_id' => $input['product_id'][$i],
                        'sale_price'    => $input['sales_price'][$i],
                        'created_by'    => Auth::user()->id

                        ]); 
                }
            }
            if(isset($input['sale_price_id'])){
                for ($j=0; $j <sizeof($input['sale_price_id']) ; $j++) { 
                    $salePriceId=$input['sale_price_id'][$j];
                    $clientId=$input['fk_client_id'];
                    $productId=$input['fk_product_id'][$j];
                     InventoryProductSalePrice::where('id',$salePriceId)->where('fk_client_id',$clientId)->where('fk_product_id',$productId)->update([
                        'sale_price'    => $input['old_sales_price'][$j],
                        'updated_by'    => Auth::user()->id

                        ]); 
                }
            }
        try {
            
            
            $bug = 0;
            
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect()->back()->with('success','Created Successfully.');
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
        $clients = InventoryClient::where('client_status','1')->where('client_type','0')->pluck('client_name','id');
        $products = Inventory::leftJoin('inventory_product','inventory.fk_product_id','=','inventory_product.id')->select('inventory_product.*','sales_per_unit')->orderBy('id','desc')->get();
        $salePrice=InventoryProductSalePrice::where('fk_client_id',$id)->get();
        foreach ($products as $key => $value) {
            foreach ($salePrice as $price) {
                if($value->id==$price->fk_product_id){
                    $products[$key]['sale_price']=$price->sale_price;
                    $products[$key]['sale_price_id']=$price->id;
                }
            }
        }
        return view('pos.salePrice.products',compact('clients','products','id'));
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
