<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ProjectItem extends Model
{
    protected $table = "project_item";
    protected $fillable = ['project_name','project_description','project_status','company_name','created_by','updated_by'];
}
