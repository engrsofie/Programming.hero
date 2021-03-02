<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\InventoryProduct;
use App\Models\InventoryCategories;
use App\Models\InventoryUOM;
use App\Models\InventoryBrand;
use App\Models\InventorySupplier;
use App\Models\InventoryProductOrder;
use App\Models\InventoryProductOrderItem;
use App\Models\InventoryStockPosition;
use App\Models\Inventory;
use App\Models\InventoryItem;
use App\Models\InventoryOrderPayment;
use App\Models\CompanyInfo;
use App\Models\EmailConfig;
use App\Models\InventoryProductOrderChallan;
use App\Models\InventoryProductOrderChallanItem;
use App\Models\AccountSetting;
use App\Models\PaymentMethod;
use App\Models\InventoryProductOrderExpenseList;
use Yajra\DataTables\DataTables;
use Validator;
use DB;
use Auth;

class InventoryProductOrderController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {   
        
        $getProductData = InventoryProduct::orderBy('id','desc')->get();
        $getBrand = InventoryBrand::where('status','1')->get();
        $getUOM = InventoryUOM::where('status','1')->get();
        $getCategories = InventoryCategories::where('status','1')->get();
        $getProductOrder = InventoryProductOrder::leftJoin('inventory_supplier','inventory_product_order.fk_supplier_id','inventory_supplier.id')->select('inventory_product_order.*','company_name')->where('inventory_product_order.status',1)->orderBy('inventory_product_order.id','desc')->paginate(5);
        return view('pos.product_order.viewProductOrder', compact('getProductData','getBrand','getUOM','getCategories','getProductOrder'));
        
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $companyInfo = CompanyInfo::first();
        $getSupplier = InventorySupplier::where('status','1')->get();
        $getProductData = InventoryProduct::where('status','1')->get();
        $account=AccountSetting::where('account_status',1)->pluck('account_name','id');
        $method=PaymentMethod::where('method_status',1)->pluck('method_name','id');
        $expenses=InventoryProductOrderExpenseList::where('status',1)->pluck('title','title');
        
        return view('pos.product_order.index' ,compact('getSupplier','getProductData','companyInfo','account','method','expenses'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(),[
                'fk_supplier_id' => 'required',
                'fk_product_id' => 'required',
                'fk_account_id' => 'required',
                'fk_method_id' => 'required',

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }

        $input = $request->except('_token');
         $lastId=InventoryOrderPayment::max('id')+1;
        $input['inventory_order_id'] = "P".date('ymd').$lastId;
        $invoice=$input['inventory_order_id'];
        $date = $input['order_date'];
        $newDate = date("Y-m-d", strtotime($date));
        $input['order_date'] = $newDate;
        
        DB::beginTransaction();
        try {
            
        $order_id = InventoryProductOrder::create($input)->id;
            InventoryOrderPayment::create([
                'fk_order_id'=>$order_id,
                'invoice_id'=>$invoice,
                'last_due'=>$input['total_amount'],
                'paid'=>$input['total_paid'],
                'payment_date'=>$input['order_date'],
                'created_by'=>\Auth::user()->id
                ]);
            for ($i=0; $i < sizeof($input['fk_product_id']); $i++) { 
                InventoryProductOrderItem::create([
                    'fk_product_order_id'=> $order_id,
                    'fk_product_id'=>$input['fk_product_id'][$i],
                    'qty'=>$input['qty'][$i],
                    'free_of_cost'=>$input['free_of_cost'][$i],
                    'cost_per_unit'=>$input['foreign_amount'][$i]*$input['bdt_rates'][$i],
                    'sales_per_unit'=>$input['foreign_amount'][$i]*$input['bdt_rates'][$i],
                    'payable_amount'=>$input['amount'][$i],
                    'currency_name'=>$input['currency_name'][$i],
                    'foreign_amount'=>$input['foreign_amount'][$i],
                    'bdt_rates'=>$input['bdt_rates'][$i]
                    ]);
            }
           
        
            
            
            $bug = 0;
            DB::commit();
            
            
        } catch (\Exception $e) {
            DB::rollback();
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect("inventory-order-browser/$invoice")->with('success','Order Created Successfully.');
        }else{
            return redirect('inventory-product-order/create')->with('error','Something Error Found!, Please try again.'.$bug1);
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
        
        $getOrder = InventoryProductOrder::
        leftJoin('inventory_supplier','inventory_product_order.fk_supplier_id','=','inventory_supplier.id')
        ->where('inventory_product_order.id',$id)
        ->select('inventory_product_order.*','inventory_supplier.company_name as client_name')
        ->first();
        if($getOrder==null){
            return redirect()->back();
        }

        $getOrderItem = InventoryProductOrderItem::
        leftJoin('inventory_product','inventory_product_order_item.fk_product_id','=','inventory_product.id')
       
        ->leftJoin('inventory_small_unit','inventory_product.fk_small_unit_id','=','inventory_small_unit.id')
        ->where('inventory_product_order_item.fk_product_order_id',$id)
        ->select('inventory_product_order_item.*','inventory_product.product_name','inventory_small_unit.small_unit_name as uom_name')
        ->get();
        $stockPosition=InventoryStockPosition::where('status',1)->pluck('position_name','id');
        $challan=InventoryProductOrderChallan::where('fk_order_id',$id)->select(DB::raw('SUM(total_amount) as total_amount'))->first();
        $challanItem=InventoryProductOrderChallanItem::leftJoin('inventory_product_order_challan','inventory_product_order_challan_item.fk_order_challan_id','inventory_product_order_challan.id')
            ->select('fk_order_item_id',DB::raw('SUM(payable_amount) as payable_amount'),DB::raw('SUM(qty) as qty'),DB::raw('SUM(free_of_cost) as free_of_cost'))
            ->where('fk_order_id',$id)
            ->groupBy('fk_order_item_id')->get();
        foreach ($getOrderItem as $key => $value) {
           foreach ($challanItem as $item) {
               if($value->id==$item->fk_order_item_id){
                  $getOrderItem[$key]['qty'] = $value->qty-$item->qty;
                  $getOrderItem[$key]['free_of_cost'] = $value->free_of_cost-$item->free_of_cost;
                  $getOrderItem[$key]['payable_amount'] = $value->payable_amount-$item->payable_amount;
               }
           }
        }
        $getOrder->total_amount=$getOrder->total_amount-$challan->total_amount;
        $oldChallan=InventoryProductOrderChallan::where('fk_order_id',$id)->get();
        return view('pos.product_order.single_order_view', compact('getOrder','getOrderItem','stockPosition','id','oldChallan'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $getOrder = InventoryProductOrder::
        leftJoin('inventory_supplier','inventory_product_order.fk_supplier_id','=','inventory_supplier.id')
        ->where('inventory_product_order.id',$id)
        ->select('inventory_product_order.*','inventory_supplier.supplier_id as client_id','inventory_supplier.company_name as client_name','inventory_supplier.mobile_no','inventory_supplier.address','inventory_supplier.email_id','inventory_supplier.company_name as client_name')
        ->first();
        if($getOrder==null){
            return redirect()->back();
        }
        $getOrderItem = InventoryProductOrderItem::
        leftJoin('inventory_product','inventory_product_order_item.fk_product_id','=','inventory_product.id')
        ->leftJoin('inventory_small_unit','inventory_product.fk_small_unit_id','=','inventory_small_unit.id')
        ->where('inventory_product_order_item.fk_product_order_id',$id)
        ->select('inventory_product_order_item.*','inventory_product.product_name','inventory_product.barcode','inventory_small_unit.small_unit_name as uom_name')
        ->get();
        $expenses=InventoryProductOrderExpenseList::where('status',1)->pluck('title','title');
        $oldExpenses=DB::table('inventory_product_order_other_expenses')->where('fk_order_id',$id)->get();
        $account=AccountSetting::where('account_status',1)->pluck('account_name','id');
        $method=PaymentMethod::where('method_status',1)->pluck('method_name','id');
        
        return view('pos.product_order.edit', compact('getOrder','getOrderItem','account','method','expenses','oldExpenses'));
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
        $input = $request->except('_method','_token');
        $validator = Validator::make($request->all(),[
                'created_by' => 'required',

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }
        $other_expense=0;
          for ($j=0; $j < sizeof($input['other_expense']) ; $j++) { 
            $other_expense+=$input['other_expense'][$j];
          }
          if(isset($input['expense_amount'])){

              for ($j=0; $j <sizeof($input['expense_amount']) ; $j++) { 
                $other_expense+=$input['expense_amount'][$j];
              }  
          }
          $input['other_expenses']=$other_expense;
          $input['opening_date']=date('Y-m-d',strtotime($request->opening_date));
          $input['order_date']=date('Y-m-d',strtotime($request->order_date));
        $orderData = InventoryProductOrder::findOrFail($id);
         /*calculation for expense*/
          $totalHundrad = $input['total_amount']/100;
          $expensePercentage =$other_expense/$totalHundrad;
            $orderData->update([
                'summery'=>$input['summery'],
                'shipping_address'=>$input['shipping_address'],
                'total_amount'=>$input['total_amount'],
                'total_price_with_expenses'=>$input['total_price_with_expenses'],
                'total_paid'=>$input['total_paid'],
                'fk_account_id'=>$request->fk_account_id,
                'fk_method_id'=>$request->fk_method_id,
                'lc_no'=>$input['lc_no'],
                'opening_date'=>$input['opening_date'],
                'opening_date'=>$input['opening_date'],
                'order_date'=>$input['order_date'],
                'ref_id'=>$input['ref_id'],
                'other_expenses'=>$input['other_expenses'],
                ]);
            /*Oreder Paynment Update*/
            InventoryOrderPayment::where('fk_order_id',$id)->where('invoice_id',$orderData->inventory_order_id)->update([
                'last_due'=>$input['total_amount'],
                'paid'=>$input['total_paid'],
                'payment_date'=>$input['order_date'],
                'created_by'=>\Auth::user()->id
                ]);
        for ($i=0; $i < sizeof($input['item_id']); $i++) { 
                $item_id = $input['item_id'][$i];
                $exp=($input['amount'][$i]/100)*$expensePercentage;
                $perQtyExp=$exp/$input['qty'][$i];
                $orderItem = InventoryProductOrderItem::where('id',$item_id)->update([
                    'qty'=>$input['qty'][$i],
                    'free_of_cost'=>$input['free_of_cost'][$i],
                    'cost_per_unit'=>$input['foreign_amount'][$i]*$input['bdt_rates'][$i],
                    'sales_per_unit'=>$input['foreign_amount'][$i]*$input['bdt_rates'][$i],
                    'payable_amount'=>$input['amount'][$i],
                    'other_expense'=>$perQtyExp,
                    'currency_name'=>$input['currency_name'][$i],
                    'foreign_amount'=>$input['foreign_amount'][$i],
                    'bdt_rates'=>$input['bdt_rates'][$i]
                    ]);
            }
            /*insert new other_expense*/
        for ($j=0; $j <sizeof($input['other_expense']) ; $j++) { 
                if($input['other_expense'][$j]>0){

                    DB::table('inventory_product_order_other_expenses')->insert([
                        'other_expense_title'=>$input['other_expense_title'][$j],
                        'other_expense'=>$input['other_expense'][$j],
                        'fk_order_id'=>$id,
                        ]);
                }
            }
            /*update other_expense*/
        if(isset($input['other_expense_id'])){

            for ($j=0; $j <sizeof($input['other_expense_id']) ; $j++) {

                $expenseId = $input['other_expense_id'][$j];

                    DB::table('inventory_product_order_other_expenses')->where('id',$expenseId)->where('fk_order_id',$id)->update([
                        'other_expense_title'=>$input['expense_title'][$j],
                        'other_expense'=>$input['expense_amount'][$j]
                        ]);
                
            }
        }
        DB::beginTransaction();
        try {

            $bug = 0;
            DB::commit();
        } catch (\Exception $e) {
            DB::rollback();
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect("inventory-order-browser/$orderData->inventory_order_id")->with('success','Updated successFully.');
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
            
            
        try {
            $productData = InventoryProductOrder::findOrFail($id);
            InventoryOrderPayment::where('fk_order_id',$id)->delete();
            InventoryProductOrderItem::where('fk_product_order_id',$id)->delete();
            DB::table('inventory_product_order_other_expenses')->where('fk_order_id',$id)->delete();
            $productData->delete();
            $bug = 0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect('inventory-product-order')->with('success', 'Order Deleted Successfully .');
        }elseif($bug == 1451){
                return redirect('inventory-product-order')->with('error','This Data Used Any Where.');
            }else{
            return redirect('inventory-product-order')->with('error','Something Error Found !, Please try again.'.$bug1);
        }


    }

    //add to inventory
    public function addToInventory(Request $request)
    {
        $validator = Validator::make($request->all(),[
                'id' => 'required'

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }

        $input = $request->except('_token');
        $id = $input['id'];
        $getProductOrder = InventoryProductOrder::findOrFail($id);
        $challan=InventoryProductOrderChallan::where('fk_order_id',$id)->select(DB::raw('SUM(total_amount) as total_amount'))->first();
        $total_amount= $challan->total_amount+$input['total_amount'];
        if($input['total_amount']==0){
            return redirect()->back()->with('error','This challan is not possible.');
        }
        DB::beginTransaction();
        try {
            $challanId=InventoryProductOrderChallan::create([
                'fk_order_id'=>$input['id'],
                'challan_id'=>$input['challan_id'],
                'received_date'=>$input['received_date'],
                'total_amount'=>$input['total_amount'],
                'created_by'=>Auth::user()->id,
                ])->id;
            for ($i=0; $i <sizeof($input['order_item_id']) ; $i++) { 
                 $orderItemId=$input['order_item_id'][$i];
                $orderItem=InventoryProductOrderItem::findOrFail($orderItemId);
                $product_id = $orderItem->fk_product_id;
                $totalSalesAmount = $orderItem->qty*($orderItem->sales_per_unit+$orderItem->other_expense);
                $sales_per_unit=$totalSalesAmount/($orderItem->qty+$orderItem->free_of_cost);
                $qty = $input['qty'][$i];
                if($input['free_of_cost'][$i]!=null){
                    $free_of_cost = $input['free_of_cost'][$i];
                }else{
                    $free_of_cost=0;
                }
                $fk_stock_position_id = $input['fk_stock_position_id'][$i];
                $searchInventory = Inventory::
                leftJoin('inventory_item','inventory.id','inventory_item.fk_inventory_id')
                ->where('fk_product_id',$product_id)->select('inventory_item.brach_no','inventory_item.fk_inventory_id','inventory.available_qty','inventory.sales_per_unit')->orderBy('inventory_item.id','desc')->first();
                if($searchInventory!=null){
                    $old_brach_no = $searchInventory->brach_no;
                    $last_no =  explode('-', $old_brach_no);
                    $new_no = $last_no[2]+1;
                    $batch_no = "B-".$product_id."-".$new_no;
                    $getInventory = Inventory::where('fk_product_id',$product_id)->first();
                    $availableQty = floatval($searchInventory->available_qty)+floatval($qty)+floatval($free_of_cost);
                    $inventoryUpdateQty = array(
                        'available_qty' => $availableQty,
                        'sales_per_unit' => $sales_per_unit,
                        'cost_per_unit'  => $sales_per_unit,
                        'updated_at' => date('Y-m-d h:i:s')
                        );
                    $getInventory->update($inventoryUpdateQty);
                    $inventory_id = $searchInventory->fk_inventory_id;
                }else{
                    $batch_no = "B-".$product_id."-1";
                    $addToInventoryItem = [
                        'fk_product_id'  => $product_id,
                        'available_qty'  => $qty+$free_of_cost,
                        'cost_per_unit'  => $sales_per_unit,
                        'sales_per_unit' => $sales_per_unit
                    ]; 
                    $inventory_id = Inventory::create($addToInventoryItem)->id; 
                }
                $addToInventoryItem = [
                    'fk_inventory_id'  => $inventory_id,
                    'brach_no'       => $batch_no,
                    'qty'            => $qty+$free_of_cost,
                    'available_qty'  => $qty+$free_of_cost,
                    'cost_per_unit'  => $sales_per_unit,
                    'sales_per_unit' => $sales_per_unit,
                    'fk_stock_position_id' => $fk_stock_position_id,
                ]; 
                //return $addToInventory;exit;
                InventoryItem::create($addToInventoryItem); 

               
                $challanItem=InventoryProductOrderChallanItem::create([
                    'fk_order_challan_id'=>$challanId,
                    'fk_order_item_id'=>$orderItemId,
                    'free_of_cost'=>$free_of_cost,
                    'qty'=>$qty,
                    'batch_no'=>$batch_no,
                    'payable_amount'=>$input['amount'][$i],
                    ]);
            } 

            if($total_amount == $getProductOrder->total_amount){
                $getProductOrder->update(['status'=>0]);
            }
            DB::commit();
            $bug = 0;
            
        } catch (\Exception $e) {
            DB::rollback();
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){

            return redirect('inventory-product-order')->with('success','Successfully added to Inventory .');
        }else{
            return redirect('inventory-product-order')->with('error','Something Error Found !, Please try again.'.$bug1);
        }

    }

    public function searchProduct(Request $request){
        
        $type = $request->get('type');
        $name = $request->get('name_startsWith'); 
        
        $data = array();
        $result = InventoryProduct::leftJoin('inventory_small_unit','inventory_product.fk_small_unit_id','=','inventory_small_unit.id')
            ->where('inventory_product.status','=', '1')
            ->where('inventory_product.product_name', 'LIKE', $name .'%')
            ->select('inventory_product.barcode','inventory_product.product_name','inventory_product.id','inventory_small_unit.small_unit_name')
            ->orderBy('inventory_product.id','desc')->limit(10)
            ->get();
        $getResult = $result->toArray();
        foreach ($getResult as $row) {
        
            $product_result = $row['barcode'].'|'.$row['product_name'].'|'.$row['id'].'|'.$row['small_unit_name'];
            array_push($data, $product_result);
        }
        //return $name;exit;
          
        return json_encode($data);exit;   
    }
    public function due(){
        return view('pos.product_order.dueOrder');
    }
    public function allDue(){
        $getProductOrder = InventoryProductOrder::leftJoin('inventory_supplier','inventory_product_order.fk_supplier_id','inventory_supplier.id')
        ->select('inventory_product_order.*','inventory_supplier.company_name','inventory_supplier.representative')
        ->orderBy('inventory_product_order.id','ASC')->get();
        return Datatables::of($getProductOrder)
            ->addColumn('status', '
                @if($status!=1)
                    <b class="text-success">Added</b>
                    @else
                    <b class="text-warning">Pending</b>
                @endif
                ')
            ->addColumn('inventory_order_id', '<a target="_blank" href=\'{{URL::to("inventory-order-browser/$inventory_order_id")}}\'>{{$inventory_order_id}}</a>')
            ->addColumn('total_amount', '{{round($total_amount,2)}}')
            ->addColumn('action', '
                    
                    <a href=\'{{URL::to("inventory-product-order/$id")}}\' class="btn btn-primary btn-xs" title="view description"><i class="fa fa-eye"></i></a>
                    <a target="_blank" href=\'{{URL::to("inventory-product-order/$id/edit")}}\' class="btn btn-warning btn-xs"><i class="fa fa-pencil-square"></i></a>

                    @if(round($total_amount,2)>round($total_paid,2))

                    <a target="_blank" href=\'{{URL::to("inventory-product-order-due-paid/$id")}}\' class="btn btn-danger btn-xs">Due</a>
                    @else
                    <a target="_blank" href=\'{{URL::to("inventory-order-browser/$inventory_order_id")}}\' class="btn btn-info btn-xs">Paid</a>
                    @endif
                    {!! Form::open(array(\'route\'=> [\'inventory-product-order.destroy\',$id],\'method\'=>\'DELETE\')) !!}
                        {{ Form::hidden(\'id\',$id)}}
                        <button type="submit" onclick="return confirmDelete();" class="btn btn-xs btn-danger">
                          <i class="fa fa-trash-o" aria-hidden="true"></i>
                        </button>
                    {!! Form::close() !!}
                ')
            ->rawColumns(['inventory_order_id','status','action'])
            ->make(true);
    }
    public function orderBrowser($invoice){
        $getInvoiceData=InventoryOrderPayment::leftJoin('inventory_product_order','inventory_order_payment.fk_order_id','inventory_product_order.id')
        ->leftJoin('inventory_supplier','inventory_product_order.fk_supplier_id','=','inventory_supplier.id')
        ->select('inventory_product_order.inventory_order_id','inventory_product_order.opening_date','inventory_product_order.lc_no','inventory_product_order.other_expenses','inventory_product_order.shipping_address','inventory_product_order.id','inventory_product_order.order_date','inventory_product_order.total_amount','inventory_product_order.total_paid','inventory_supplier.representative','inventory_supplier.mobile_no','inventory_supplier.address','inventory_supplier.email_id','inventory_supplier.company_name as client_name','inventory_supplier.supplier_id as client_id','inventory_order_payment.invoice_id','inventory_order_payment.last_due','inventory_order_payment.paid','inventory_order_payment.payment_date')
        ->where('inventory_order_payment.invoice_id',$invoice)
        ->orderBy('inventory_order_payment.id','desc')
        ->first();
        if($getInvoiceData==null){
            return redirect()->back();
        }
        $getProductData = InventoryProductOrderItem::
        leftJoin('inventory_product','inventory_product_order_item.fk_product_id','=','inventory_product.id')
        ->leftJoin('inventory_small_unit','inventory_product.fk_small_unit_id','=','inventory_small_unit.id')
        ->where('inventory_product_order_item.fk_product_order_id',$getInvoiceData->id)
        ->select('inventory_product_order_item.*','inventory_product.product_name','inventory_product.barcode','inventory_small_unit.small_unit_name')
        ->get();

        $expenses=DB::table('inventory_product_order_other_expenses')->where('fk_order_id',$getInvoiceData->id)->get();
         $companyInfo = CompanyInfo::first();
        $emailConfig = EmailConfig::first();
        
        return view('pos.product_order.orderBrowser', compact('companyInfo','emailConfig','getInvoiceData','getProductData','expenses'));
    }

    public function duePaid($id)
    {
        $getOrder = InventoryProductOrder::
        leftJoin('inventory_supplier','inventory_product_order.fk_supplier_id','=','inventory_supplier.id')
        ->where('inventory_product_order.id',$id)
        ->select('inventory_product_order.*','inventory_supplier.supplier_id as client_id','inventory_supplier.company_name as client_name','inventory_supplier.mobile_no','inventory_supplier.address','inventory_supplier.email_id','inventory_supplier.company_name as client_name')
        ->first();
        if($getOrder==null){
            return redirect()->back();
        }
        $getOrderItem = InventoryProductOrderItem::
        leftJoin('inventory_product','inventory_product_order_item.fk_product_id','=','inventory_product.id')
        
        ->where('inventory_product_order_item.fk_product_order_id',$id)
        ->select('inventory_product_order_item.*','inventory_product.product_name','inventory_product.barcode')
        ->get();
        
        return view('pos.product_order.duePaid', compact('getOrder','getOrderItem'));
    }

    public function dueUpdate(Request $request)
    {
         $validator = Validator::make($request->all(),[
                'created_by' => 'required',
                'last_due' => 'required'

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }
        $input = $request->except('_token');
        $orderData = InventoryProductOrder::findOrFail($input['id']);
        $lastId=InventoryOrderPayment::max('id')+1;
        $invoice = date('ymd').$lastId;
         
        try {

             $orderData->update([
                'summery'=>$input['summery'],
                'total_paid'=>$orderData->total_paid+$input['paid'],
                ]);
            if($input['last_due']>0 and $input['paid']>0){

               InventoryOrderPayment::create([
                    'fk_order_id'=>$input['id'],
                    'invoice_id'=>$invoice,
                    'last_due'=>$input['last_due'],
                    'paid'=>$input['paid'],
                    'payment_date'=>$input['payment_date'],
                    'created_by'=>\Auth::user()->id
                ]); 
            }else{
                return redirect()->back();
            }
              
            $bug = 0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect("inventory-order-browser/$invoice")->with('success','Due Paid successFully.');
        }else{
            return redirect()->back()->with('error','Something Error Found !, Please try again.'.$bug1);
        }

    }
    









}
