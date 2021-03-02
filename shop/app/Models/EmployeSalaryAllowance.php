<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class EmployeSalaryAllowance extends Model
{
    protected $table = "employe_salary_allowance";
    protected $fillable = ['title','type','status','created_by'];
}
