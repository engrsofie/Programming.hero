<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InventorySalesPaymentHistoryItem extends Model
{
    protected $table = 'inventory_payment_history_item';
    protected $fillable = ['fk_payment_id','fk_sales_id','sales_last_due','sales_paid','type'];
}
