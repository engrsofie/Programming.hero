<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\InventoryStockPosition;
use App\Models\InventoryBranch;
use Validator;
use Auth;

class InventoryStockPositionController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $branchId=Auth::user()->fk_branch_id;
        $companyId=Auth::user()->fk_company_id;
        $branch=InventoryBranch::where('status',1)->pluck('branch_name','id');
        $query=InventoryStockPosition::leftJoin('inventory_branch','inventory_stock_position.fk_branch_id','inventory_branch.id')->orderBy('inventory_stock_position.id','desc')->select('inventory_stock_position.*','branch_name');
        if(Auth::user()->isRole('administrator')){
            $allData=$query->paginate(20);
        }else{
            $allData=$query->where(['fk_branch_id'=>$branchId,'fk_company_id'=>$companyId])->paginate(20);
        }

        return view('pos.stockPosition.index',compact('allData','branch'));
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
        
        $validator = Validator::make($request->all(), [
                    'position_name' => 'required',
                   
                ]);
                if ($validator->fails()) {
                    return redirect()->back()
                        ->withErrors($validator)
                        ->withInput();
                }
        $input = $request->all();
        
        $input['fk_company_id']=Auth::user()->fk_company_id;
        InventoryStockPosition::create($input);
        try{
        $bug=0;
        }catch(\Exception $e){
            $bug=$e->errorInfo[1];
        }
         if($bug==0){
        return redirect()->back()->with('success','Data Successfully Inserted');
        }elseif($bug==1062){
            return redirect()->back()->with('error','The name has already been taken.');
        }else{
            return redirect()->back()->with('error','Something Error Found ! ');
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
         $validator = Validator::make($request->all(), [
                'position_name' => "required",
                ]);
                if ($validator->fails()) {
                    return redirect()->back()->with('error','Duplicate or empty record found.');
                }
        $input=$request->all();
        $data=InventoryStockPosition::findOrFail($id);
        
        try{
            $data->update($input);
            $bug=0;
        }catch(\Exception $e){
            $bug = $e->errorInfo[1]; 
        }
        if($bug==0){
        return redirect()->back()->with('success','Data Successfully Updated');
        }elseif($bug==1062){
            return redirect()->back()->with('error','The name has already been taken.');
        }else{
            return redirect()->back()->with('error','Something Error Found ! ');
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
        $data=InventoryStockPosition::findOrFail($id);
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
}
