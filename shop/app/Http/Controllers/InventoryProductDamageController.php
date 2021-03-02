<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Inventory;
use App\Models\InventoryItem;
use App\Models\InventoryStockPosition;
use Validator;
use DB;
use Auth;

class InventoryProductDamageController extends Controller
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
        ->where('inventory_item.type',0)->select('inventory_item.*','inventory_product.product_name','inventory_product.product_id','inventory.id as inventory_id')
        ->get();
        return view('pos.damage.index',compact('allData'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $stockPosition=InventoryStockPosition::where('status',1)->pluck('position_name','id');
        
        return view('pos.damage.create',compact('stockPosition'));
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

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }
        DB::beginTransaction();
        for ($i=0; $i <sizeof($input['fk_product_id']) ; $i++) { 
                $product_id = $input['fk_product_id'][$i];
                $model = $input['fk_model_id'][$i];
                $qty = $input['qty'][$i];
                $checkQty=0;
                    $stockData=array();
                    $stock=InventoryItem::leftJoin('inventory','inventory_item.fk_inventory_id','inventory.id')
                        ->where(['inventory.fk_product_id'=>$product_id,'inventory.fk_model_id'=>$model,'inventory.fk_branch_id'=>$branchId,'inventory.fk_company_id'=>$companyId])
                        ->where('inventory_item.available_qty','!=',0)
                        ->where('inventory_item.type','!=',0)
                        ->select('inventory_item.id','inventory_item.available_qty','inventory_item.cost_per_unit')
                        ->orderBy('inventory_item.id','ASC')->chunk(1, function ($data) use(&$stockData,$checkQty,$qty) {
                            foreach($data as $key=> $dt){
                                $stockData[]=['id'=>$dt->id,'available_qty'=>$dt->available_qty,'cost_per_unit'=>$dt->cost_per_unit];
                                $checkQty=floatVal($checkQty)+floatVal($dt->available_qty);
                            }
                            if($checkQty>$qty){
                                return false;
                            }
                        }); 
                        $price=0;
                        $totalQty=$qty;
                        $inventory_Id=array();
                        foreach ($stockData as $value) {
                            if($value['available_qty']>=$totalQty){
                                InventoryItem::where('id',$value['id'])->update([
                                    'available_qty'=>$value['available_qty']-$totalQty,
                                ]);
                                $price+=$value['cost_per_unit']*$totalQty;
                                $inventory_Id[$value['id']]=$totalQty;
                                $totalQty=$totalQty-$totalQty;
                            }else{
                                InventoryItem::where('id',$value['id'])->update([
                                    'available_qty'=>0,
                                ]);
                                $totalQty=$totalQty-$value['available_qty'];
                            $price+=$value['cost_per_unit']*$value['available_qty'];
                            $inventory_Id[$value['id']]=$value['available_qty'];
                            }
                        }
                    $inventoryId=json_encode($inventory_Id);
                $searchInventory = Inventory::
                leftJoin('inventory_item','inventory.id','inventory_item.fk_inventory_id')
                ->where(['fk_product_id'=>$product_id,'fk_model_id'=>$model,'inventory.fk_branch_id'=>$branchId,'inventory.fk_company_id'=>$companyId])->select('inventory_item.brach_no','inventory_item.fk_inventory_id','inventory.available_qty','inventory.sales_per_unit')->orderBy('inventory_item.id','desc')->first();
                $sales_per_unit = $searchInventory['sales_per_unit'];
                $cost_per_unit = $searchInventory['cost_per_unit'];
                if($searchInventory!=null){
                    $old_brach_no = $searchInventory->brach_no;
                    $getInventory = Inventory::where(['fk_product_id'=>$product_id,'fk_model_id'=>$model,'inventory.fk_branch_id'=>$branchId,'inventory.fk_company_id'=>$companyId])->first();
                    $availableQty = floatval($searchInventory->available_qty)-floatval($qty);
                    $inventoryUpdateQty = array(
                        'available_qty' => $availableQty,
                        'sales_per_unit' => $sales_per_unit,
                        'updated_at' => date('Y-m-d h:i:s')
                        );
                    $getInventory->update($inventoryUpdateQty);
                    $inventory_id = $searchInventory->fk_inventory_id;
                }else{
                   return redirect('inventory-product-damage')->with('error','Product Not available.');
                }
                $addToInventoryItem = [
                    'fk_inventory_id'=> $inventory_id,
                    'brach_no'       => $old_brach_no.'-d',
                    'qty'            => $qty,
                    'cost_per_unit'  => $cost_per_unit,
                    'sales_per_unit' => $sales_per_unit,
                    'summary' => $inventoryId,
                    'type' => 0,
                    'fk_branch_id'=>$branchId,
                    'fk_company_id'=>$companyId,

                ]; 
                //return $addToInventory;exit;
                InventoryItem::create($addToInventoryItem); 
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

            return redirect('inventory-product-damage')->with('success','Successfully added to Inventory .');
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
    public function show(Request $request, $id)
    {
        $branchId=Auth::user()->fk_branch_id;
        $companyId=Auth::user()->fk_company_id;
        $name = $request->get('name_startsWith'); 
        
        $data = array();
        
        $result = Inventory::
            leftJoin('inventory_product','inventory.fk_product_id','=','inventory_product.id')
            ->leftJoin('inventory_product_model','inventory.fk_model_id','=','inventory_product_model.id')
            ->leftJoin('inventory_small_unit','inventory_product.fk_small_unit_id','=','inventory_small_unit.id')
            ->where('inventory.available_qty','>',0)
            ->where('inventory_product.product_name', 'LIKE', '%'. $name .'%')
            ->where(['inventory.fk_branch_id'=>$branchId,'inventory.fk_company_id'=>$companyId])
            ->select('inventory_product.barcode','inventory_product.id as product_id','inventory_product.product_name','inventory_product.id','inventory_small_unit.small_unit_name','inventory.available_qty','inventory.available_small_qty','inventory.sales_per_unit','inventory.id as inventory_id','model_name','fk_model_id')
            ->orderBy('inventory.id','asc')
            ->get();
        $getResult = $result->toArray();
        foreach ($getResult as $row) {
            $product_result = $row['product_name'].'('.$row['model_name'].')'.'|'.$row['id'].'|'.$row['available_qty'].'|'.$row['small_unit_name'].'|'.$row['fk_model_id'];
            array_push($data, $product_result);
        }
        //return $name;exit;
          
        return json_encode($data);exit;   
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
        $branchId=Auth::user()->fk_branch_id;
        $companyId=Auth::user()->fk_company_id;
        $input=$request->except('_token','_method');
        $inventoryItem=InventoryItem::leftJoin('inventory','inventory_item.fk_inventory_id','inventory.id')->where('inventory_item.id',$id)->first();
        $productId = $inventoryItem->fk_product_id;
        $model = $inventoryItem->fk_model_id;
        $qty = $input['qty'];
         /*Update old Inventory*/
        $inventoryIds=json_decode($inventoryItem->summary,true);
        if(count($inventoryIds)>0){
            foreach ($inventoryIds as $invId => $invValue) {
               $invenItem = InventoryItem::where('id',$invId)->first();
               if($invenItem!=null){ 
                   $invenItem->update([
                    'available_qty'=>$invenItem->available_qty+$invValue
                   ]);
               }
            }
        }/*/Update old Inventory*/
        /*Decrease product qty from First Branch*/
                $checkQty=0;
                $stockData=array();
                $stock=InventoryItem::leftJoin('inventory','inventory_item.fk_inventory_id','inventory.id')
                    ->where(['inventory.fk_product_id'=>$productId,'inventory.fk_model_id'=>$model,'inventory.fk_branch_id'=>$branchId,'inventory.fk_company_id'=>$companyId])
                    ->where('inventory_item.available_qty','!=',0)
                    ->where('inventory_item.type','!=',0)
                    ->select('inventory_item.id','inventory_item.available_qty','inventory_item.cost_per_unit')
                    ->orderBy('inventory_item.id','ASC')->chunk(1, function ($data) use(&$stockData,$checkQty,$qty) {
                        foreach($data as $key=> $dt){
                            $stockData[]=['id'=>$dt->id,'available_qty'=>$dt->available_qty,'cost_per_unit'=>$dt->cost_per_unit];
                            $checkQty=floatVal($checkQty)+floatVal($dt->available_qty);
                        }
                        if($checkQty>$qty){
                            return false;
                        }
                    }); 
                    $price=0;
                    $totalQty=$qty;
                    $inventory_Id=array();
                    foreach ($stockData as $value) {
                        if($value['available_qty']>=$totalQty){
                            InventoryItem::where('id',$value['id'])->update([
                                'available_qty'=>$value['available_qty']-$totalQty,
                            ]);
                            $price+=$value['cost_per_unit']*$totalQty;
                            $inventory_Id[$value['id']]=$totalQty;
                            $totalQty=$totalQty-$totalQty;
                        }else{
                            InventoryItem::where('id',$value['id'])->update([
                                'available_qty'=>0,
                            ]);
                            $totalQty=$totalQty-$value['available_qty'];
                        $price+=$value['cost_per_unit']*$value['available_qty'];
                        $inventory_Id[$value['id']]=$value['available_qty'];
                        }
                    }
                $inventoryId=json_encode($inventory_Id);

        $inventory=Inventory::where('id',$inventoryItem->fk_inventory_id)->first();
        $inventory->update([
            'available_qty'=>$inventory->available_qty+$inventoryItem->qty-$input['qty'],
            ]);
        InventoryItem::where('id',$id)->update([
            'qty'=>$input['qty'],
            'summary'=>$inventoryId,
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
        /*Update old Inventory*/
        $inventoryIds=json_decode($inventoryItem->summary,true);
        if(count($inventoryIds)>0){
            foreach ($inventoryIds as $invId => $invValue) {
               $invenItem = InventoryItem::where('id',$invId)->first();
               if($invenItem!=null){ 
                   $invenItem->update([
                    'available_qty'=>$invenItem->available_qty+$invValue
                   ]);
               }
            }
        }/*/Update old Inventory*/
        $inventory=Inventory::where('id',$inventoryItem->fk_inventory_id)->first();
        //return $inventory;
        $inventory->update([
            'available_qty'=>$inventory->available_qty+$inventoryItem->qty,
            ]);
        $inventoryItem->delete();
        return redirect()->back()->with('success','Deleted Successfully!');
    }
}
