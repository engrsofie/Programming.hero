<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Inventory;
use App\Models\InventoryItem;
use App\Models\InventoryStockPosition;
use Validator;
use DB;
use Auth;

class InventoryProductOpeningController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $allData=InventoryItem::leftJoin('inventory','inventory_item.fk_inventory_id','inventory.id')
        ->leftJoin('inventory_product','inventory.fk_product_id','inventory_product.id')
        ->where('inventory_item.type',1)->select('inventory_item.*','inventory_product.product_name','inventory_product.product_id','inventory.id as inventory_id')
        ->get();
        return view('pos.product_order.opening.index',compact('allData'));
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
        $stockPosition=InventoryStockPosition::where('status',1)->where(['fk_branch_id'=>$branchId,'fk_company_id'=>$companyId])->pluck('position_name','id');
        
        return view('pos.product_order.opening.create',compact('stockPosition'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $branchId=Auth::user()->fk_branch_id;
        $companyId=Auth::user()->fk_company_id;
        $input=$request->except('_token');
        $validator = Validator::make($request->all(),[
            'fk_product_id' => 'required',
            'fk_stock_position_id' => 'required'

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }
        DB::beginTransaction();
        for ($i=0; $i <sizeof($input['fk_product_id']) ; $i++) { 
                $product_id = $input['fk_product_id'][$i];
                $cost_per_unit = $input['cost_per_unit'][$i];
                $sales_per_unit = $input['sales_per_unit'][$i];
                $qty = $input['qty'][$i];
                $fk_stock_position_id = $input['fk_stock_position_id'][$i];
              
                $searchInventory = Inventory::
                leftJoin('inventory_item','inventory.id','inventory_item.fk_inventory_id')
                ->where(['fk_product_id'=>$product_id,'inventory.fk_branch_id'=>$branchId,'inventory.fk_company_id'=>$companyId])->select('inventory_item.brach_no','inventory_item.fk_inventory_id','inventory.available_qty','inventory.sales_per_unit')->orderBy('inventory_item.id','desc')->first();
                if($searchInventory!=null){
                    $old_brach_no = $searchInventory->brach_no;
                    $last_no =  explode('-', $old_brach_no);
                    $new_no = $last_no[2]+1;
                    $brach_no = "B-".$product_id."-".$new_no.'-'.$branchId.'-'.$companyId;
                    $getInventory = Inventory::where('fk_product_id',$product_id)->first();
                    $availableQty = floatval($searchInventory->available_qty)+floatval($qty);
                    $inventoryUpdateQty = array(
                        'available_qty' => $availableQty,
                        'sales_per_unit' => $sales_per_unit,
                        'updated_at' => date('Y-m-d h:i:s')
                        );
                    $getInventory->update($inventoryUpdateQty);
                    $inventory_id = $searchInventory->fk_inventory_id;
                }else{
                    $brach_no = "B-".$product_id."-1".'-'.$branchId.'-'.$companyId;
                    $addToInventoryItem = [
                        'fk_product_id'  => $product_id,
                        'available_qty'  => $qty,
                        'sales_per_unit' => $sales_per_unit,
                        'fk_branch_id'=>$branchId,
                        'fk_company_id'=>$companyId,
                    ]; 
                    $inventory_id = Inventory::create($addToInventoryItem)->id; 
                }
                $addToInventoryItems = [
                    'fk_inventory_id'=> $inventory_id,
                    'brach_no'       => $brach_no,
                    'qty'            => $qty,
                    'available_qty'  => $qty,
                    'cost_per_unit'  => $cost_per_unit,
                    'sales_per_unit' => $sales_per_unit,
                    'fk_stock_position_id' => $fk_stock_position_id,
                    'summary' => $input['summary'],
                    'type' => 1,
                    'fk_branch_id'=>$branchId,
                    'fk_company_id'=>$companyId,
                ]; 
                //return $addToInventory;exit;
                InventoryItem::create($addToInventoryItems); 
            } 
        try{

            DB::commit();
            $bug = 0;
            
        } catch (\Exception $e) {
            DB::rollback();
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){

            return redirect('inventory-product-opening')->with('success','Successfully added to Inventory .');
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
        $inventoryItem=InventoryItem::where('id',$id)->first();
        $inventory=Inventory::where('id',$inventoryItem->fk_inventory_id)->first();
        //return $inventory;
        $inventory->update([
            'available_qty'=>$inventory->available_qty-$inventoryItem->qty+$input['qty'],
            'cost_per_unit'  => $input['cost_per_unit'],
            'sales_per_unit' => $input['sales_per_unit'],
            ]);
        $inventoryItem->update([
            'qty'=>$input['qty'],
            'cost_per_unit'  => $input['cost_per_unit'],
            'sales_per_unit' => $input['sales_per_unit'],
            ]);
        return redirect()->back()->with('success','Updated Successfully!');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $inventoryItem=InventoryItem::where('id',$id)->first();
        $inventory=Inventory::where('id',$inventoryItem->fk_inventory_id)->first();
        //return $inventory;
        $inventory->update([
            'available_qty'=>$inventory->available_qty-$inventoryItem->qty,
            ]);
        $inventoryItem->delete();
        return redirect()->back()->with('success','Deleted Successfully!');
    }
}
