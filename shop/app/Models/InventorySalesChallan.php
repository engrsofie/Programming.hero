<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InventorySalesChallan extends Model
{
    protected $table = 'inventory_sales_delivery_challan';
    protected $fillable = ['fk_sales_id','challan_id','received_date','total_amount','created_by','status','shipping_address'];
}
