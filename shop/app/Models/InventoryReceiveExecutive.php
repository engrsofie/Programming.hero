<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InventoryReceiveExecutive extends Model
{
    protected $table = "inventory_receive_executive";
    protected $fillable = ['executive_name','details','created_by','status'];
}
