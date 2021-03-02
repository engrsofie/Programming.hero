<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class EmployeSalarySheet extends Model
{
    protected $table = "employe_salary_sheet";
    protected $fillable = ['fk_employe_id','basic_pay','house_rent','medical_allowance','year','month','total_amount','deduction','paid_amount','fk_account_id','fk_method_id','ref_id','date','created_by','updated_by'];
    public function user(){
    	return $this->belongsTo(\App\User::class,'created_by','id');
    }
}
