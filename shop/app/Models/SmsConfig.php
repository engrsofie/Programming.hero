<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SmsConfig extends Model
{
    protected $table='sms_config';
    protected $fillable=['sms_quantity','user_name','password','from'];
}
