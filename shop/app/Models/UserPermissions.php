<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use DB;
class UserPermissions extends Model
{
    protected $table = "permission";
    protected $fillable = ['permission_name','permission_status'];

    /*permission insert in permission table*/
   //  public static function insertPermission($input){
   //  	$createdPermission = DB::table('permission')
   //  	->insertGetId([
   //          'permission_name' => $input['permission_name'],
			// 'permission_status' => $input['permission_status'],
   //  		'created_at' => date('Y-m-d h:i:s')
   //  		]);
    		
   //  }

   //  /*permission insert in category wise permission table*/
   //  public static function insertPermissionCategoryWise($input,$categoryName){
   //  	for ($i=0; $i <count($categoryName) ; $i++) { 
	  //   	$createdPermission = DB::table('permission')
	  //   	->insertGetId([
			// 	'permission_name' => $categoryName[$i],
	  //   		'created_at' => date('Y-m-d h:i:s')
	  //   		]);
   //  	}	
   //  }

   //  /*permission search in category wise permission table*/
   //  public static function checkPermissionCategoryWise($categoryName){
   //  	for ($i=0; $i <count($categoryName) ; $i++) { 
	  //   	$searchPermission[] = DB::table('permission')
	  //   	->select('id')
	  //   	->where('permission_name', '=', $categoryName[$i])
	  //   	->get();
   //  	}
   //  	return $searchPermission;	

   //  }
   //   /*permission update in category wise permission table*/
   //  public static function updatePermissionCategoryWise($input,$updateCategory,$categoryName,$permissionName){
   //      //print_r($categoryName);exit;
   //      for ($i=0; $i <count($categoryName) ; $i++) { 
   //          $searchPermission = DB::table('permission')
   //          ->where('permission_name', $categoryName[$i])
   //          ->update([
   //              'permission_name' => $updateCategory[$i],
   //              'updated_at' => date('Y-m-d h:i:s')
   //              ]);
   //      }   
   //          return $searchPermission;

   //  }
   //  /*permission delete in category wise permission table*/
   //  public static function deletePermissionCategoryWise($categoryName,$permissionName){
   //  	//print_r($categoryName);exit;
   //  	for ($i=0; $i <count($categoryName) ; $i++) { 
	  //   	$searchPermission = DB::table('permission')
	  //   	->where('permission_name', $categoryName[$i])
	  //   	->delete();
   //  	}	
	  //   	return $searchPermission;

   //  }
}
