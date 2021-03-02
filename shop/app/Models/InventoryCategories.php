<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InventoryCategories extends Model
{
    protected $table = "product_category";
    protected $fillable = ['category_name','status']; 
}
