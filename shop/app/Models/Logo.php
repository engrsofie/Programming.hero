<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Logo extends Model
{
    protected $table = "logo";
    protected $fillable = ['logoHeadline','logoImagePath','logoIcoPath','organization'];
}
