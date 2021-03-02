<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InventoryProductOrderChallanItem extends Model
{
    protected $table = 'inventory_product_order_challan_item';
    protected $fillable = ['fk_order_challan_id','fk_order_item_id','qty','payable_amount','free_of_cost','batch_no'];
}
