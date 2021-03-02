<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InventorySalesChallanItem extends Model
{
    protected $table = 'inventory_sales_challan_item';
    protected $fillable = ['fk_sales_challan_id','fk_sales_item_id','qty','payable_amount','small_qty','cost_amount','inventory_item_id'];
}
