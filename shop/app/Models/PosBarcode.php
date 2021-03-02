<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PosBarcode extends Model
{
    protected $table = "pos_product_barcode";
    protected $fillable = ['fk_product_id','fk_model_id','barcode'];
}
