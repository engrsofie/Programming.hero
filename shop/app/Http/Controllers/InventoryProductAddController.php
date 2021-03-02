<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\InventoryProductAdd;
use App\Models\InventoryProductAddItem;
use App\Models\InventoryStockPosition;
use App\Models\Inventory;
use App\Models\InventoryItem;
use App\Models\InventorySupplier;
use App\Models\InventoryOrderPayment;
use App\Models\InventoryOrderPaymentItem;
use App\Models\InventoryProductModel;
use App\Models\InventoryBranch;
use Yajra\DataTables\DataTables;
use Validator;
use DB;
use Auth;

class InventoryProductAddController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        
        return view('pos.addItem.index');
    }
    public function all()
    {
        $branchId=Auth::user()->fk_branch_id;
        $companyId=Auth::user()->fk_company_id;
         $allData = InventoryProductAdd::leftJoin('inventory_supplier','inventory_product_add.fk_supplier_id','inventory_supplier.id')
         ->select('inventory_product_add.id','inventory_product_add.date','total_amount','inventory_product_add.inventory_order_id','total_paid','company_name')
         ->orderBy('inventory_product_add.id','DESC');
         return Datatables::of($allData)
            ->addColumn('inventory_order_id','<a href=\'<? echo URL::to("inventory-product-add/$inventory_order_id") ?>\' title="View Browser">{{$inventory_order_id}}</a>')
            ->addColumn('total_amount', '{{round($total_amount,2)}}')
            ->addColumn('total_paid', '{{round($total_paid,2)}}')
            ->addColumn('action', '
                <a href=\'{{URL::to("inventory-product-add/$inventory_order_id")}}\' class="btn btn-primary btn-xs" title="view description"><i class="fa fa-eye"></i></a>
                <a href=\'{{URL::to("inventory-product-add/$id/edit")}}\' class="btn btn-warning btn-xs"><i class="fa fa-pencil-square"></i></a>
                {!! Form::open(array(\'route\'=> [\'inventory-product-add.destroy\',$id],\'method\'=>\'DELETE\')) !!}
                    <button type="submit" onclick="return confirmDelete();" class="btn btn-xs btn-danger">
                      <i class="fa fa-trash-o" aria-hidden="true"></i>
                    </button>
                {!! Form::close() !!}
                ')

            ->rawColumns(['inventory_order_id','action'])
            ->make(true);

    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $lastId=InventoryProductAdd::max('id')+1;
        $invoice = 'A'.date('ymd').$lastId;
        $branch=InventoryBranch::where('status',1)->pluck('branch_name','id');
        $ownBranch=InventoryBranch::where('id',Auth::user()->fk_branch_id)->first();
        return view('pos.addItem.create',compact('invoice','branch','ownBranch'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $companyId=Auth::user()->fk_company_id;
        $validator = Validator::make($request->all(),[
                'fk_product_id' => 'required',
                'fk_branch_id' => 'required',
                'total_amount' => 'required',

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }

        $input = $request->except('_token');
        
        $input['fk_company_id']=Auth::user()->fk_company_id;
        $input['date']=date('Y-m-d',strtotime($input['date']));
         $lastId=InventoryProductAdd::max('id')+1;
        $input['inventory_order_id'] = 'A'.date('ymd').$lastId;
        $invoice=$input['inventory_order_id'];
        $input['fk_supplier_id'] = InventorySupplier::createNew($input['supplier_name']);
        DB::beginTransaction();
        $order_id = InventoryProductAdd::create($input)->id;
        $orderInvoice=InventoryOrderPayment::max('id')+1;
        $paymentId = InventoryOrderPayment::create([
                'invoice_id'=>$orderInvoice,
                'last_due'=>$input['total_amount'],
                'fk_supplier_id'=>$input['fk_supplier_id'],
                'paid'=>$input['total_paid'],
                'type'=>1,
                'payment_date'=>$input['date'],
                'created_by'=>\Auth::user()->id
                ])->id;
        InventoryOrderPaymentItem::create([
                'fk_order_id'=>$order_id,
                'fk_order_payment_id'=>$paymentId,
                'type'=>1,
                'order_last_due'=>$input['total_amount'],
                'order_paid'=>$input['total_paid'],
                ]);
            for ($i=0; $i < sizeof($input['fk_product_id']); $i++) { 
                $model = InventoryProductModel::createNew($input['product_model'][$i],$input['fk_product_id'][$i]);
                $product_id = $input['fk_product_id'][$i];
                $cost_per_unit = $input['cost_per_unit'][$i];
                $sales_per_unit = $input['sales_per_unit'][$i];
                $qty = $input['qty'][$i];
                $branchId = $input['fk_branch_id'][$i];
              
                $searchInventory = Inventory::
                leftJoin('inventory_item','inventory.id','inventory_item.fk_inventory_id')
                ->where(['fk_product_id'=>$product_id,'fk_model_id'=>$model,'inventory.fk_branch_id'=>$branchId,'inventory.fk_company_id'=>$companyId])->select('inventory_item.brach_no','inventory.id','inventory.available_qty','inventory.sales_per_unit')->orderBy('inventory_item.id','desc')->first();
                if($searchInventory!=null){
                    $old_brach_no = $searchInventory->brach_no;
                    if($old_brach_no!=null){
                        $last_no =  explode('-', $old_brach_no);
                        $new_no = $last_no[2]+1;
                    }else{
                         $new_no=1;
                    }
                    $brach_no = "B-".$product_id."-".$new_no.'-'.$branchId.'-'.$companyId.'-'.$model;
                    $getInventory = Inventory::where(['fk_product_id'=>$product_id,'fk_model_id'=>$model,'inventory.fk_branch_id'=>$branchId,'inventory.fk_company_id'=>$companyId])->first();
                    $availableQty = floatval($searchInventory->available_qty)+floatval($qty);
                    $inventoryUpdateQty = array(
                        'available_qty' => $availableQty,
                        'sales_per_unit' => $sales_per_unit,
                        'cost_per_unit'  => $cost_per_unit,
                        'updated_at' => date('Y-m-d h:i:s')
                        );
                    $getInventory->update($inventoryUpdateQty);
                    $inventory_id = $searchInventory->id;
                }else{
                    $brach_no = "B-".$product_id."-1".'-'.$branchId.'-'.$companyId.'-'.$model;
                    $addToInventoryItem = [
                        'fk_product_id'  => $product_id,
                        'available_qty'  => $qty,
                        'fk_model_id' => $model,
                        'sales_per_unit' => $sales_per_unit,
                        'cost_per_unit'  => $cost_per_unit,
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
                    'summary' => $input['summary'],
                    'type' => 1,
                    'fk_branch_id'=>$branchId,
                    'fk_company_id'=>$companyId,
                ];
                $invId = InventoryItem::create($addToInventoryItems)->id; 

                InventoryProductAddItem::create([
                    'fk_product_add_id'=> $order_id,
                    'fk_inventory_id'=> $invId,
                    'fk_product_id'=>$input['fk_product_id'][$i],
                    'qty'=>$input['qty'][$i],
                    'cost_per_unit'=>$input['cost_per_unit'][$i],
                    'sales_per_unit'=>$input['sales_per_unit'][$i],
                    'payable_amount'=>$input['amount'][$i],
                    'fk_model_id'=>$model,
                    'fk_branch_id'=>$branchId,
                    ]);
            }
        try {
            
            
            
            $bug = 0;
            DB::commit();
            
            
        } catch (\Exception $e) {
            DB::rollback();
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect("inventory-product-add/$invoice")->with('success','Order Created Successfully.');
        }else{
            return redirect()->back()->with('error','Something Error Found!, Please try again.'.$bug1);
        }

    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($invoice)
    {
        $getInvoiceData=InventoryProductAdd::leftJoin('inventory_supplier','inventory_product_add.fk_supplier_id','inventory_supplier.id')->where('inventory_order_id',$invoice)
        ->leftJoin('users','inventory_product_add.created_by','users.id')
        ->select('inventory_product_add.*','inventory_supplier.company_name','users.name as user_name')->orderBy('inventory_product_add.id','desc')->first();
        if($getInvoiceData==null){
            return redirect()->back();
        }
        $getProductData = InventoryProductAddItem::
        leftJoin('inventory_product','inventory_product_add_item.fk_product_id','=','inventory_product.id')
        ->leftJoin('inventory_branch','inventory_product_add_item.fk_branch_id','inventory_branch.id')
        ->leftJoin('inventory_product_model','inventory_product_add_item.fk_model_id','=','inventory_product_model.id')
        ->leftJoin('inventory_item','inventory_product_add_item.fk_inventory_id','=','inventory_item.id')
        ->leftJoin('inventory_small_unit','inventory_product.fk_small_unit_id','=','inventory_small_unit.id')
        ->where('inventory_product_add_item.fk_product_add_id',$getInvoiceData->id)
        ->select('inventory_product_add_item.*','inventory_product.product_name','inventory_small_unit.small_unit_name','model_name','branch_name as position_name')
        ->get();
        
        return view('pos.addItem.invoice', compact('getInvoiceData','getProductData'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
         $getOrder=InventoryProductAdd::leftJoin('inventory_supplier','inventory_product_add.fk_supplier_id','inventory_supplier.id')->where('inventory_product_add.id',$id)
        ->select('inventory_product_add.*','inventory_supplier.company_name')->orderBy('inventory_product_add.id','desc')->first();

        if($getOrder==null){
            return redirect()->back();
        }
        $getOrderItem = InventoryProductAddItem::leftJoin('inventory_branch','inventory_product_add_item.fk_branch_id','inventory_branch.id')->
        leftJoin('inventory_product','inventory_product_add_item.fk_product_id','=','inventory_product.id')
        ->leftJoin('inventory_item','inventory_product_add_item.fk_inventory_id','=','inventory_item.id')
        ->leftJoin('inventory_product_model','inventory_product_add_item.fk_model_id','=','inventory_product_model.id')
        ->leftJoin('inventory_small_unit','inventory_product.fk_small_unit_id','=','inventory_small_unit.id')
        ->where('inventory_product_add_item.fk_product_add_id',$getOrder->id)
        ->select('inventory_product_add_item.*','inventory_product.product_name','inventory_small_unit.small_unit_name','model_name','branch_name')
        ->get();
        
        return view('pos.addItem.edit', compact('getOrder','getOrderItem'));
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
        $input['date']=date('Y-m-d',strtotime($input['date']));
        $orderData = InventoryProductAdd::findOrFail($id);
            $orderData->update([
                'summery'=>$input['summery'],
                'date'=>$input['date'],
                'total_amount'=>$input['total_amount'],
                'total_paid'=>$input['total_paid'],
                ]);
         

        for ($i=0; $i < sizeof($input['item_id']); $i++) { 
                $item_id = $input['item_id'][$i];
                $invId = $input['fk_inventory_item_id'][$i];
                $orderItem = InventoryProductAddItem::where('id',$item_id)->update([
                    'qty'=>$input['qty'][$i],
                    'cost_per_unit'=>$input['cost_per_unit'][$i],
                    'sales_per_unit'=>$input['sales_per_unit'][$i],
                    'payable_amount'=>$input['amount'][$i],
                    ]);
                $inventoryItem=InventoryItem::where('id',$invId)->first();
                $inventory=Inventory::where('id',$inventoryItem->fk_inventory_id)->first();
                $inventory->update([
                    'available_qty'=>$inventory->available_qty-$inventoryItem->qty+$input['qty'][$i],
                    'cost_per_unit'  => $input['cost_per_unit'][$i],
                    'sales_per_unit' => $input['sales_per_unit'][$i],
                    ]);
                $inventoryItem->update([
                    'qty'=>$input['qty'][$i],
                    'available_qty'=>$input['qty'][$i]-($inventoryItem->qty-$inventoryItem->available_qty),
                    'cost_per_unit'  => $input['cost_per_unit'][$i],
                    'sales_per_unit' => $input['sales_per_unit'][$i],
                    ]);
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
            return redirect("inventory-product-add/$orderData->inventory_order_id")->with('success','Updated successFully.');
        }else{
            return redirect()->back()->with('error','Something Error Found !, Please try again.'.$bug1);
        }
    }

    public function duePaid($id)
    {
        
         $getOrder=InventoryProductAdd::leftJoin('inventory_supplier','inventory_product_add.fk_supplier_id','inventory_supplier.id')->where('inventory_product_add.id',$id)
        ->select('inventory_product_add.*','inventory_supplier.company_name')->orderBy('inventory_product_add.id','desc')->first();

        if($getOrder==null){
            return redirect()->back();
        }
        $getOrderItem = InventoryProductAddItem::
        leftJoin('inventory_product','inventory_product_add_item.fk_product_id','=','inventory_product.id')
        ->leftJoin('inventory_item','inventory_product_add_item.fk_inventory_id','=','inventory_item.id')
        ->leftJoin('inventory_product_model','inventory_product_add_item.fk_model_id','=','inventory_product_model.id')
        ->leftJoin('inventory_small_unit','inventory_product.fk_small_unit_id','=','inventory_small_unit.id')
        ->where('inventory_product_add_item.fk_product_add_id',$getOrder->id)
        ->select('inventory_product_add_item.*','inventory_product.product_name','inventory_small_unit.small_unit_name','model_name')
        ->get();
        
        return view('pos.addItem.due', compact('getOrder','getOrderItem','stockPosition'));
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
        $orderData = InventoryProductAdd::findOrFail($input['id']);
        $lastId=InventoryOrderPayment::max('id')+1;
        $invoice = $lastId;
         $input['date']=date('Y-m-d',strtotime($input['date']));
             $orderData->update([
                'total_paid'=>$orderData->total_paid+$input['paid'],
                ]);
            if($input['last_due']>0 and $input['paid']>0){
              $paymentId = InventoryOrderPayment::create([
                    'invoice_id'=>$invoice,
                    'last_due'=>$input['last_due'],
                    'fk_supplier_id'=>$orderData->fk_supplier_id,
                    'paid'=>$input['paid'],
                    'type'=>0,
                    'payment_date'=>$input['date'],
                    'created_by'=>\Auth::user()->id
                ])->id; 
               InventoryOrderPaymentItem::create([
                'fk_order_id'=>$input['id'],
                'fk_order_payment_id'=>$paymentId,
                'type'=>0,
                'order_last_due'=>$input['last_due'],
                'order_paid'=>$input['paid'],
                ]);
            }else{
                return redirect()->back();
            }
        try {

              
            $bug = 0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect("inventory-product-add/$invoice")->with('success','Due Paid successFully.');
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
        DB::beginTransaction();
        try {
            $productData = InventoryProductAdd::findOrFail($id);
            $items=InventoryProductAddItem::where('fk_product_add_id',$id)->get();
            foreach($items as $item){
                $inventoryItem=InventoryItem::where('id',$item->fk_inventory_id)->first();
                $inventory=Inventory::where('id',$inventoryItem->fk_inventory_id)->first();
                $inventory->update([
                    'available_qty'=>$inventory->available_qty-$inventoryItem->qty,
                    ]);
                InventoryProductAddItem::where('id',$item->id)->delete();
                $inventoryItem->delete();
                if($inventory->available_qty==0){
                    $another=InventoryItem::where('fk_inventory_id',$inventoryItem->fk_inventory_id)->get();
                    if(count($another)==0){   
                        $inventory->delete();
                    }
                }
            }
            $productData->delete();

            $bug = 0;
            DB::commit();
        } catch (\Exception $e) {
            DB::rollback();
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect()->back()->with('success', 'Deleted Successfully .');
        }elseif($bug == 1451){
                return redirect()->back()->with('error','This Data Used Any Where.(See at supplier payment.)');
            }else{
            return redirect()->back()->with('error','Something Error Found !, Please try again.'.$bug1);
        }
    }

    public function generate(){
        $allData=InventoryProductAdd::get();
        foreach ($allData as $key => $value) {
            InventoryOrderPayment::create([
                'fk_order_id'=>$value->id,
                'invoice_id'=>$value->inventory_order_id,
                'last_due'=>$value->total_amount,
                'paid'=>$value->total_paid,
                'payment_date'=>$value->date,
                'created_by'=>$value->created_by
                ]);
        }
        return "Successfully Complete";
    }


}
