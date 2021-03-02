<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\InventorySalesChallan;
use App\Models\InventorySalesChallanItem;
use App\Models\InventoryProductSales;
use App\Models\InventoryItem;
use App\Models\InventoryProductSalesItem;
use App\Models\Inventory;
use App\Models\CompanyInfo;
use App\Models\EmailConfig;
use Validator;
use DB;
use Session;
use Auth;
use Log;

class InventorySalesChallanController extends Controller
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
        $branchId=Auth::user()->fk_branch_id;
        $companyId=Auth::user()->fk_company_id;

        $input=$request->except('_token');
        $validator=Validator::make($input,[
            'fk_sales_id'=>'required',
            'total_amount'=>'required',
            'received_date'=>'required',
            ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }
        $lastId=InventorySalesChallan::max('id')+1;
        $challan_id =date('dmy').$lastId;
        DB::beginTransaction();

            $challanId=InventorySalesChallan::create([
                'fk_sales_id'=>$input['fk_sales_id'],
                'challan_id'=>$challan_id,
                'received_date'=>$input['received_date'],
                'total_amount'=>$input['total_amount'],
                'shipping_address'=>$input['shipping_address'],
                'created_by'=>Auth::user()->id,
                ])->id;


            for ($i=0; $i <sizeof($input['fk_sales_item_id']) ; $i++) { 
                $salesItemId=$input['fk_sales_item_id'][$i];
                $qty=$input['sales_qty'][$i];
                $product=InventoryProductSalesItem::where('id',$salesItemId)->select('fk_product_id','fk_model_id')->first();
                $productId=$product->fk_product_id;
                $model=$product->fk_model_id;
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
                    $inventory_id=array();
                    foreach ($stockData as $value) {
                        if($value['available_qty']>=$totalQty){
                            InventoryItem::where('id',$value['id'])->update([
                                'available_qty'=>$value['available_qty']-$totalQty,
                            ]);
                            $inventory_id[$value['id']]=$totalQty;
                            $price+=$value['cost_per_unit']*$totalQty;
                            $totalQty=$totalQty-$totalQty;
                        }else{
                            InventoryItem::where('id',$value['id'])->update([
                                'available_qty'=>0,
                            ]);
                            $inventory_id[$value['id']]=$value['available_qty'];
                            $totalQty=$totalQty-$value['available_qty'];
                        $price+=$value['cost_per_unit']*$value['available_qty'];
                        }
                    }
                    $inventoryId=json_encode($inventory_id);
                $challanItem=InventorySalesChallanItem::create([
                    'fk_sales_challan_id'=>$challanId,
                    'fk_sales_item_id'=>$salesItemId,
                    'qty'=>$qty,
                    'cost_amount'=>$price,
                    'inventory_item_id'=>$inventoryId,
                    'small_qty'=>0,
                    'payable_amount'=>$input['product_paid_amount'][$i],
                    ]);
                /*---Update available Quantity---*/
                    
                    $getInventory = Inventory::leftJoin('inventory_product','inventory.fk_product_id','inventory_product.id')
                    ->where(['inventory.fk_product_id'=>$productId,'inventory.fk_model_id'=>$model,'inventory.fk_branch_id'=>$branchId,'inventory.fk_company_id'=>$companyId])
                    ->select('inventory.id','available_qty','available_small_qty')
                    ->orderBy('id','asc')
                    ->first();

                    $inventoryUpdateQty = array(
                        'available_qty' => $getInventory->available_qty-$qty,
                        'available_small_qty' => 0,
                        'updated_at' => date('Y-m-d h:i:s')
                        );
                    
                    
                    $getInventory->update($inventoryUpdateQty);
            }

            DB::commit();
            $bug=0;
        try{
        }catch(\Exception $e){
            DB::rollback();
            $bug=$e->errorInfo[1];
        }

        if($bug==0){
            return redirect("inventory-sales-challan/$challanId")->with('success','Delivery is successfully completed');
        }else{
            
            return redirect()->back()->with('error','Something error found!');
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
        $getInvoiceData=InventorySalesChallan::leftJoin('inventory_product_sales','inventory_sales_delivery_challan.fk_sales_id','=','inventory_product_sales.id')
        ->leftJoin('inventory_clients','inventory_product_sales.fk_client_id','=','inventory_clients.id')
        ->select('inventory_product_sales.invoice_id','inventory_product_sales.id as sales_id','inventory_sales_delivery_challan.id','inventory_product_sales.date','inventory_product_sales.order_id','inventory_clients.client_name','inventory_clients.mobile_no','inventory_clients.address','inventory_clients.email_id','inventory_clients.company_name','inventory_clients.client_id','inventory_sales_delivery_challan.challan_id','inventory_sales_delivery_challan.total_amount','received_date','inventory_sales_delivery_challan.shipping_address')
        ->where('inventory_sales_delivery_challan.id',$id)
        ->first();
        if($getInvoiceData==null){
            return redirect()->back();
        }
        $getProductData = InventorySalesChallanItem::leftJoin('inventory_product_sales_item','inventory_sales_challan_item.fk_sales_item_id','=','inventory_product_sales_item.id')
        ->leftJoin('inventory_product','inventory_product_sales_item.fk_product_id','=','inventory_product.id')
        ->leftJoin('inventory_product_model','inventory_product_sales_item.fk_model_id','=','inventory_product_model.id')
       ->leftJoin('inventory_small_unit','inventory_product.fk_small_unit_id','=','inventory_small_unit.id')
        ->where('inventory_sales_challan_item.fk_sales_challan_id',$getInvoiceData->id)
        ->select('inventory_sales_challan_item.qty','inventory_sales_challan_item.payable_amount','inventory_product_sales_item.id','inventory_product_sales_item.product_price_amount','inventory_product_sales_item.product_wise_discount','inventory_sales_challan_item.small_qty','inventory_product.product_name','inventory_small_unit.small_unit_name','model_name')
        ->get();
         $companyInfo = CompanyInfo::first();
        $emailConfig = EmailConfig::first();
        
        return view('pos.sales.challan.brochure', compact('companyInfo','emailConfig','getInvoiceData','getProductData'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $getChallan=InventorySalesChallan::leftJoin('inventory_product_sales','inventory_sales_delivery_challan.fk_sales_id','=','inventory_product_sales.id')
        ->leftJoin('inventory_clients','inventory_product_sales.fk_client_id','=','inventory_clients.id')
        ->select('inventory_product_sales.invoice_id','inventory_product_sales.id as sales_id','inventory_sales_delivery_challan.id','inventory_product_sales.date','inventory_clients.client_name','inventory_clients.mobile_no','inventory_clients.address','inventory_clients.email_id','inventory_clients.company_name','inventory_clients.client_id','inventory_sales_delivery_challan.challan_id','inventory_sales_delivery_challan.total_amount','received_date')
        ->where('inventory_sales_delivery_challan.id',$id)
        ->first();
        if($getChallan==null){
            return redirect()->back();
        }
        $getChallanItem = InventorySalesChallanItem::
        leftJoin('inventory_product_sales_item','inventory_sales_challan_item.fk_sales_item_id','=','inventory_product_sales_item.id')
        ->leftJoin('inventory_product','inventory_product_sales_item.fk_product_id','=','inventory_product.id')
        ->leftJoin('inventory_product_model','inventory_product_sales_item.fk_model_id','=','inventory_product_model.id')
        ->leftJoin('inventory_small_unit','inventory_product.fk_small_unit_id','=','inventory_small_unit.id')
        ->where('inventory_sales_challan_item.fk_sales_challan_id',$getChallan->id)
        ->select('inventory_sales_challan_item.id','inventory_sales_challan_item.qty','inventory_sales_challan_item.small_qty','inventory_sales_challan_item.fk_sales_item_id','inventory_sales_challan_item.payable_amount','inventory_product_sales_item.product_price_amount','inventory_product_sales_item.product_wise_discount','inventory_product.product_name','inventory_small_unit.small_unit_name','model_name')
        ->get();
        foreach ($getChallanItem as $key => $value) {
            $challanQty=InventorySalesChallanItem::where('fk_sales_item_id',$value->fk_sales_item_id)->select(DB::raw('sum(qty) as qty'),DB::raw('sum(small_qty) as small_qty'))->groupBy('fk_sales_item_id')->where('id','!=',$value->id)->first();
            if($challanQty==''){
                $challanQty['qty']=0;
            }
            $orderItem=InventoryProductSalesItem::where('id',$value->fk_sales_item_id)->select('sales_qty','small_qty')->first();
                
            $getChallanItem[$key]['maxQty']=$orderItem->sales_qty-$challanQty['qty'];
        }
        return view('pos.sales.challan.edit', compact('getChallan','getChallanItem'));
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
        $input = $request->except('_token','_method');
        $validator = Validator::make($request->all(),[
                'created_by' => 'required',

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }
        try {
        $orderData = InventorySalesChallan::findOrFail($id);
        $orderData->update([
                'total_amount'=>$input['total_amount'],
                ]);

        for ($i=0; $i < sizeof($input['item_id']); $i++) { 
                $item_id = $input['item_id'][$i];
                $amount = $input['payable_amount'][$i];
                
                /*---Update available Quantity---*/
                $product=InventorySalesChallanItem::leftJoin('inventory_product_sales_item','inventory_sales_challan_item.fk_sales_item_id','inventory_product_sales_item.id')
                ->where('inventory_sales_challan_item.id',$item_id)->select('fk_product_id','qty')->first();
                $orderItem = InventorySalesChallanItem::where('id',$item_id)->first();
                $inventoryIds=json_decode($orderItem->inventory_item_id,true);
                foreach ($inventoryIds as $invId => $invValue) {
                   $inventoryItem = InventoryItem::where('id',$invId)->first();
                   $inventoryItem->update([
                    'available_qty'=>$inventoryItem->available_qty+$invValue
                   ]);
                }
                $checkQty=0;
                    $stockData=array();
                    $inventory_id=array();
                    $stock=InventoryItem::leftJoin('inventory','inventory_item.fk_inventory_id','inventory.id')
                        ->where(['inventory.fk_product_id'=>$product->fk_product_id,'inventory.fk_branch_id'=>$branchId,'inventory.fk_company_id'=>$companyId])
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
                        foreach ($stockData as $value) {
                            if($value['available_qty']>=$totalQty){
                                InventoryItem::where('id',$value['id'])->update([
                                    'available_qty'=>$value['available_qty']-$totalQty,
                                ]);
                                $inventory_id[$value['id']]=$totalQty;
                                $price+=$value['cost_per_unit']*$totalQty;
                                $totalQty=$totalQty-$totalQty;
                            }else{
                                InventoryItem::where('id',$value['id'])->update([
                                    'available_qty'=>0,
                                ]);
                                $inventory_id[$value['id']]=$value['available_qty'];
                                $totalQty=$totalQty-$value['available_qty'];
                            $price+=$value['cost_per_unit']*$value['available_qty'];
                            }
                        }
                        $inventoryId=json_encode($inventory_id);

                    $getInventory = Inventory::leftJoin('inventory_product','inventory.fk_product_id','inventory_product.id')
                    ->where(['fk_product_id'=>$product->fk_product_id,'inventory.fk_branch_id'=>$branchId,'inventory.fk_company_id'=>$companyId])
                    ->select('inventory.id','available_qty','available_small_qty')
                    ->orderBy('id','asc')
                    ->first();
                    $inventoryUpdateQty = array(
                        'available_qty' => $getInventory->available_qty+$product->qty-$input['qty'][$i],
                        'available_small_qty' => 0,
                        'updated_at' => date('Y-m-d h:i:s')
                        );
                    
                    
                    $getInventory->update($inventoryUpdateQty);
                    $orderItem->update([
                        'qty'=>$input['qty'][$i],
                        'small_qty'=>0,
                        'cost_amount'=>$price,
                        'inventory_item_id'=>$inventoryId,
                        'payable_amount'=>$amount,
                    ]);
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
        $branchId=Auth::user()->fk_branch_id;
        $companyId=Auth::user()->fk_company_id;
        $data = InventorySalesChallan::findOrFail($id);
        
            $items =  InventorySalesChallanItem::where('fk_sales_challan_id',$id)->get();

            foreach ($items as $item) {
                $product=InventorySalesChallanItem::leftJoin('inventory_product_sales_item','inventory_sales_challan_item.fk_sales_item_id','inventory_product_sales_item.id')
                    ->where('inventory_sales_challan_item.id',$item->id)->select('fk_product_id','qty','inventory_sales_challan_item.inventory_item_id')->first();
                $inventoryIds=json_decode($product->inventory_item_id,true);
                if($inventoryIds!=null and count($inventoryIds)>0){
                    foreach ($inventoryIds as $invId => $invValue) {
                       $inventoryItem = InventoryItem::where('id',$invId)->first();
                       $inventoryItem->update([
                        'available_qty'=>$inventoryItem->available_qty+$invValue
                       ]);
                    }
                }
                $getInventory = Inventory::leftJoin('inventory_product','inventory.fk_product_id','inventory_product.id')
                ->where(['fk_product_id'=>$product->fk_product_id,'inventory.fk_branch_id'=>$branchId,'inventory.fk_company_id'=>$companyId])
                ->select('inventory.id','available_qty','available_small_qty')
                ->orderBy('id','asc')
                ->first();
                $inventoryUpdateQty = array(
                    'available_qty' => $getInventory->available_qty+$product->qty,
                    'available_small_qty' => 0,
                    'updated_at' => date('Y-m-d h:i:s')
                    );
                $getInventory->update($inventoryUpdateQty);
            }
            InventorySalesChallanItem::where('fk_sales_challan_id',$id)->delete();
            $data->delete();
        try {
            $bug = 0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect("inventory-product-sales/$data->fk_sales_id")->with('success', 'Deleted Successfully .');
        }elseif($bug == 1451){
                return redirect()->back()->with('error','This Data Used AnyWhere.');
            }else{
            return redirect()->back()->with('error','Something Error Found !, Please try again.'.$bug1);
        }
    }
}
