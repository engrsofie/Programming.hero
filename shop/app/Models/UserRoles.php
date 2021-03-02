<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserRoles extends Model
{
    protected $table = "role";
    protected $fillable = ['role_type','role_status'];
}
