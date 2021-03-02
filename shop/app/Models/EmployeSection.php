<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class EmployeSection extends Model
{
    protected $table = "employe_section";
    protected $fillable = ['section_name','details','created_by','status'];
}
