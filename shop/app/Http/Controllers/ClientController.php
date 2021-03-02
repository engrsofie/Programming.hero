<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;

use App\Models\Clients;

use Validator;
use Auth;

class ClientController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {   
        
        $query = Clients::leftJoin('inventory_branch','clients.fk_branch_id','=','inventory_branch.id')->orderBy('clients.id','desc')->select('clients.*','branch_name');
        if(Auth::user()->isRole('administrator')){
            $getClientData=$query->get();
        }else{
            $getClientData=$query->where(['clients.fk_branch_id'=>Auth::user()->fk_branch_id,'clients.fk_company_id'=>Auth::user()->fk_company_id])->get();

        }
        return view('clients.viewClients', compact('getClientData'));
        
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('clients.index');
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
                'client_name' => 'required'

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }

        $input = $request->all();
        $input['client_id'] = "client-".rand(1,1000);
        $input['fk_branch_id']=Auth::user()->fk_branch_id;
        $input['fk_company_id']=Auth::user()->fk_company_id;
        
        try {
            Clients::create($input); 
            $bug = 0;
            
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect('client/create')->with('success','New Client Created Successfully.');
        }else{
            return redirect('client/create')->with('error','Something Error Found !, Please try again.'.$bug1);
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
         $clientData = Clients::findOrFail($id);
         $validator = Validator::make($request->all(),[
                'client_name' => 'required'

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }


        $input = $request->all();
        try {
            $clientData->update($input);
            $bug = 0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect("client")->with('success','Client Info Updated successFully.');
        }else{
            return redirect("client")->with('error','Something Error Found !, Please try again.'.$bug1);
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
        $clientData = Clients::findOrFail($id);
        
        try {
            
            $clientData->delete();
            $bug = 0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect('client')->with('success', 'Client Info Deleted Successfully .');
        }elseif($bug == 1451){
                return redirect('client')->with('error','This Data Used AnyWhere.');
            }else{
            return redirect('client')->with('error','Something Error Found !, Please try again.'.$bug1);
        }


    }

}
