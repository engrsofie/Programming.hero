<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InventoryBranch extends Model
{
    protected $table = "inventory_branch";
    protected $fillable = ['branch_name','status']; 
}
