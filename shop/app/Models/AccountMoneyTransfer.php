<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AccountMoneyTransfer extends Model
{
    protected $table = "account_money_transfer";
    protected $fillable = ['transfer_from','date','transfer_to','amount','fk_method_id','description','created_by','updated_by'];
}
