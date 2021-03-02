<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use DB;
class InventoryProductOrder extends Model
{
    protected $table = 'inventory_product_order';
    protected $fillable = ['fk_supplier_id','inventory_order_id','order_date','total_amount','total_paid','summery','created_by','updated_by','status','shipping_address','fk_account_id','fk_method_id','ref_id','other_expenses','lc_no','opening_date','total_price_with_expenses'];

    public static function getProductOrder($id){

        $getOrder = DB::table('inventory_product_order')
        ->where('id',$id)
        ->first();
        

        return $getOrder;
       
    }

    //delete product order
    public static function deleteProductOrder($id){

        $delete = DB::table('inventory_product_order')
        ->where('id',$id)
        ->delete();
        

        return $delete;
       
    }
}
