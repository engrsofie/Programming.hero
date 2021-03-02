<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;

use App\Models\AccountSetting;

use Validator;
use Auth;

class AccountSettingController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $query = AccountSetting::leftJoin('inventory_branch','account.fk_branch_id','=','inventory_branch.id')->orderBy('account.id','desc')->select('account.*','branch_name');
        if(Auth::user()->isRole('administrator')){
            $getAccountData=$query->get();
        }else{
            $getAccountData=$query->where(['account.fk_branch_id'=>Auth::user()->fk_branch_id,'account.fk_company_id'=>Auth::user()->fk_company_id])->get();

        }
        return view('account.viewAccount', compact('getAccountData'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('account.index');
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
                'account_name' => 'required'
        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }

        $input = $request->all();
        $input['fk_branch_id']=Auth::user()->fk_branch_id;
        $input['fk_company_id']=Auth::user()->fk_company_id;
        try {
            AccountSetting::create($input); 
            
            $bug = 0;
            
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect('account/create')->with('success','Created New Account Item Created Successfully.');
        }else{
            return redirect('account/create')->with('error','Something Error Found !, Please try again.'.$bug1);
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
        $getAccount = AccountSetting::findOrFail($id);
        /*validator required file about us page*/
        $validator = Validator::make($request->all(),[
            'account_name' => 'required'
        ]);

        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }

        $input = $request->all();
        
        try {
            $getAccount->update($input);/*update data*/
            $bug = 0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
       
        if($bug == 0){
            return redirect('account')->with('success','Account Item Updated Successfully.');
        }else{
            return redirect('account')->with('error','Something Error Found !, Please try again.'.$bug1);
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
        $getAccount = AccountSetting::findOrFail($id);
        
        
        try {
            $getAccount->delete();
            $bug = 0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
       
        if($bug == 0){
            return redirect('account')->with('success','Delete Account Item Successfully ');
        }else{
            return redirect('account')->with('error','Something Error Found !, Please try again.'.$bug1);
        }
    }
}
