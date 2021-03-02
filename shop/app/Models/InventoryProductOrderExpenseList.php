<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InventoryProductOrderExpenseList extends Model
{
    protected $table = "inventory_product_order_expenses_list";
    protected $fillable = ['title','status'];
}
