<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DemoExecl extends Model
{
    protected $table = "execl";
    protected $fillable = ['name','description','location']; 
}
