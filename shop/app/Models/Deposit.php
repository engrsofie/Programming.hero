<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Deposit extends Model
{
    protected $table = "deposit";
    protected $fillable = ['invoice_no','t_date','ref_id','fk_client_id','fk_account_id','fk_method_id','created_by','updated_by','amount','total_paid','fk_company_id','fk_branch_id']; 
}
