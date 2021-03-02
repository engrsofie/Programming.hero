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
use App\Models\InventoryItem;
use App\Models\InventoryProductSales;
use App\Models\InventoryProductSalesItem;
use App\Models\InventorySalesPaymentHistory;
use App\Models\InventorySalesPaymentHistoryItem;
use App\Models\InventorySalesChallan;
use App\Models\InventorySalesChallanItem;
use App\Models\AccountSetting;
use App\Models\PaymentMethod;
use App\Models\InventoryProductSalePrice;
use App\Models\InventoryReceiveExecutive;
use App\User;
use Yajra\DataTables\DataTables;
use Validator;
use DB;
use Auth;

class InventoryProductSalesController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('pos.sales.viewSales');
    }

    public function allData(){
        $branchId=Auth::user()->fk_branch_id;
        $companyId=Auth::user()->fk_company_id;
        $query  = InventoryProductSales::
        leftJoin('inventory_branch','inventory_product_sales.fk_branch_id','inventory_branch.id')
        ->leftJoin('inventory_clients','inventory_product_sales.fk_client_id','inventory_clients.id')
        ->select('inventory_product_sales.*','inventory_clients.client_name','inventory_clients.company_name','branch_name')
        ->where('inventory_product_sales.type',null)
        ->orderBy('inventory_product_sales.id','desc');
        if(Auth::user()->isRole('administrator')){
            $sales=$query;
        }else{
            $sales=$query->where(['inventory_product_sales.fk_branch_id'=>$branchId,'inventory_product_sales.fk_company_id'=>$companyId]);
        }
            //return $customer;
        return Datatables::of($sales)
            ->addColumn('invoice_id','<a href=\'<? echo URL::to("inventory-sales-invoice/$invoice_id") ?>\' target="_blank" title="View Browser">{{$invoice_id}}</a>')
            ->addColumn('total_amount', '{{round($total_amount,2)}}')
            ->addColumn('paid_amount', '{{round($paid_amount,2)}}')
            ->addColumn('due_amount', '{{round($total_amount-$paid_amount,2)}}')
            ->addColumn('action', '
                @if($sales_type==0)
                <a href=\'{{URL::to("inventory-product-sales/$id")}}\' class="btn btn-primary btn-xs" title="view description"><i class="fa fa-eye"></i></a>
                @endif
                <a target="_blank" href=\'{{URL::to("inventory-product-sales/$id/edit")}}\' class="btn btn-warning btn-xs"><i class="fa fa-pencil-square"></i></a>
                {!! Form::open(array(\'route\'=> [\'inventory-product-sales.destroy\',$id],\'method\'=>\'DELETE\')) !!}
                    <button type="submit" onclick="return confirmDelete();" class="btn btn-xs btn-danger">
                      <i class="fa fa-trash-o" aria-hidden="true"></i>
                    </button>
                {!! Form::close() !!}
                ')

            ->rawColumns(['invoice_id','action'])
            ->make(true);
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
        $users=User::where(['fk_branch_id'=>$branchId,'fk_company_id'=>$companyId])->pluck('name','id');
        $getClient = InventoryClient::where('client_status','1')->where(['fk_branch_id'=>$branchId,'fk_company_id'=>$companyId])->where('client_type','0')->get();
        $getProductData = Inventory::
        leftJoin('inventory_product','inventory.fk_product_id','=','inventory_product.id')
        ->select('inventory_product.*')
        ->orderBy('id','desc')
        ->get();
        $account=AccountSetting::where('account_status',1)->pluck('account_name','id');
        $method=PaymentMethod::where('method_status',1)->pluck('method_name','id');
        
        return view('pos.sales.index', compact('getClient','getProductData','users','account','method'));
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
                'client_name' => 'required',

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
            
        $client_id=InventoryClient::createNew($input['client_name']);
        $paid=$input['total_paid']-$input['total_amount'];
        if($paid<0){
            $paid=0;
        }
        $paid1=$input['total_paid']-$paid;

        $sales_id = InventoryProductSales::create([
            'fk_client_id'=>$client_id,
            'summary'=>'',
            'invoice_id'=>$input['invoice_id'],
            'order_id'=>$input['order_id'],
            'shipping_date'=>'',
            'date'=>$input['date'],
            'total_amount'=>$input['total_amount'],
            'transport_bill'=>'',
            'paid_amount'=>$paid1,
            'shipping_address'=>'',
            'created_by'=>Auth::user()->id,
            'fk_branch_id'=>Auth::user()->fk_branch_id,
            'fk_company_id'=>Auth::user()->fk_company_id,
            'fk_user_id'=>$input['fk_user_id'],
            'sales_type'=>$input['sales_type'],
            'prev_amount'=>$input['prev_amount'],
            'discount'=>$input['discount'],
            'prev_paid'=>$paid,
            ])->id;
            if($request->sales_type!=0){
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
            }
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
                    'total_amount'=>$input['grand_total'],
                    'paid'=>$input['total_paid'],
                    'last_due'=>$input['total_amount'],
                    'fk_account_id'=>$input['fk_account_id'],
                    'fk_method_id'=>$input['fk_method_id'],
                    'fk_received_id'=>$input['fk_user_id'],
                    'ref_id'=>'',
                    'type'=>1,
                    'created_by'=>Auth::user()->id,
                    'fk_branch_id'=>Auth::user()->fk_branch_id,
                    'fk_company_id'=>Auth::user()->fk_company_id,
                    ])->id;

                 InventorySalesPaymentHistoryItem::create([
                    'fk_payment_id'=>$payment_id,
                    'fk_sales_id'=>$sales_id,
                    'sales_last_due'=>$input['total_amount'],
                    'sales_paid'=>$paid1,
                    'type'=>1

                    ]);
            }

            $paid=$input['total_paid']-$input['total_amount'];
                if($paid>0){
                    $allDue  = InventoryProductSales::select('id','invoice_id','date','total_amount','paid_amount')->where('fk_client_id',$client_id)->whereColumn('total_amount','>','paid_amount')
                        ->orderBy('inventory_product_sales.id','ASC')
                        ->get();
                    foreach ($allDue as $due) {
                        $last_due=$due->total_amount-$due->paid_amount;
                        $sales_id=$due->id;
                        if($last_due>$paid){
                            $payable=$paid;
                            $paid=0;
                        }else{
                            $payable=$last_due;
                            $paid=$paid-$last_due;
                        }
                        $sales=InventoryProductSales::where('id',$sales_id)->first();
                        $sales->update([
                            'paid_amount'=>$payable+$sales->paid_amount,
                            ]);
                        InventorySalesPaymentHistoryItem::create([
                            'fk_payment_id'=>$payment_id,
                            'fk_sales_id'=>$sales_id,
                            'sales_last_due'=>$last_due,
                            'sales_paid'=>$payable,
                            'type'=>0


                            ]);
                        }
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
            return redirect("inventory-sales-invoice/$invoice_id")->with('success','New payment Created Successfully.');
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
        $getInvoiceData = InventoryProductSales::
        leftJoin('inventory_clients','inventory_product_sales.fk_client_id','=','inventory_clients.id')
        ->where('inventory_product_sales.id',$id)
        ->select('inventory_product_sales.id','inventory_product_sales.invoice_id','inventory_product_sales.summary','inventory_product_sales.date','inventory_product_sales.shipping_date','inventory_product_sales.total_amount','inventory_product_sales.paid_amount','inventory_product_sales.discount','inventory_clients.client_id','inventory_clients.client_name','inventory_clients.mobile_no','inventory_clients.address','inventory_clients.email_id','inventory_clients.company_name','inventory_clients.shipping_address1','inventory_clients.shipping_address2')
        ->first();
        if($getInvoiceData==null){
            return redirect()->back();
        }
        $getProductData = InventoryProductSalesItem::
        leftJoin('inventory_product_sales','inventory_product_sales_item.fk_sales_id','=','inventory_product_sales.id')
        ->leftJoin('inventory_product','inventory_product_sales_item.fk_product_id','=','inventory_product.id')
        ->leftJoin('inventory_product_model','inventory_product_sales_item.fk_model_id','=','inventory_product_model.id')
        ->leftJoin('inventory_small_unit','inventory_product.fk_small_unit_id','=','inventory_small_unit.id')
        ->where('inventory_product_sales.id',$id)
        ->select('inventory_product_sales_item.id','inventory_product_sales_item.fk_product_id','inventory_product_sales_item.fk_model_id','inventory_product_sales_item.product_price_amount','inventory_product_sales_item.sales_qty','inventory_product_sales_item.small_qty','inventory_product_sales_item.product_wise_discount','inventory_product_sales_item.product_paid_amount','inventory_product.product_name','inventory_product.specification','inventory_small_unit.small_unit_name','model_name')
        ->get();
        $challan=InventorySalesChallan::where('fk_sales_id',$id)->select(DB::raw('SUM(total_amount) as total_amount'))->first();
        $challanItem=InventorySalesChallanItem::leftJoin('inventory_sales_delivery_challan','inventory_sales_challan_item.fk_sales_challan_id','inventory_sales_delivery_challan.id')
            ->select('fk_sales_item_id',DB::raw('SUM(payable_amount) as payable_amount'),DB::raw('SUM(qty) as qty'),DB::raw('SUM(small_qty) as small_qty'))
            ->where('fk_sales_id',$id)
            ->groupBy('inventory_sales_challan_item.fk_sales_item_id')->get();
        foreach ($getProductData as $key => $value) {
            $getProductData[$key]['available_qty']=Inventory::where(['inventory.fk_product_id'=>$value->fk_product_id,'inventory.fk_model_id'=>$value->fk_model_id,'inventory.fk_branch_id'=>$branchId,'inventory.fk_company_id'=>$companyId])->value('available_qty');
           foreach ($challanItem as $item) {
               if($value->id==$item->fk_sales_item_id){
                /*Qty*/
                if($value->small_unit>0){

                    $orderSmallQty=($value->sales_qty*$value->small_unit)+$value->small_qty;
                    $challanSmallQty=($item->qty*$value->small_unit)+$item->small_qty;

                    $totalSmallQty=$orderSmallQty-$challanSmallQty;

                    $restOfBigQty=floor($totalSmallQty/$value->small_unit);
                    $restOfSmallQty=$totalSmallQty-($restOfBigQty*$value->small_unit);

                 }else{
                    $restOfBigQty=$value->sales_qty-$item->qty;
                    $restOfSmallQty=0;

                 }
                      $getProductData[$key]['sales_qty'] = $restOfBigQty;
                      $getProductData[$key]['small_qty'] = $restOfSmallQty;
                      $getProductData[$key]['product_paid_amount'] = $value->product_paid_amount-$item->payable_amount;
               }
           }
        }
        $getInvoiceData->total_amount=$getInvoiceData->total_amount-$challan->total_amount;
        $oldChallan=InventorySalesChallan::where('fk_sales_id',$id)->get();
        return view('pos.sales.show', compact('getInvoiceData','getProductData','id','oldChallan'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $branchId=Auth::user()->fk_branch_id;
        $companyId=Auth::user()->fk_company_id;
       $getInvoiceData = InventoryProductSales::
        leftJoin('inventory_clients','inventory_product_sales.fk_client_id','=','inventory_clients.id')
        ->where('inventory_product_sales.id',$id)
        ->select('inventory_product_sales.id','inventory_product_sales.shipping_address','inventory_product_sales.invoice_id','inventory_product_sales.summary','inventory_product_sales.date','inventory_product_sales.total_amount','inventory_product_sales.paid_amount','inventory_product_sales.discount','inventory_clients.client_id','inventory_clients.client_name','inventory_clients.mobile_no','inventory_clients.address','inventory_clients.email_id','inventory_clients.company_name','prev_amount','prev_paid')
        ->first();
        if($getInvoiceData==null){
            return redirect()->back();
        }
        $getProductData = InventoryProductSalesItem::
        leftJoin('inventory_product_sales','inventory_product_sales_item.fk_sales_id','=','inventory_product_sales.id')
        ->leftJoin('inventory_product','inventory_product_sales_item.fk_product_id','=','inventory_product.id')
        ->leftJoin('inventory_product_model','inventory_product_sales_item.fk_model_id','=','inventory_product_model.id')
        ->leftJoin('inventory_small_unit','inventory_product.fk_small_unit_id','=','inventory_small_unit.id')
        ->where('inventory_product_sales.id',$id)
        ->select('inventory_product_sales_item.id','inventory_product_sales_item.product_price_amount','inventory_product_sales_item.sales_qty','inventory_product_sales_item.small_qty','inventory_product_sales_item.product_wise_discount','inventory_product_sales_item.product_paid_amount','inventory_product.product_name','inventory_product.specification','inventory_small_unit.small_unit_name','model_name')
        ->get();
        $payment=InventorySalesPaymentHistoryItem::leftJoin('inventory_payment_history','inventory_payment_history_item.fk_payment_id','inventory_payment_history.id')->where(['fk_sales_id'=>$id,'inventory_payment_history.type'=>1])->select('inventory_payment_history.*')->first();
        if($payment==null){
            $anotherPayment=InventorySalesPaymentHistoryItem::where(['fk_sales_id'=>$id])->first();
            if($anotherPayment!=null){
                return redirect()->back();
            }
        }
        $users=User::where(['fk_branch_id'=>$branchId,'fk_company_id'=>$companyId])->pluck('name','id');
        $account=AccountSetting::where('account_status',1)->pluck('account_name','id');
        $method=PaymentMethod::where('method_status',1)->pluck('method_name','id');
        return view('pos.sales.edit', compact('getInvoiceData','getProductData','users','account','method','payment'));
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
        $validator = Validator::make($input,[
                'sales_item_id' => 'required',

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }
        $newDate = date("Y-m-d", strtotime($request->date));
        $data=InventoryProductSales::findOrFail($id);
        $paid2=$input['total_paid']-$input['total_amount'];
        if($paid2<0){
            $paid2=0;
        }
        $totalHundrad = $input['sub_total']/100;
        $discountPercentage =$input['discount']/$totalHundrad;
        DB::beginTransaction();
        $paid1=$input['total_paid']-$paid2;
        if($request->total_paid>0){
            if($request->payment_id!=null){
                InventorySalesPaymentHistory::where('id',$request->payment_id)->update([
                    'payment_date'=>$newDate,
                    'total_amount'=>$input['grand_total'],
                    'paid'=>$input['total_paid'],
                    'last_due'=>$input['total_amount'],
                    'ref_id'=>'',
                    'created_by'=>Auth::user()->id,
                    ]);

                 InventorySalesPaymentHistoryItem::where(['fk_payment_id'=>$request->payment_id,'type'=>1])->update([
                        'sales_last_due'=>$input['total_amount'],
                        'sales_paid'=>$paid1,
                    ]);
                }else{

                    $payment_id = InventorySalesPaymentHistory::create([
                        'fk_client_id'=>$data->fk_client_id,
                        'invoice_id'=>$data->invoice_id,
                        'payment_date'=>$newDate,
                        'total_amount'=>$input['grand_total'],
                        'paid'=>$input['total_paid'],
                        'last_due'=>$input['total_amount'],
                        'fk_account_id'=>$input['fk_account_id'],
                        'fk_method_id'=>$input['fk_method_id'],
                        'fk_received_id'=>$input['fk_user_id'],
                        'ref_id'=>$input['ref_id'],
                        'type'=>1,
                        'created_by'=>Auth::user()->id,
                        'fk_branch_id'=>Auth::user()->fk_branch_id,
                        'fk_company_id'=>Auth::user()->fk_company_id,
                        ])->id;

                     InventorySalesPaymentHistoryItem::create([
                        'fk_payment_id'=>$payment_id,
                        'fk_sales_id'=>$id,
                        'sales_last_due'=>$input['total_amount'],
                        'sales_paid'=>$paid1,
                        'type'=>1
                        ]);
                }
            }
            /*Payment History Update*/
            $paid3=$input['total_paid']-$input['total_amount'];
                if($paid3>0){
                    if($request->payment_id!=null){
                        $paymentItem=InventorySalesPaymentHistoryItem::where(['fk_payment_id'=>$request->payment_id,'type'=>0])->get();
                        foreach ($paymentItem as $pay) {
                            $sales_id=$pay->fk_sales_id;
                            $due=InventoryProductSales::where('id',$sales_id)->first();
                            $last_due=$due->total_amount-$due->paid_amount;
                            if($last_due>$paid3){
                                $payable=$paid3;
                                $paid3=0;
                            }else{
                                $payable=$last_due;
                                $paid3=$paid3-$last_due;
                            }
                            $due->update([
                                'paid_amount'=>$payable+$due->paid_amount,
                                ]);
                             InventorySalesPaymentHistoryItem::where('id',$pay->id)->update([
                                'sales_paid'=>$payable,
                                ]);
                        }
                        }else{

                        $allDue  = InventoryProductSales::select('id','invoice_id','date','total_amount','paid_amount')->where('fk_client_id',$input['fk_client_id'])->whereColumn('total_amount','>','paid_amount')
                            ->orderBy('inventory_product_sales.id','ASC')
                            ->get();
                        foreach ($allDue as $due) {
                            $last_due=$due->total_amount-$due->paid_amount;
                            $sales_id=$due->id;
                            if($last_due>$paid){
                                $payable=$paid;
                                $paid=0;
                            }else{
                                $payable=$last_due;
                                $paid=$paid-$last_due;
                            }
                            $sales=InventoryProductSales::where('id',$sales_id)->first();
                            $sales->update([
                                'paid_amount'=>$payable+$sales->paid_amount,
                                ]);
                            InventorySalesPaymentHistoryItem::create([
                                'fk_payment_id'=>$payment_id,
                                'fk_sales_id'=>$sales_id,
                                'sales_last_due'=>$last_due,
                                'sales_paid'=>$payable,
                                'type'=>0


                                ]);
                            }
                        }
                    }
        $paid=InventorySalesPaymentHistoryItem::where(['fk_sales_id'=>$id,'type'=>1])->select(DB::raw('SUM(sales_paid) as paid'))->value('paid');

        $data->update([
            'paid_amount'=>$paid,
            'total_amount'=>$request->total_amount,
            'transport_bill'=>'',
            'summary'=>'',
            'shipping_address'=>$request->shipping_address,
            'date'=>$newDate,
            'prev_amount'=>$input['prev_amount'],
            'prev_paid'=>$paid2,
            'discount'=>$input['discount'],
            ]);
        if($data->sales_type!=0){
            $challanId=InventorySalesChallan::where('fk_sales_id',$id)->update([
                    'received_date'=>$newDate,
                    'total_amount'=>$input['total_amount'],
                    'shipping_address'=>'',
                    'created_by'=>Auth::user()->id,
                    ]);

            }
        for ($i=0; $i <sizeof($input['sales_item_id']) ; $i++) {
            $itemId= $input['sales_item_id'][$i];
            $qty=$input['sales_qty'][$i];
            $item=InventoryProductSalesItem::where('id',$itemId)->first();
            $inventoryId='';
            $discount=($input['product_paid_amount'][$i]/100)*$discountPercentage;
                        $qtyDiscount=$discount;/*/$qty*/
        if($data->sales_type!=0){
            $inventoryIds=json_decode($item->inventory_item_id,true);
            if(count($inventoryIds)>0){
                foreach ($inventoryIds as $invId => $invValue) {
                   $inventoryItem = InventoryItem::where('id',$invId)->first();
                   if($inventoryItem!=null){ 
                       $inventoryItem->update([
                        'available_qty'=>$inventoryItem->available_qty+$invValue
                       ]);
                   }
                }
            }
            $checkQty=0;
                    $stockData=array();
                    $stock=InventoryItem::leftJoin('inventory','inventory_item.fk_inventory_id','inventory.id')
                        ->where(['inventory.fk_product_id'=>$item->fk_product_id,'inventory.fk_model_id'=>$item->fk_model_id,'inventory.fk_branch_id'=>$branchId,'inventory.fk_company_id'=>$companyId])
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
                            if($value['available_qty']>=$qty){
                                InventoryItem::where('id',$value['id'])->update([
                                    'available_qty'=>$value['available_qty']-$totalQty,
                                ]);
                                $inventory_Id[$value['id']]=$totalQty;
                                $price+=$value['cost_per_unit']*$totalQty;
                                $totalQty=$totalQty-$totalQty;
                            }else{
                                InventoryItem::where('id',$value['id'])->update([
                                    'available_qty'=>0,
                                ]);
                                $inventory_Id[$value['id']]=$value['available_qty'];
                                $totalQty=$totalQty-$value['available_qty'];
                            $price+=$value['cost_per_unit']*$value['available_qty'];
                            }
                        }
                        $inventoryId=json_encode($inventory_Id);
                        
                    $challanItem=InventorySalesChallanItem::where('fk_sales_item_id',$itemId)->update([
                        'qty'=>$qty,
                        'cost_amount'=>$price,
                        'inventory_item_id'=>$inventoryId,
                        'payable_amount'=>$input['product_paid_amount'][$i]-$discount,
                        ]);
                    /*---Update available Quantity---*/
                        
                        $getInventory = Inventory::leftJoin('inventory_product','inventory.fk_product_id','inventory_product.id')
                        ->where(['inventory.fk_product_id'=>$item->fk_product_id,'inventory.fk_model_id'=>$item->fk_model_id,'inventory.fk_branch_id'=>$branchId,'inventory.fk_company_id'=>$companyId])
                        ->select('inventory.id','available_qty','available_small_qty')
                        ->orderBy('id','asc')
                        ->first();
                    if($getInventory!=null){
                        $inventoryUpdateQty = array(
                            'available_qty' => $getInventory->available_qty-$qty+$item->sales_qty,
                            'available_small_qty' => 0,
                            'updated_at' => date('Y-m-d h:i:s')
                            );
                        $getInventory->update($inventoryUpdateQty);
                    }
                }
                $item->update([
                    'product_price_amount' => $input['product_price_amount'][$i],
                    'sales_qty'=>$input['sales_qty'][$i],
                    'small_qty'=>0,
                    'inventory_item_id' => $inventoryId,
                    'product_wise_discount'=>$qtyDiscount,
                    'product_paid_amount' => $input['product_paid_amount'][$i]-$discount,
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
            return redirect()->back()->with('success','Updated Successfully.');
        }else{
            return redirect()->back()->with('error','Something Error Found !, Please try again.'.$bug1);
        }
        
    }
    public function salesInvoice($invoice){
        
        
        $getInvoiceData=InventoryProductSales::leftJoin('inventory_clients','inventory_product_sales.fk_client_id','=','inventory_clients.id')
            ->leftJoin('users','inventory_product_sales.fk_user_id','=','users.id')
            ->select('inventory_product_sales.invoice_id','inventory_product_sales.order_id','inventory_product_sales.id','inventory_product_sales.date','inventory_product_sales.shipping_date','inventory_product_sales.total_amount','inventory_product_sales.paid_amount','inventory_product_sales.discount','inventory_clients.client_name','inventory_clients.mobile_no','inventory_clients.address','inventory_clients.email_id','inventory_clients.company_name','inventory_clients.client_id','summary','users.name as sales_by','inventory_clients.id as clientId','prev_paid','prev_amount')
            ->where('inventory_product_sales.invoice_id',$invoice)
            ->first();
            if($getInvoiceData==null){
                return redirect()->back()->with('error',"Invoice ($invoice) is not found!");
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
        $companyInfo = CompanyInfo::first();
        $emailConfig = EmailConfig::first();
        $challan=InventorySalesChallan::where('fk_sales_id',$getInvoiceData->id)->get();
       // return $getInvoiceData->id;
        return view('pos.sales.salesInvoice', compact('companyInfo','emailConfig','getInvoiceData','getProductData','challan','prev'));
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
        $productData = InventoryProductSales::findOrFail($id);
        DB::beginTransaction();
        try {
            if($productData->sales_type!=0){
                $challan=InventorySalesChallan::where('fk_sales_id',$id)->get();
                foreach ($challan as $key => $value) {
                    $items =  InventorySalesChallanItem::where('fk_sales_challan_id',$value->id)->get();
                    foreach ($items as $item) {
                        $product=InventorySalesChallanItem::leftJoin('inventory_product_sales_item','inventory_sales_challan_item.fk_sales_item_id','inventory_product_sales_item.id')
                            ->where('inventory_sales_challan_item.id',$item->id)->select('fk_product_id','qty','inventory_sales_challan_item.inventory_item_id')->first();
                        $inventoryIds=json_decode($product->inventory_item_id,true);
                            if(count($inventoryIds)>0){
                                foreach ($inventoryIds as $invId => $invValue) {
                                   $inventoryItem = InventoryItem::where('id',$invId)->first();
                                   if($inventoryItem!=null){ 
                                       $inventoryItem->update([
                                        'available_qty'=>$inventoryItem->available_qty+$invValue
                                       ]);
                                   }
                                }
                            }
                        $getInventory = Inventory::leftJoin('inventory_product','inventory.fk_product_id','inventory_product.id')
                        ->where(['fk_product_id'=>$product->fk_product_id,'inventory.fk_branch_id'=>$branchId,'inventory.fk_company_id'=>$companyId])
                        ->select('inventory.id','available_qty','available_small_qty')
                        ->orderBy('id','asc')
                        ->first();

                        if($getInventory!=null){

                        $inventoryUpdateQty = array(
                            'available_qty' => $getInventory->available_qty+$product->qty,
                            'available_small_qty' => 0,
                            'updated_at' => date('Y-m-d h:i:s')
                            );
                        
                        
                        $getInventory->update($inventoryUpdateQty);
                        }
                    }
                    InventorySalesChallanItem::where('fk_sales_challan_id',$value->id)->delete();
                    InventorySalesChallan::where('id',$value->id)->delete();
                }
            }
            InventoryProductSalesItem::where('fk_sales_id',$id)->delete();
            $productData->delete();
            DB::commit();
            $bug=0;
        }catch(\Exception $e){
            DB::rollback();
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect()->back()->with('success', 'Deleted Successfully .');
        }elseif($bug == 1451){
                return redirect()->back()->with('error','This Data Used AnyWhere.');
            }else{
            return redirect()->back()->with('error','Something Error Found !, Please try again.'.$bug1);
        }
    }

    public function productInfo(Request $request)
    {
        $id = $request->get('id');
        $getProduct = InventoryProduct::
        leftJoin('inventory','inventory_product.id','=','inventory.fk_product_id')
        ->where('inventory_product.id',$id)
        ->select('inventory.available_qty','inventory.sales_per_unit')
        ->first();
        return $getProduct;
    }

    public function searchProductToInventory(Request $request){
        $branchId=Auth::user()->fk_branch_id;
        $companyId=Auth::user()->fk_company_id;
        $type = $request->get('type');
        $name = $request->get('name_startsWith'); 
        $data = array();
        $result = Inventory::
            leftJoin('inventory_product','inventory.fk_product_id','=','inventory_product.id')
            ->leftJoin('inventory_small_unit','inventory_product.fk_small_unit_id','=','inventory_small_unit.id')
            ->leftJoin('inventory_product_model','inventory.fk_model_id','=','inventory_product_model.id')
            ->where(['inventory.fk_branch_id'=>$branchId,'inventory.fk_company_id'=>$companyId])
            ->where('inventory.available_qty','>',0)
            ->where('inventory_product.product_name', 'LIKE', $name .'%')
            ->where(['inventory.fk_branch_id'=>$branchId,'inventory.fk_company_id'=>$companyId])
            ->select('inventory_product.id as product_id','inventory_product.product_name','inventory_product.id','inventory_small_unit.small_unit_name','inventory.available_qty','inventory.available_small_qty','inventory.sales_per_unit','inventory.id as inventory_id','model_name','fk_model_id','cost_per_unit')
            ->orderBy('inventory.id','asc')->limit(10)
            ->get();
        $getResult = $result->toArray();
        foreach ($getResult as $row) {
            $productId=$row['product_id'];
            $salePrice=round($row['sales_per_unit'],2);

            $product_result =$row['product_name'].' ('.$row['model_name'].')|'.$row['id'].'|'.$salePrice.'|'.$row['available_qty'].'|'.$row['small_unit_name'].'|'.$row['fk_model_id'].'|'.round($row['cost_per_unit'],3);
            array_push($data, $product_result);
        }
        //return $name;exit;
          
        return json_encode($data);exit;   
    }
    public function due(){
        return view('pos.sales.salesDue');
    }

    public function viewAllDue(){
        $branchId=Auth::user()->fk_branch_id;
        $companyId=Auth::user()->fk_company_id;
        $query  = InventoryProductSales::leftJoin('inventory_branch','inventory_product_sales.fk_branch_id','inventory_branch.id')
        ->leftJoin('inventory_clients','inventory_product_sales.fk_client_id','inventory_clients.id')
        ->select('inventory_product_sales.*','inventory_clients.client_name','inventory_clients.company_name','branch_name')
        ->whereColumn('total_amount','>','paid_amount')
        ->orderBy('inventory_product_sales.id','desc');
        if(Auth::user()->isRole('administrator')){
            $sales=$query->get();
        }else{
            $sales=$query->where(['inventory_product_sales.fk_branch_id'=>$branchId,'inventory_product_sales.fk_company_id'=>$companyId])->get();
        }
        $j=0;
        foreach($sales as $key => $sell){
            $j++; 
            $sales[$key]['sl']=$j;
            $due=round($sell->total_amount,2)-round($sell->paid_amount,2);
            if($due==0){
                unset($sales[$key]);
            }

        }
        
            //return $customer;
        return Datatables::of($sales)
            ->addColumn('invoice_id','
                <a target="_blank" href=\'{{URL::to("inventory-sales-invoice/$invoice_id")}}\' target="_blank" title="View Browser">{{$invoice_id}}</a>
                ')
            ->addColumn('total_amount', '{{round($total_amount,2)}}')
            ->addColumn('paid_amount', '{{round($paid_amount,2)}}')
            ->addColumn('due_amount', '{{round($total_amount-$paid_amount,2)}}')
            ->addColumn('action', '
                @if(round($total_amount,2)>round($paid_amount,2))

                    <a target="_blank" href=\'{{URL::to("inventory-product-sales-due-paid/$id")}}\' class="btn btn-xs btn-danger">Due</a>
                @else
                    <a class="btn btn-xs btn-info">Paid</a>

                @endif
                ')
            ->rawColumns(['invoice_id','action'])
            ->make(true);
    }
     public function clientDue($id){
        return view('pos.sales.clientsDue',compact('id'));
    }
    public function viewClientDue(Request $request){
        $id=$request->id;
        $sales  = InventoryProductSales::
        leftJoin('inventory_clients','inventory_product_sales.fk_client_id','inventory_clients.id')
        ->select('inventory_product_sales.*','inventory_clients.client_name')
        ->where('inventory_clients.id',$id)
        ->orderBy('inventory_product_sales.id','desc')
        ->get();
        $j=0;
        foreach ($sales as $key => $value) {
            $j++; 
            $sales[$key]['sl']=$j;
        }
            //return $customer;
        return Datatables::of($sales)
            ->editColumn('action',function($data){
                $lastInvoice=InventorySalesPaymentHistory::where("fk_sales_id",$data->id)->orderBy("id","desc")->value('invoice_id');
                $domain=\URL::to('/');
                if($lastInvoice==null){
                  $lastInvoice=0;
                   }
                   if(round($data->total_amount,2)>round($data->paid_amount,2)){

                        return '<a target="_blank" href="'. $domain.'/inventory-product-sales-due-paid/'.$data->id.'" class="btn btn-xs btn-danger">Due</a>';
                    }else{

                        return '<a href="'.$domain.'/inventory-sales-invoice/'.$lastInvoice.'" target="_blank" title="View Paid Browser" class="btn btn-xs btn-info">Paid</a>';
                    }        
            })
            ->addColumn('invoice_id','
                <a href=\'{{URL::to("inventory-sales-invoice/$invoice_id")}}\' target="_blank" title="View Browser">{{$invoice_id}}</a>
                ')
            ->addColumn('total_amount', '{{round($total_amount,2)}}')
            ->addColumn('paid_amount', '{{round($paid_amount,2)}}')
            ->addColumn('due_amount', '{{round($total_amount-$paid_amount,2)}}')
            ->rawColumns(['action','invoice_id'])
            ->make(true);
    }

    public function loadClientInfo($id){
        $client=InventoryClient::findOrFail($id);
        return view('pos.sales.clientInfo',compact('client'));
    }
 

    /*Due Paid*/
     public function duePaid($id)
    {
        $getInvoiceData = InventoryProductSales::
        leftJoin('inventory_clients','inventory_product_sales.fk_client_id','=','inventory_clients.id')
        ->where('inventory_product_sales.id',$id)
        ->select('inventory_product_sales.id','inventory_product_sales.invoice_id','inventory_product_sales.summary','inventory_product_sales.date','inventory_product_sales.total_amount','inventory_product_sales.paid_amount','inventory_clients.client_id','inventory_clients.client_name','inventory_clients.mobile_no','inventory_clients.address','inventory_clients.email_id','inventory_clients.company_name')
        ->first();
        
        $getProductData = InventoryProductSalesItem::
        leftJoin('inventory_product_sales','inventory_product_sales_item.fk_sales_id','=','inventory_product_sales.id')
        ->leftJoin('inventory_product','inventory_product_sales_item.fk_product_id','=','inventory_product.id')
        ->leftJoin('unit_of_measurement','inventory_product.fk_uom_id','=','unit_of_measurement.id')
        ->where('inventory_product_sales.id',$id)
        ->select('inventory_product_sales_item.product_price_amount','inventory_product_sales_item.sales_qty','inventory_product_sales_item.product_wise_discount','inventory_product_sales_item.product_paid_amount','inventory_product.product_name','inventory_product.specification','inventory_product.barcode','unit_of_measurement.uom_name')
        ->get();
        $history=InventorySalesPaymentHistory::where('invoice_id',$getInvoiceData->invoice_id)->first();
        $account=AccountSetting::where('account_status',1)->pluck('account_name','id');
        $method=PaymentMethod::where('method_status',1)->pluck('method_name','id');
        $receiver = InventoryReceiveExecutive::where('status',1)->pluck('executive_name','id');
        return view('pos.sales.duePaid', compact('getInvoiceData','getProductData','history','account','receiver','method'));
    }

    public function dueUpdate(Request $request, $id)
    {
        $newDate = date("Y-m-d", strtotime($request->date));
        $data=InventoryProductSales::findOrFail($id);
        $data->update([
            'paid_amount'=>$request->last_paid+$request->paid_amount,
            'summary'=>$request->summary
            ]);
        $lastId=InventorySalesPaymentHistory::max('id')+1;
        $invoice=date('ymd').$lastId;
        if($request->last_due>0 and $request->paid_amount>0){
        InventorySalesPaymentHistory::create([
            'invoice_id'=>$invoice,
            'fk_sales_id'=>$id,
            'last_due'=>$request->last_due,
            'paid'=>$request->paid_amount,
            'payment_date'=>$newDate,
            'created_by'=>Auth::user()->id,
            'fk_account_id'=>$request->fk_account_id,
            'fk_method_id'=>$request->fk_method_id,
            'ref_id'=>$request->ref_id,
            'fk_received_id'=>$request->fk_received_id,
            ]);
        }else{
           return redirect("/inventory-sales-invoice/$data->invoice_id"); 
        }

        try {
            
            $bug = 0;
            
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect("/inventory-sales-invoice/$invoice")->with('success','Due Payment Successfully.');
        }else{
            return redirect()->back()->with('error','Something Error Found !, Please try again.'.$bug1);
        }
        
    }



}
