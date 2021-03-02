<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InventoryItem extends Model
{
    protected $table = "inventory_item";
    protected $fillable = ['fk_inventory_id','fk_stock_position_id','brach_no','qty','cost_per_unit','sales_per_unit','summary','type','available_qty','fk_branch_id','fk_company_id']; 
}
