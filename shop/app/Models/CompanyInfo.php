<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CompanyInfo extends Model
{
    protected $table = "company_info";
    protected $fillable = ['company_name','web_address','company_address','company_email','company_phone','company_logo','company_icon','fb_page_link','shipping_address']; 
}
