<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Rug extends Model
{
    //

    protected $guarded;

    public function sizes()
    {
        return $this->hasMany(RugSize::class);
    }
}
