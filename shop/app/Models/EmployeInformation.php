<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class EmployeInformation extends Model
{
    protected $table = "employe_information";
    protected $fillable = ['employe_name','photo','employe_id','employe_email','address','mobile_number','designation','fk_section_id','basic_pay','house_rent','medical_allowance','status','created_by','updated_by','fk_branch_id','fk_company_id'];

    public function section(){
    	return $this->belongsTo('App\Models\EmployeSection','fk_section_id','id');
    }

    public function branch(){
    	return $this->belongsTo('App\Models\InventoryBranch','fk_branch_id','id');
    }



}
