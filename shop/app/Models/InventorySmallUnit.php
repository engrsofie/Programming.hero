<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InventorySmallUnit extends Model
{
    protected $table = "inventory_small_unit";
    protected $fillable = ['small_unit_name','status'];
}
