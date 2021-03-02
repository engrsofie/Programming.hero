<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PaymentHistory extends Model
{
    protected $table = "payment_history";
    protected $fillable = ['fk_payment_item_id','created_by','invoice_id','last_due','paid','payment_date']; 
}
