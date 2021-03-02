<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InventoryBrand extends Model
{
    protected $table = "product_brand";
    protected $fillable = ['brand_name','status']; 
}
