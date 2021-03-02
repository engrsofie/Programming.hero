<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Payment extends Model
{
    protected $table = "payment";
    protected $fillable = ['invoice_no','t_date','ref_id','fk_client_id','fk_account_id','fk_method_id','amount','total_paid','created_by','updated_by','fk_company_id','fk_branch_id']; 


}
