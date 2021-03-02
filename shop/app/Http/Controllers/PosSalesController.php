<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Models\Inventory;
use App\Models\PosBarcode;
use App\Models\InventoryItem;
use App\Models\InventoryProductSales;
use App\Models\InventoryProductSalesItem;
use App\Models\InventorySalesPaymentHistory;
use App\Models\InventorySalesPaymentHistoryItem;
use App\Models\AccountSetting;
use App\Models\InventoryClient;
use App\Models\InventorySalesChallan;
use App\User;
use Yajra\DataTables\DataTables;
use Validator;
use DB;
use Auth;

class PosSalesController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        if(isset($request->id)){

        $id = $request->id;
         $getInvoiceData=InventoryProductSales::leftJoin('inventory_clients','inventory_product_sales.fk_client_id','=','inventory_clients.id')
            ->leftJoin('users','inventory_product_sales.fk_user_id','=','users.id')
            ->select('inventory_product_sales.invoice_id','inventory_product_sales.order_id','inventory_product_sales.id','inventory_product_sales.date','inventory_product_sales.shipping_date','inventory_product_sales.total_amount','inventory_product_sales.paid_amount','inventory_product_sales.discount','inventory_clients.client_name','inventory_clients.mobile_no','inventory_clients.address','inventory_clients.email_id','inventory_clients.company_name','inventory_clients.client_id','summary','users.name as sales_by','inventory_clients.id as clientId','prev_paid','prev_amount')
            ->where('inventory_product_sales.id',$id)
            ->first();
            if($getInvoiceData==null){
                return '';
            }
        $getProductData = InventoryProductSalesItem::
        leftJoin('inventory_product_sales','inventory_product_sales_item.fk_sales_id','=','inventory_product_sales.id')
        ->leftJoin('inventory_product_model','inventory_product_sales_item.fk_model_id','=','inventory_product_model.id')
        ->leftJoin('inventory_product','inventory_product_sales_item.fk_product_id','=','inventory_product.id')
        ->leftJoin('inventory_small_unit','inventory_product.fk_small_unit_id','=','inventory_small_unit.id')
        ->where('inventory_product_sales.id',$getInvoiceData->id)
        ->select('inventory_product_sales_item.product_price_amount','inventory_product_sales_item.sales_qty','inventory_product_sales_item.small_qty','inventory_product_sales_item.product_wise_discount','inventory_product_sales_item.product_paid_amount','inventory_product.product_name','inventory_product.specification','inventory_small_unit.small_unit_name','model_name')
        ->get();

        $prev=InventoryProductSales::select(DB::raw('SUM(total_amount) as total_amount'),DB::raw('SUM(paid_amount) as paid_amount'))
        ->where('fk_client_id',$getInvoiceData->clientId)
        ->whereColumn('total_amount','>','paid_amount')
        ->where('date','<',$getInvoiceData->date)
        ->first();
       // return $getInvoiceData->id;
        return view('pos.posSales.invoice', compact('getInvoiceData','getProductData','prev'));
        }
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Request $request)
    {
        $salesId = '';
        if(isset($request->id)){
            $salesId = $request->id;
        }
        $accounts= AccountSetting::where('account_status',1)->pluck('account_name','id');
        return view('pos.posSales.create',compact('accounts','salesId'));
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
        $input = $request->except('_token');
        $validator = Validator::make($request->all(),[
                'fk_product_id' => 'required',
                'fk_model_id' => 'required',

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }

        $input['date'] = date("Y-m-d", strtotime($input['date']));
       /* $input['shipping_date'] = date("Y-m-d", strtotime($input['shipping_date']));*/
        $lastId=InventoryProductSales::max('id')+1;
        $input['invoice_id'] =$lastId;
        $invoice_id=$input['invoice_id'];
        $totalHundrad = $input['sub_total']/100;
        $discountPercentage =$input['discount']/$totalHundrad;

        DB::beginTransaction();
        $client_id=null;
        if($input['client_name']!=null){
            $client_id=InventoryClient::createNew($input['client_name']);
        }
        

        $sales_id = InventoryProductSales::create([
            'fk_client_id'=>$client_id,
            'summary'=>'',
            'invoice_id'=>$input['invoice_id'],
            'order_id'=>'',
            'shipping_date'=>'',
            'date'=>$input['date'],
            'total_amount'=>$input['total_amount'],
            'transport_bill'=>'',
            'paid_amount'=>$input['total_paid'],
            'shipping_address'=>'',
            'created_by'=>Auth::user()->id,
            'fk_branch_id'=>Auth::user()->fk_branch_id,
            'fk_company_id'=>Auth::user()->fk_company_id,
            'fk_user_id'=>Auth::user()->id,
            'sales_type'=>1,
            'prev_amount'=>0,
            'discount'=>$input['discount'],
            'prev_paid'=>0,
            ])->id;
            $lastId=InventorySalesChallan::max('id')+1;
            $challan_id =date('dmy').$lastId;
            $challanId=InventorySalesChallan::create([
                'fk_sales_id'=>$sales_id,
                'challan_id'=>$challan_id,
                'received_date'=>$input['date'],
                'total_amount'=>$input['total_amount'],
                'shipping_address'=>'',
                'created_by'=>Auth::user()->id,
                ])->id;
            
            for ($i=0; $i < sizeof($input['fk_product_id']); $i++) { 
                $productId = $input['fk_product_id'][$i];
                $model = $input['fk_model_id'][$i];
                $qty = $input['sales_qty'][$i];
                $smallQty = 0;
                $price_amount = $input['product_price_amount'][$i];
                $price_paid = $input['product_paid_amount'][$i];
                $discount=($price_paid/100)*$discountPercentage;
                $qtyDiscount=$discount;/*/$qty*/
                $salesItemId = InventoryProductSalesItem::create([
                    'fk_sales_id' => $sales_id,
                    'fk_product_id' => $productId,
                    'fk_model_id' => $model,
                    'product_price_amount' => $price_amount,
                    'sales_qty' => $qty,
                    'small_qty' => $smallQty,
                    'product_wise_discount' => $qtyDiscount,
                    'product_paid_amount' => $price_paid-$discount,

                    ])->id;
                if($request->sales_type!=0){
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
                    InventoryProductSalesItem::where('id',$salesItemId)->update([

                        'inventory_item_id' => $inventoryId,
                    ]);
                    $challanItem=InventorySalesChallanItem::create([
                        'fk_sales_challan_id'=>$challanId,
                        'fk_sales_item_id'=>$salesItemId,
                        'qty'=>$qty,
                        'cost_amount'=>$price,
                        'small_qty'=>0,
                        'inventory_item_id'=>$inventoryId,
                        'payable_amount'=>$input['product_paid_amount'][$i]-$discount,
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

            }

            if($request->total_paid>0){
                $lastId=InventorySalesPaymentHistory::max('id')+1;
                $input['invoice_id'] =date('ymd').$lastId;
                $payment_id = InventorySalesPaymentHistory::create([
                    'fk_client_id'=>$client_id,
                    'invoice_id'=>$input['invoice_id'],
                    'payment_date'=>$input['date'],
                    'total_amount'=>$input['total_amount'],
                    'paid'=>$input['total_paid'],
                    'last_due'=>$input['total_amount'],
                    'fk_account_id'=>$input['fk_account_id'],
                    'fk_method_id'=>$input['fk_method_id'],
                    'fk_received_id'=>Auth::user()->id,
                    'ref_id'=>$input['ref_id'],
                    'type'=>1,
                    'created_by'=>Auth::user()->id,
                    'fk_branch_id'=>Auth::user()->fk_branch_id,
                    'fk_company_id'=>Auth::user()->fk_company_id,
                    ])->id;

                 InventorySalesPaymentHistoryItem::create([
                    'fk_payment_id'=>$payment_id,
                    'fk_sales_id'=>$sales_id,
                    'sales_last_due'=>$input['total_amount'],
                    'sales_paid'=>$input['total_paid'],
                    'type'=>1

                    ]);
            }

        try {


            DB::commit();
            $bug=0;
        }catch(\Exception $e){
            DB::rollback();
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect("pos-sales/create?id=$sales_id")->with('success','Sales Successfully.');
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
        $branchId=Auth::user()->fk_branch_id;
        $companyId=Auth::user()->fk_company_id;
        $data=array();
        $product = PosBarcode::where('barcode',$id)->first();
        if($product!=null){
        $data = Inventory::leftJoin('inventory_product','inventory.fk_product_id','=','inventory_product.id')
            ->leftJoin('inventory_small_unit','inventory_product.fk_small_unit_id','=','inventory_small_unit.id')
            ->leftJoin('inventory_product_model','inventory.fk_model_id','=','inventory_product_model.id')
            ->select('inventory.fk_product_id','inventory.fk_model_id','available_qty','product_name','sales_per_unit','model_name','small_unit_name')
            ->where(['inventory.fk_branch_id'=>$branchId,'inventory.fk_company_id'=>$companyId])
            ->where(['inventory.fk_product_id'=>$product->fk_product_id,'inventory.fk_model_id'=>$product->fk_model_id])->first();
        }
        return response()->json($data);
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
