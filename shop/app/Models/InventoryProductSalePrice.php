<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InventoryProductSalePrice extends Model
{
    protected $table = 'inventory_product_sale_price';
    protected $fillable = ['fk_client_id','fk_product_id','sale_price','created_by','updated_by'];
}
