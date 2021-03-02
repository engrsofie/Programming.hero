<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InventoryUOM extends Model
{
    protected $table = "unit_of_measurement";
    protected $fillable = ['uom_name','status'];
}
