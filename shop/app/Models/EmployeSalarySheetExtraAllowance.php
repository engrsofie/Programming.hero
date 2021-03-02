<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class EmployeSalarySheetExtraAllowance extends Model
{
    protected $table = "employe_salary_sheet_extra_allowance";
    protected $fillable = ['fk_salary_sheet_id','fk_salary_allowance_id','value'];
}
