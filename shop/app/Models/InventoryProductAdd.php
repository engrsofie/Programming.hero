<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InventoryProductAdd extends Model
{
    protected $table = 'inventory_product_add';
    protected $fillable = ['fk_supplier_id','inventory_order_id','total_amount','summery','created_by','updated_by','status','date','total_paid','challan_id'];
}
