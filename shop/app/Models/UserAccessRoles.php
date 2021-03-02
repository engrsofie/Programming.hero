<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use DB;
class UserAccessRoles extends Model
{
    protected $table = "user_access_role";
    protected $fillable = ['fk_user_id','fk_role_id'];

    public static function insertUserAccessRole($input,$fk_user_id){
    	for ($i=0; $i <count($input['fk_role_id']) ; $i++) { 
    		$userAccessRole = DB::table('user_access_role')
	        ->insertGetId([
	            'fk_user_id'      => $fk_user_id,
	            'fk_role_id'      => $input['fk_role_id'][$i],
	            'created_at'   => date('Y-m-d h:i:s')
	            ]);
	        
    	}
        
        
        
    }
}
