<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\EmployeSalaryAllowance;

use Validator;

class EmployeSalaryAllowanceController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $allData = EmployeSalaryAllowance::orderBy('id','ASC')->get();
        return view('employe.sallaryAllowance.index', compact('allData'));
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
         $validator = Validator::make($request->all(),[
                'title' => 'required'

        ]);
        if($validator->fails()){
            return redirect()->back()->with('error','Title is required!');
        }

        $input = $request->all();
        $input['created_by']=\Auth::user()->id;
        
        try {
            EmployeSalaryAllowance::create($input); 
            $bug = 0;
            
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect()->back()->with('success','Created Successfully.');
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
         $data = EmployeSalaryAllowance::findOrFail($id);
         $validator = Validator::make($request->all(),[
                'title' => 'required'

        ]);
        if($validator->fails()){
            return redirect()->back()->with('error','Title is requird!');
        }


        $input = $request->all();
        $input['updated_by']=\Auth::user()->id;
           
        try {
            $data->update($input);
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
        $data = EmployeSalaryAllowance::findOrFail($id);
        
        try {
            
            $data->delete();
            $bug = 0;
        } catch (\Exception $e) {
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
}
