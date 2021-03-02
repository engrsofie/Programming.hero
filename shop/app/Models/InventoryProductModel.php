<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InventoryProductModel extends Model
{
    protected $table = 'inventory_product_model';
    protected $fillable = ['fk_product_id','model_name','status'];

    static function createNew($name,$product){
    	$create='';
    	$data=InventoryProductModel::where('model_name',$name)->first();
    	if($data==null){
	    	$create=InventoryProductModel::create([
	    		'model_name'=>$name,
	    		'fk_product_id'=>$product,
	    		'status'=>1,
	    	])->id;
    		return $create;
        }else{
            return $data->id;
        }
    }
}
