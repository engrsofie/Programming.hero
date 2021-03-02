<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use DB;
class Categories extends Model
{
    protected $table = 'category';
    protected $fillable = ['company_name','category_name','category_type','category_status','created_by','updated_by'];

    /**/
    public static function createCategory($input){
        $categoryCreate = DB::table('category')
        ->insertGetId([
            'company_name' => $input['company_name'],
            'category_name' => $input['category_name'],
            'category_type' => $input['category_type'],
            'category_status' => $input['category_status'],
            'created_by' => $input['created_by'],
            'created_at' => date('Y-m-d h:i:s')
            ]);

        return $categoryCreate;
       
    }
    /*update category table*/
    public static function updateCategory($input,$data){
    	//print_r($data->id);exit;
    	$updated = DB::table('category')
	    	->where('id', $data->id)
	    	->update([
                'company_name' => $input['company_name'],
                'category_name' => $input['category_name'],
                'category_type' => $input['category_type'],
                'category_status' => $input['category_status'],
                'updated_by' => $input['updated_by'],
	    		'updated_at' => date('Y-m-d h:i:s')
	    		]);
    }

    /*delete category in category table*/
    public static function deleteCategory($data){
    	//print_r($data->id);exit;
    	$deleteCategory = DB::table('category')
    	->where('id', $data->id)
    	->delete();
    }
}
