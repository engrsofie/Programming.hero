<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DepositHistory extends Model
{
    protected $table = "deposit_history";
    protected $fillable = ['fk_deposit_item_id','created_by','invoice_id','last_due','paid','payment_date']; 
}
