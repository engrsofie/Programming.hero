<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use DB;
class InventoryProductSalesItem extends Model
{
    protected $table = 'inventory_product_sales_item';
    protected $fillable = ['fk_sales_id','fk_product_id','product_price_amount','product_wise_discount','sales_qty','product_paid_amount','small_qty','fk_model_id','inventory_item_id'];

    public static function createSalesItem($product_id,$sales_id,$price_amount,$qty,$price_discount,$price_paid,$smallQty,$model){
    	
        $create = DB::table('inventory_product_sales_item')
        ->insert([
            'fk_sales_id' => $sales_id,
            'fk_product_id' => $product_id,
            'product_price_amount' => $price_amount,
            'sales_qty' => $qty,
            'small_qty' => $smallQty,
            'fk_model_id' => $model,
            'product_wise_discount' => $price_discount,
            'product_paid_amount' => $price_paid,
            'created_at' => date('Y-m-d h:i:s')
            ])->id;

        return $create;
       
    }
}
