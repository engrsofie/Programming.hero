<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class BillTransaction extends Model
{
    protected $table = "bill_transaction";
    protected $fillable = ['from_account','t_date','to_account','amount','method','description','company_name'];
}
