<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InventoryProductOrderChallan extends Model
{
    protected $table = 'inventory_product_order_challan';
    protected $fillable = ['fk_order_id','challan_id','received_date','total_amount','created_by','status'];
}
