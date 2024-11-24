<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class RugSize extends Model
{
    //

    protected $guarded;

    //size relationship
    public function size()
    {
        return $this->belongsTo(Size::class);
    }
}
