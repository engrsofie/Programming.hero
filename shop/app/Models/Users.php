<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use DB;
class Users extends Model
{
    protected $table = "users";
    protected $fillable = ['name','email','password','profile_image','phone_number','gender','address','status','type','created_by','updated_by'];

    public static function insertUserInfo($input){
        $userInfoResult = DB::table('users')
        ->insertGetId([
            'name'          => $input['name'],
            'email'         => $input['email'],
            'password'      => $input['password'],
            'profile_image' => $input['profile_image'],
            'phone_number'  => $input['phone_number'],
            'gender'        => $input['gender'],
            'address' => $input['address'],
            'status'        => 1,
            'type' => $input['type'],
            'created_at'    => date('Y-m-d h:i:s'),
            'created_by'    => $input['created_by']
            ]);
        return $userInfoResult;
        
        
    }
    public static function updateUserInfo($input,$data){
        //print_r($input);exit;
        $data->update($input);
        
    }

}
