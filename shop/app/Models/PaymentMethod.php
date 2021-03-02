<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PaymentMethod extends Model
{
    protected $table = "payment_method";
    protected $fillable = ['method_name','method_description','method_status','company_name','created_by','updated_by'];
    
}
