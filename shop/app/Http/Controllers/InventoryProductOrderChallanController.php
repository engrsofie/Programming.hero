<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\InventoryProductOrderChallan;
use App\Models\InventoryProductOrderChallanItem;
use App\Models\InventoryProductOrder;
use App\Models\InventoryProductOrderItem;
use App\Models\EmailConfig;
use App\Models\CompanyInfo;
use App\Models\Inventory;
use App\Models\InventoryItem;
use Validator;
use DB;
use Auth;

class InventoryProductOrderChallanController extends Controller
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
    public function create()
    {
        //
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
        $getInvoiceData=InventoryProductOrderChallan::leftJoin('inventory_product_order','inventory_product_order_challan.fk_order_id','=','inventory_product_order.id')
        ->leftJoin('inventory_supplier','inventory_product_order.fk_supplier_id','=','inventory_supplier.id')
        ->select('inventory_product_order.inventory_order_id','inventory_product_order.shipping_address','inventory_product_order_challan.id','inventory_product_order.order_date','inventory_supplier.representative','inventory_supplier.mobile_no','inventory_supplier.address','inventory_supplier.email_id','inventory_supplier.company_name','inventory_supplier.supplier_id','inventory_product_order_challan.challan_id','inventory_product_order_challan.total_amount','received_date')
        ->where('inventory_product_order_challan.id',$id)
        ->first();
        if($getInvoiceData==null){
            return redirect()->back();
        }
        $getProductData = InventoryProductOrderChallanItem::
        leftJoin('inventory_product_order_item','inventory_product_order_challan_item.fk_order_item_id','=','inventory_product_order_item.id')
        ->leftJoin('inventory_product','inventory_product_order_item.fk_product_id','=','inventory_product.id')
        ->leftJoin('unit_of_measurement','inventory_product.fk_uom_id','=','unit_of_measurement.id')
        ->where('inventory_product_order_challan_item.fk_order_challan_id',$getInvoiceData->id)
        ->select('inventory_product_order_challan_item.qty','inventory_product_order_challan_item.payable_amount','inventory_product_order_item.cost_per_unit','inventory_product_order_item.sales_per_unit','inventory_product.product_name','inventory_product.barcode','unit_of_measurement.uom_name')
        ->get();
         $companyInfo = CompanyInfo::first();
        $emailConfig = EmailConfig::first();
        
        return view('pos.product_order.challan.browser', compact('companyInfo','emailConfig','getInvoiceData','getProductData'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $getOrder=InventoryProductOrderChallan::leftJoin('inventory_product_order','inventory_product_order_challan.fk_order_id','=','inventory_product_order.id')
        ->leftJoin('inventory_supplier','inventory_product_order.fk_supplier_id','=','inventory_supplier.id')
        ->select('inventory_product_order.inventory_order_id','inventory_product_order.shipping_address','inventory_product_order_challan.id','inventory_product_order.order_date','inventory_supplier.representative','inventory_supplier.mobile_no','inventory_supplier.address','inventory_supplier.email_id','inventory_supplier.company_name','inventory_supplier.supplier_id','inventory_product_order_challan.challan_id','inventory_product_order_challan.total_amount','received_date')
        ->where('inventory_product_order_challan.id',$id)
        ->first();
        if($getOrder==null){
            return redirect()->back();
        }
        $getOrderItem = InventoryProductOrderChallanItem::
        leftJoin('inventory_product_order_item','inventory_product_order_challan_item.fk_order_item_id','=','inventory_product_order_item.id')
        ->leftJoin('inventory_product','inventory_product_order_item.fk_product_id','=','inventory_product.id')
        ->leftJoin('inventory_small_unit','inventory_product.fk_uom_id','=','inventory_small_unit.id')
        ->where('inventory_product_order_challan_item.fk_order_challan_id',$getOrder->id)
        ->select('inventory_product_order_challan_item.id','inventory_product_order_challan_item.qty','inventory_product_order_challan_item.fk_order_item_id','inventory_product_order_challan_item.payable_amount','inventory_product_order_item.sales_per_unit','inventory_product_order_item.bdt_rates','inventory_product_order_item.foreign_amount','inventory_product.product_name','inventory_product.barcode','inventory_small_unit.small_unit_name as uom_name')
        ->get();
        foreach ($getOrderItem as $key => $value) {
            $challanQty=InventoryProductOrderChallanItem::where('fk_order_item_id',$value->fk_order_item_id)->select(DB::raw('sum(qty) as qty'))->groupBy('fk_order_item_id')->where('id','!=',$value->id)->first();
            $challanQty_qty=isset($challanQty->qty)?$challanQty->qty:0;
            $qty=InventoryProductOrderItem::where('id',$value->fk_order_item_id)->value('qty');
            $getOrderItem[$key]['maxQty']=$qty-$challanQty_qty;
        }
        return view('pos.product_order.challan.edit', compact('getOrder','getOrderItem'));
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
        $input = $request->except('_token','_method');
        $validator = Validator::make($request->all(),[
                'created_by' => 'required',

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }
            
        $orderData = InventoryProductOrderChallan::findOrFail($id);
        $orderData->update([
                'total_amount'=>$input['total_amount'],
                ]);
        for ($i=0; $i < sizeof($input['item_id']); $i++) { 

                $item_id = $input['item_id'][$i];
                $cost_amount = $input['cost_per_unit'][$i];
                $qty = $input['qty'][$i];
                $amount = $cost_amount*$qty;
                $orderItem = InventoryProductOrderChallanItem::where('id',$item_id)->first();
                $orderItem->update([
                    'qty'=>$qty,
                    'payable_amount'=>$amount,
                    ]);
                $inventoryItem=InventoryItem::where('brach_no',$orderItem->batch_no)->first();
                $nowAvailableQty=$qty-($inventoryItem->qty-$inventoryItem->available_qty);
                $inventoryItem->update([
                    'qty'=>$qty,
                    'available_qty'=>$nowAvailableQty,
                ]);
                $inventory=Inventory::where('id',$inventoryItem->fk_inventory_id)->first();
                $inventory->update([
                    'available_qty'=>$inventory->available_qty-$inventoryItem->available_qty+$nowAvailableQty,
                ]);
            }
        try {

            $challan=InventoryProductOrderChallanItem::select(DB::raw('SUM(qty) as qty'))->where('fk_order_challan_id',$orderData->id)->first();
            $getProductOrder=InventoryProductOrderItem::select(DB::raw('SUM(qty) as qty'))->where('fk_product_order_id',$orderData->fk_order_id)->first();
            
            if($getProductOrder->qty > $challan->qty){
                InventoryProductOrder::where('id',$orderData->fk_order_id)->update(['status'=>1]);
            }else{
                InventoryProductOrder::where('id',$orderData->fk_order_id)->update(['status'=>0]);
            }
            $bug = 0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect()->back()->with('success','Updated successFully.');
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
        $data = InventoryProductOrderChallan::findOrFail($id);
        $item=InventoryProductOrderChallanItem::where('fk_order_challan_id',$id)->get();
        foreach($item as $itm){
            $inventoryItem=InventoryItem::where('brach_no',$itm->batch_no)->first();
            $inventoryItem->delete();
            $inventory=Inventory::where('id',$inventoryItem->fk_inventory_id)->first();
            $inventory->update([
                    'available_qty'=>$inventory->available_qty-$inventoryItem->qty,
                ]);
        }
        
        try {
            InventoryProductOrderChallanItem::where('fk_order_challan_id',$id)->delete();
            $data->delete();
            $bug = 0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect('inventory-order-all')->with('success', 'Deleted Successfully .');
        }elseif($bug == 1451){
                return redirect()->back()->with('error','This Data Used AnyWhere.');
            }else{
            return redirect()->back()->with('error','Something Error Found !, Please try again.'.$bug1);
        }

    }




}
