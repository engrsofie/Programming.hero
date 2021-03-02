<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use DB;
class Inventory extends Model
{
    protected $table = "inventory";
    protected $fillable = ['fk_product_id','available_qty','sales_per_unit','available_small_qty','cost_per_unit','fk_branch_id','fk_company_id','fk_model_id']; 
}
