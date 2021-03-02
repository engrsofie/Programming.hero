<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InventoryProductTransfer extends Model
{
    protected $table = 'inventory_product_transfer';
    protected $fillable = ['transfer_from','transfer_to','total_amount','date','created_by','details'];
}
