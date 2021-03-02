<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AccountSetting extends Model
{
    protected $table = "account";
    protected $fillable = ['account_name','current_balance','account_description','account_status','company_name','created_by','updated_by','fk_branch_id','fk_company_id'];
}
