<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InventoryStockPosition extends Model
{
    protected $table = "inventory_stock_position";
    protected $fillable = ['position_name','status','fk_branch_id','fk_company_id']; 
}
