<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InventorySalesPaymentHistory extends Model
{
    protected $table = 'inventory_payment_history';
    protected $fillable = ['invoice_id','total_amount','last_due','paid','payment_date','created_by','fk_account_id','fk_method_id','ref_id','fk_received_id','bank','fk_client_id','fk_branch_id','fk_company_id','summary','type'];
}
