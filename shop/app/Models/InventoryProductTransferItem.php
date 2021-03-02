<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InventoryProductTransferItem extends Model
{
    protected $table = "inventory_product_transfer_item";
    protected $fillable = ['qty','cost_amount','fk_product_id','fk_model_id','cost_per_unit','inventory_item_id','fk_inventory_item_id','fk_transfer_id']; 
}
