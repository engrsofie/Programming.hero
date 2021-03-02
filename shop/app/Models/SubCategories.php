<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SubCategories extends Model
{
    protected $table = 'sub_category';
    protected $fillable = ['sub_category_name','sub_category_type','sub_category_status','company_name','created_by','updated_by'];
    /**/
    // public static function createCategory($input){
    //     $create = DB::table('sub_category')
    //     ->insertGetId([
    //         'fk_category_id' => $input['fk_category_id'],
    //         'company_name' => $input['company_name'],
    //         'sub_category_name' => $input['sub_category_name'],
    //         'sub_category_type' => $input['sub_category_type'],
    //         'sub_category_status' => $input['sub_category_status'],
    //         'created_by' => $input['created_by'],
    //         'created_at' => date('Y-m-d h:i:s')
    //         ]);

    //     return $create;
       
    // }
    /*update category table*/
    // public static function updateSubCategory($input,$data){
    // 	//print_r($data->id);exit;
    // 	$updated = DB::table('sub_category')
	   //  	->where('id', $data->id)
	   //  	->update([
    //             'fk_category_id' => $input['fk_category_id'],
	   //          'company_name' => $input['company_name'],
	   //          'sub_category_name' => $input['sub_category_name'],
	   //          'sub_category_type' => $input['sub_category_type'],
	   //          'sub_category_status' => $input['sub_category_status'],
    //             'updated_by' => $input['updated_by'],
	   //  		'updated_at' => date('Y-m-d h:i:s')
	   //  		]);
    // }

    // /*delete category in category table*/
    // public static function deleteSubCategory($data){
    // 	//print_r($data->id);exit;
    // 	$delete = DB::table('sub_category')
    // 	->where('id', $data->id)
    // 	->delete();
    // }
}
