<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Inventory;
use App\Models\PosBarcode;
use Yajra\DataTables\DataTables;
use Auth;
use Validator;
class PosBarcodeController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('pos.barcode.index');
    }
    public function allBarcode(){
        $allData=PosBarcode::leftJoin('inventory_product','pos_product_barcode.fk_product_id','=','inventory_product.id')->leftJoin('inventory_product_model','pos_product_barcode.fk_model_id','=','inventory_product_model.id')->select('product_name','model_name','pos_product_barcode.*')->orderBy('pos_product_barcode.id','DESC');
        return Datatables::of($allData)
        ->addColumn('action','
            <a href="{{URL::to(\'barcode\',$id)}}" class="btn btn-xs btn-success"><i class="fa fa-eye"></i></a>
            <a href="{{route(\'barcode.edit\',$id)}}" class="btn btn-xs btn-info"><i class="fa fa-pencil"></i></a>
            {!! Form::open(array(\'route\'=> [\'barcode.destroy\',$id],\'method\'=>\'DELETE\')) !!}
            {{ Form::hidden(\'id\',$id)}}
            <button type="submit" onclick="return confirmDelete();" class="btn btn-xs btn-danger">
              <i class="fa fa-trash-o" aria-hidden="true"></i>
            </button>
            {!! Form::close() !!}
            ')
        
        ->rawColumns(['action'])
        ->make(true);
    }
    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('pos.barcode.create');
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
                'fk_product_id.*' => 'required',
                'fk_model_id.*' => 'required',
                'barcode' => 'required',

        ]);
        if($validator->fails()){
            return redirect()->back()->with('error','Empty Data found!');
        }

        $input = $request->except('_token');
        try {
             
        for ($i=0; $i <sizeof($input['fk_product_id']); $i++) { 
            PosBarcode::create([
                'fk_product_id' => $input['fk_product_id'][$i],
                'fk_model_id' => $input['fk_model_id'][$i],
                'barcode' => $input['barcode'][$i],
            ]);
        }
            
            $bug = 0;
            
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect()->back()->with('success','Created Successfully.');
        }elseif($bug==1062){
            return redirect()->back()->with('error','This barcode has already been taken.');
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
        $data=PosBarcode::leftJoin('inventory_product','pos_product_barcode.fk_product_id','=','inventory_product.id')->leftJoin('inventory_product_model','pos_product_barcode.fk_model_id','=','inventory_product_model.id')->select('product_name','model_name','pos_product_barcode.*')->where('pos_product_barcode.id',$id)->first();
        $price  = Inventory::where(['fk_product_id'=>$data->fk_product_id,'fk_model_id'=>$data->fk_model_id])->value('sales_per_unit');
        if(isset($request->qty)){
            $qty=$request->qty;
        }
        return view('pos.barcode.show',compact('data','qty','price'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $data=PosBarcode::leftJoin('inventory_product','pos_product_barcode.fk_product_id','=','inventory_product.id')->leftJoin('inventory_product_model','pos_product_barcode.fk_model_id','=','inventory_product_model.id')->select('product_name','model_name','pos_product_barcode.*')->where('pos_product_barcode.id',$id)->first();
        return view('pos.barcode.edit',compact('data'));
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
        $validator = Validator::make($request->all(),[
                'fk_product_id' => 'required',
                'fk_model_id' => 'required',
                'barcode' => "required|unique:pos_product_barcode,barcode,$id",

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }

        $input = $request->except('_token');
        try {
             
            PosBarcode::where('id',$id)->update([
                'fk_product_id' => $input['fk_product_id'],
                'fk_model_id' => $input['fk_model_id'],
                'barcode' => $input['barcode'],
            ]);
            
            $bug = 0;
            
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect("barcode/$id")->with('success','Created Successfully.');
        }elseif($bug==1062){
            return redirect()->back()->with('error','This barcode has already been taken.');
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
        $data=PosBarcode::findOrFail($id);
           try{
                $data->delete();
                $bug=0;
                $error=0;
            }catch(\Exception $e){
                $bug=$e->errorInfo[1];
                $error=$e->errorInfo[2];
            }
            if($bug==0){
           return redirect()->back()->with('success','Data has been Successfully Deleted!');
            }elseif($bug==1451){
           return redirect()->back()->with('error','This Data is Used anywhere ! ');

            }
            elseif($bug>0){
           return redirect()->back()->with('error','Some thing error found !');

            }
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
           
            ->where('inventory.available_qty','>',0)
            ->where('inventory_product.product_name', 'LIKE', $name .'%')
            ->orWhere('model_name', 'LIKE', $name .'%')
            
            ->select('inventory_product.product_name','inventory_product.id','inventory_small_unit.small_unit_name','inventory.available_qty','inventory.available_small_qty','inventory.sales_per_unit','inventory.id as inventory_id','model_name','fk_model_id','cost_per_unit')
            ->orderBy('inventory.id','asc')->limit(10)
            ->get();
        $getResult = $result->toArray();
        foreach ($getResult as $row) {
            $product_id=$row['id'];
            $model=$row['fk_model_id'];
            $oldBarcode=PosBarcode::where(['fk_product_id'=>$product_id,'fk_model_id'=>$model])->first();
            if($oldBarcode==null){
                $salePrice=round($row['sales_per_unit'],2);
                $product_result =$row['product_name'].' ('.$row['model_name'].')|'.$row['id'].'|'.$row['fk_model_id'];
                array_push($data, $product_result);
            }
        }
          
        return json_encode($data);exit;   
    }
}
