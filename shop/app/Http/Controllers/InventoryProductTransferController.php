<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\InventoryProductTransfer;
use App\Models\InventoryProductTransferItem;
use App\Models\Inventory;
use App\Models\InventoryItem;
use App\Models\InventoryBranch;
use Yajra\DataTables\DataTables;
use Auth;
use Validator;
use DB;

class InventoryProductTransferController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('pos.transfer.index');
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $branch=InventoryBranch::where('status',1)->pluck('branch_name','id');
        $ownBranch=InventoryBranch::where('id',Auth::user()->fk_branch_id)->first();
        return view('pos.transfer.create',compact('branch','ownBranch'));
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
        $input=$request->except('_token');
         $validator = Validator::make($request->all(),[
                'transfer_from' => 'required',
                'transfer_to' => 'required',
                'total_amount' => 'required',

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }
        if($request->transfer_from==$request->transfer_to){
            return redirect()->back()->with('error','Same branch Selected!');
        }
        $branchId=$request->transfer_from;
        $branch2=$request->transfer_to;
        $input['date'] = date("Y-m-d", strtotime($input['date']));
        $input['created_by']=Auth::user()->id;
        DB::beginTransaction();
        $transferId = InventoryProductTransfer::create($input)->id;

        for ($i=0; $i < sizeof($input['fk_product_id']); $i++) { 
                $productId = $input['fk_product_id'][$i];
                $model = $input['fk_model_id'][$i];
                $qty = $input['qty'][$i];
                $cost_per_unit=$input['cost_per_unit'][$i];
                $sales_per_unit=0;
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

                /*Now Add to inventory from branch two*/
                $searchInventory = Inventory::
                leftJoin('inventory_item','inventory.id','inventory_item.fk_inventory_id')
                ->where(['fk_product_id'=>$productId,'fk_model_id'=>$model,'inventory.fk_branch_id'=>$branch2,'inventory.fk_company_id'=>$companyId])->select('inventory_item.brach_no','inventory.id','inventory.available_qty','inventory.sales_per_unit')->orderBy('inventory_item.id','desc')->first();
                if($searchInventory!=null){
                    $old_brach_no = $searchInventory->brach_no;
                    if($old_brach_no!=null){
                        $last_no =  explode('-', $old_brach_no);
                        $new_no = $last_no[2]+1;
                    }else{
                         $new_no=1;
                    }
                    $brach_no = "B-".$productId."-".$new_no.'-'.$branch2.'-'.$companyId.'-'.$model;
                    $getInventory = Inventory::where(['fk_product_id'=>$productId,'fk_model_id'=>$model,'inventory.fk_branch_id'=>$branch2,'inventory.fk_company_id'=>$companyId])->first();
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
                    $brach_no = "B-".$productId."-1".'-'.$branch2.'-'.$companyId.'-'.$model;
                    $addToInventoryItem = [
                        'fk_product_id'  => $productId,
                        'available_qty'  => $qty,
                        'fk_model_id' => $model,
                        'sales_per_unit' => $sales_per_unit,
                        'cost_per_unit'  => $cost_per_unit,
                        'fk_branch_id'=>$branch2,
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
                    'summary' => '',
                    'type' => 1,
                    'fk_branch_id'=>$branch2,
                    'fk_company_id'=>$companyId,
                ];
                $invId = InventoryItem::create($addToInventoryItems)->id; 

                $transferItem=InventoryProductTransferItem::create([
                    'fk_transfer_id'=>$transferId,
                    'qty'=>$qty,
                    'cost_amount'=>$price,
                    'cost_per_unit'=>$cost_per_unit,
                    'fk_product_id'=>$productId,
                    'inventory_item_id'=>$inventoryId,
                    'fk_model_id'=>$model,
                    'fk_inventory_item_id'=>$invId,
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
            return redirect()->back()->with('success','Transferd Product Successfully.');
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
    public function show($ids)
    {
        $companyId=Auth::user()->fk_company_id;
        $branchId=Auth::user()->fk_branch_id;
        $query=InventoryProductTransfer::leftJoin('inventory_branch','inventory_product_transfer.transfer_from','inventory_branch.id')
        ->leftJoin('inventory_branch as inventory_branch2','inventory_product_transfer.transfer_to','inventory_branch2.id')
        ->select('inventory_product_transfer.*','inventory_branch.branch_name as branch_one','inventory_branch2.branch_name as branch_two');
        if(Auth::user()->isRole('administrator')){
            $allData=$query->get();
        }else{
         $allData=$query->where(['inventory_product_transfer.transfer_from'=>$branchId]);
        }
         return Datatables::of($allData)
            ->editColumn('id','<a href=\'{{URL::to("inventory-transfer/$id")}}\'>#{{$id}} </a>')
            ->addColumn('action','
                <a href=\'{{URL::to("inventory-transfer/$id/edit")}}\' class="btn btn-info btn-xs"><i class="fa fa-pencil-square"></i></a>
                {!! Form::open(array(\'route\'=> [\'inventory-transfer.destroy\',$id],\'method\'=>\'DELETE\')) !!}
                    {{ Form::hidden(\'id\',$id)}}
                    <button type="submit" onclick="return confirmDelete();" class="btn btn-xs btn-danger">
                      <i class="fa fa-trash-o" aria-hidden="true"></i>
                    </button>
                {!! Form::close() !!}
                ')
                ->rawColumns(['id','action'])
                ->make(true);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $data=InventoryProductTransfer::leftJoin('inventory_branch','inventory_product_transfer.transfer_from','inventory_branch.id')
        ->leftJoin('inventory_branch as inventory_branch2','inventory_product_transfer.transfer_to','inventory_branch2.id')
        ->where('inventory_product_transfer.id',$id)
        ->select('inventory_product_transfer.*','inventory_branch.branch_name as branch_one','inventory_branch2.branch_name as branch_two')->first();
        $items=InventoryProductTransferItem::leftJoin('inventory_product','inventory_product_transfer_item.fk_product_id','=','inventory_product.id')
            ->leftJoin('inventory_product_model','inventory_product_transfer_item.fk_model_id','=','inventory_product_model.id')
            ->where('fk_transfer_id',$id)
            ->select('inventory_product_transfer_item.*','product_name','model_name')->get();
        return view('pos.transfer.edit',compact('data','items'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {   $companyId=Auth::user()->fk_company_id;
        $input=$request->except('_token','_method');
        $validator = Validator::make($request->all(),[
            'total_amount' => 'required',
        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }
        $input['date'] = date("Y-m-d", strtotime($input['date']));
        DB::beginTransaction();
        $transfer=InventoryProductTransfer::where('id',$id)->first();
        $transfer->update([
            'total_amount'=>$input['total_amount'],
            'date'=>$input['date'],
            'details'=>$input['details'],
        ]);
        $branchId=$transfer->transfer_from;
         for ($i=0; $i < sizeof($input['item_id']); $i++) { 
                $itemId=$input['item_id'][$i];
                $item=InventoryProductTransferItem::where('id',$itemId)->first();
               
                $productId = $item->fk_product_id;
                $model = $item->fk_model_id;
                $qty = $input['qty'][$i];
                $cost_per_unit=$input['cost_per_unit'][$i];
                $sales_per_unit=0;
                /*Update old Inventory*/
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
                
                    /*---Update available Quantity---*/
                        
                    $getInventory = Inventory::leftJoin('inventory_product','inventory.fk_product_id','inventory_product.id')
                    ->where(['inventory.fk_product_id'=>$productId,'inventory.fk_model_id'=>$model,'inventory.fk_branch_id'=>$branchId,'inventory.fk_company_id'=>$companyId])
                    ->select('inventory.id','available_qty','available_small_qty')
                    ->first();
                    $inventoryUpdateQty = array(
                        'available_qty' => $getInventory->available_qty-$qty,
                        'available_small_qty' => 0,
                        'updated_at' => date('Y-m-d h:i:s')
                        );
                    $getInventory->update($inventoryUpdateQty);

                    /*Now Update New Inventory*/
                    $invId = $item->fk_inventory_item_id;
                    $inventoryItem=InventoryItem::where('id',$invId)->first();
                    $inventory=Inventory::where('id',$inventoryItem->fk_inventory_id)->first();
                    $inventory->update([
                        'available_qty'=>$inventory->available_qty-$inventoryItem->qty+$input['qty'][$i],
                        'cost_per_unit'  => $input['cost_per_unit'][$i],
                        'sales_per_unit' => $sales_per_unit,
                        ]);
                    $inventoryItem->update([
                        'qty'=>$input['qty'][$i],
                        'available_qty'=>$input['qty'][$i]-($inventoryItem->qty-$inventoryItem->available_qty),
                        'cost_per_unit'  => $input['cost_per_unit'][$i],
                        'sales_per_unit' => $sales_per_unit,
                        ]);
                    $item->update([
                        'qty'=>$qty,
                        'cost_amount'=>$price,
                        'cost_per_unit'=>$cost_per_unit,
                        'inventory_item_id'=>$inventoryId,
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
            return redirect()->back()->with('success','Transferd Product Updated.');
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
        return $id;
        $productData = InventoryProductAdd::findOrFail($id);
            $items=InventoryProductAddItem::where('fk_product_add_id',$id)->get();
        try {
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
            InventoryOrderPayment::where('fk_order_id',$id)->delete();
            $productData->delete();
            $bug = 0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect()->back()->with('success', 'Deleted Successfully .');
        }elseif($bug == 1451){
                return redirect()->back()->with('error','This Data Used Any Where.');
            }else{
            return redirect()->back()->with('error','Something Error Found !, Please try again.'.$bug1);
        }
    }

    public function inventoryProductSearch(Request $request){
        $branchId=$request->branch;
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
            ->where('inventory_product.product_name', 'LIKE',$name .'%')
            ->orWhere('model_name', 'LIKE', $name .'%')
            ->where(['inventory.fk_branch_id'=>$branchId,'inventory.fk_company_id'=>$companyId])
            ->select('inventory_product.product_name','inventory_product.id','inventory_small_unit.small_unit_name','inventory.available_qty','inventory.available_small_qty','inventory.sales_per_unit','inventory.id as inventory_id','model_name','fk_model_id','cost_per_unit')
            ->orderBy('inventory.id','asc')->limit(10)
            ->get();
            $getResult = $result->toArray();
            foreach ($getResult as $row) {
                    $product_result =$row['product_name'].' ('.$row['model_name'].')|'.$row['id'].'|'.$row['fk_model_id'].'|'.$row['available_qty'].'|'.round($row['cost_per_unit'],3);
                    array_push($data, $product_result);
                  
            }
            return json_encode($data);exit;   

    }
}