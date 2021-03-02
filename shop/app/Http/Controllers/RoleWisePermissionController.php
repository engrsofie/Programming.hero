<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;

use App\Models\UserRoles;

use App\Models\UserPermissions;

use App\Models\RoleWisePermissions;

use Validator;

class RoleWisePermissionController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $getRoleData = UserRoles::where('role_status','=','1')->get();
        $getPermissionData = UserPermissions::where('permission_status','=','1')->get();
        return view('administration.role.roleWisePermission', compact('getRoleData','getPermissionData'));
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
                'fk_role_id' => 'required'
            ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }
     
        $input = $request->all();

        $id = $request->fk_role_id;
        $fk_permission_id = $request->fk_permission_id;
        $permission = $request->permission;
        // echo "<pre>";
        // print_r($input);exit;
               



        try {
            /*delete role wise permission in rolewisepermission table*/
            $deletePermission = RoleWisePermissions::deleteRolePermission($id,$permission);
            /*insert role wise permission in rolewisepermission table*/    
            for($i=0;$i<sizeof($fk_permission_id);$i++){

            $searchPermissionID = RoleWisePermissions::checkExistsPermission($id,$fk_permission_id);
            $searchId = RoleWisePermissions::checkExistsRole($id,$fk_permission_id[$i]);
            /*check role wise permission in rolewisepermission table*/
            if($searchId===true){

                }else{
                    RoleWisePermissions::createRoleWisePermission($id,$fk_permission_id[$i]);
                }
            }

            $bug = 0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }

        if($bug == 0){
            return redirect('role-wise-permission')->with('success', 'Created Successfully');
        }else{
            return redirect('role-wise-permission')->with('error', 'Something Error Found !, Please try again.'.$bug1);
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
        $getPermissionData = UserPermissions::all();
        $roleWisePermissions = RoleWisePermissions::where('fk_role_id',$id)->get();
        //return $getPermissionData;
        return view('administration.role.loadPermission', compact('getPermissionData','roleWisePermissions'));
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
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }


}