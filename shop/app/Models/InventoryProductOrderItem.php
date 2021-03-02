<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use DB;
class InventoryProductOrderItem extends Model
{
    protected $table = 'inventory_product_order_item';
    protected $fillable = ['fk_product_order_id','fk_product_id','qty','cost_per_unit','sales_per_unit','payable_amount','foreign_amount','bdt_rates','currency_name','other_expense','free_of_cost'];

    public static function createOrder($order_id,$product_id,$cost_amount,$sales_amount,$qty,$paid_amount){
    	
        $create = DB::table('inventory_product_order_item')
        ->insert([
            'fk_product_order_id' => $order_id,
            'fk_product_id' => $product_id,
            'qty' => $qty,
            'cost_per_unit' => $cost_amount,
            'sales_per_unit' => $sales_amount,
            'payable_amount' => $paid_amount,
            'created_at' => date('Y-m-d h:i:s')
            ]);

        return $create;
       
    }
    //
    public static function getProductOrderItem($id){

        $getOrderItem = DB::table('inventory_product_order_item')
        ->where('fk_product_order_id',$id)
        ->get();
        

        return $getOrderItem;
       
    }
    //delete product order item
    public static function deleteProductOrderItem($id){

        $delete = DB::table('inventory_product_order_item')
        ->where('id',$id)
        ->delete();
        

        return $delete;
       
    }
}
