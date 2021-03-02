<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;

use App\Models\Address;
use App\Models\Users;
use Validator;
use Auth;
use DB;
use Hash;

class MyProfileController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {

        $getMyProfile = Users:: where('users.id',Auth::user()->id)
        ->first();
        
        return view('my_profile.profile',compact('getMyProfile'));
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    
    public function viewPassword()
    {
        return view('my_profile.changeMyPassword');
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
        //
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
        $getMyProfile = Users::where('users.id',Auth::user()->id)
        ->first();

        return view('my_profile.profileUpdate',compact('getMyProfile'));
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
        $data = Users::findOrFail($id);
        $validator = Validator::make($request->all(), [
                'name'     => 'required',
                'email'         => 'email|required',
                'phone_number'  => 'required',
                'gender'        => 'required'
            ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }   
        $input = $request->all();

        if ($request->hasFile('profile_image')) {
            $photo=$request->file('profile_image');
            $fileType=substr($_FILES['profile_image']['type'], 6);
            $fileName=rand(1,1000).date('dmyhis').".".$fileType;
            $upload=$photo->move('images/users', $fileName );
            $input['profile_image']=$fileName;
            $img_path='images/users/'.$data['profile_image'];

            if($data['profile_image']!=null and file_exists($img_path)){
                unlink($img_path);
            }
        }

        try{
            $createUserInfo = Users::updateUserInfo($input,$data);
            //$updateUserAddress = Address::updateUserAddress($input);
            $result=0;
        }catch(\Exception $e){
            $result = $e->errorInfo[1];
            $result1 = $e->errorInfo[2];
        }

        if($result==0){
        return redirect("my-profile/")->with('success','Profile Successfully Updated');
        }elseif($result==1062){
            return redirect("my-profile/$id/edit")->with('error','The User has already been taken.');
        }else{
        return redirect("my-profile/$id/edit")->with('error','Something Error Found ! '.$result1);
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
        //
    }
    /**
     * Remove the specified resource from change my password.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    
    public function changeMyPassword(Request $request){

        $input = $request->all();
        //print_r($input);exit;
        $newPassword = $input['password'];
        $data = Users::findOrFail($request->id);

        if(!empty($input['old_password'])){
            $oldPassword = $input['old_password'];
            if(Hash::check($oldPassword,$data['password'])){
                $validator = Validator::make($request->all(), [
                    'password' => 'required|min:6|confirmed',
                    ]);
                if ($validator->fails()) {
                    return redirect()->back()
                        ->withErrors($validator)
                        ->withInput();
                }
                $input['password']=bcrypt($newPassword);
            }else{
                return redirect()->back()->with('error', 'Old Password not match !');
            }
        }
        //print_r($input);exit;
        
        try{
            $data->update($input);
            $bug=0;
        }catch(\Exception $e){
            $bug=$e->errorInfo[1];
            $bug1=$e->errorInfo[2];
        }
        if($bug==0){
            return redirect('my-profile')->with('success','Password Changed Successfully !');
        }else{
            return redirect('my-profile')->with('error','Something is wrong !'.$bug1);

        }

    }
}
