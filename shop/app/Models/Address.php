<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use DB;
class Address extends Model
{
    protected $table = "address";
    protected $fillabel = ['address','country_name','city_name','zip_code','division'];

    public static function insertUserAddress($input){
        $addressResult = DB::table('address')
        ->insertGetId([
            'address'      => $input['address'],
            'country_name'  => $input['country_name'],
            'city_name'     => $input['city_name'],
            'zip_code'      => $input['zip_code'],
            'division'     => $input['division'],
            'created_at'   => date('Y-m-d h:i:s')
            ]);
        return $addressResult;
        
        
    }
    public static function updateUserAddress($input,$addressId){
        $addressUpdate = DB::table('address')
        ->where('id', $addressId)  // find your user by their id
        ->update([
            'address' => $input['address'],
            'country_name' => $input['country_name'],
            'city_name' => $input['city_name'],
            'zip_code' => $input['zip_code'],
            'division' => $input['division']
            ]);
        
    }
}
