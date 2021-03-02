<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Yajra\Acl\Models\Permission;
use Validator;
use DB;

class AclPermissionController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {   
        $allData = Permission::orderBy('id','desc')->get();
        return view('settings.permission.index', compact('allData'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        
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
                'name' => 'required|unique:permissions,name'

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }

        $input = $request->all();
        $input['slug']=strtolower($input['name']);
        $input['resource']=ucfirst($input['name']);
        $input['system']=1;
        
        try {

            //Permission::createResource($input['name'],1);
            Permission::create($input); 
            
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
        $roles=\DB::table('roles')->pluck('name','id');
        
        return view('settings.permission.roles',compact('roles'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $allData=\DB::table('permissions')->get();
        $permissionRole=\DB::table('permission_role')->where('role_id',$id)->get();
        $role=\DB::table('roles')->where('id',$id)->first();

        return view('settings.permission.role',compact('permissionRole','allData','role'));
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
        $getuom = Permission::findOrFail($id);
        $validator = Validator::make($request->all(),[
                'name' => "required|unique:permissions,name,$id"

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }

        $input = $request->all();
        
        try {
            $getuom->update($input);
            
            $bug = 0;
            
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect()->back()->with('success','Updated Successfully.');
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
        $getuom = Permission::findOrFail($id);
        
        try {
            $getuom->delete();
            
            $bug = 0;
            
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect()->back()->with('success','Deleted Successfully.');
        }else{
            return redirect()->back()->with('error','Something Error Found !, Please try again.'.$bug1);
        }
    }


    public function storeRole(Request $request)
    {
        $input=$request->except('_token');
        $validator = Validator::make($request->all(),[
                'role_id' => 'required',
                'permission_id' => 'required',

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }

        
        try {
            DB::beginTransaction();
            DB::table('permission_role')->where('role_id',$input['role_id'])->delete();
        for ($i=0; $i <sizeof($input['permission_id']) ; $i++) { 
            $permissionId=$input['permission_id'][$i];
            \DB::table('permission_role')->insert([
                'role_id'=>$input['role_id'],
                'permission_id'=>$permissionId
            ]);
        }
            DB::commit();
            $bug = 0;
            
        } catch (\Exception $e) {
            DB::rollback();
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect('clear-cache')->with('success','Created Successfully.');
        }else{
            return redirect()->back()->with('error','Something Error Found !, Please try again.'.$bug1);
        }
    }
}
