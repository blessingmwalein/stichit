<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Order extends Model
{

    protected $guarded;

    public function rug()
    {
        return $this->belongsTo(Rug::class);
    }

    public function client()
    {
        return $this->belongsTo(ClientDetail::class);
    }

    //size
    public function size()
    {
        return $this->belongsTo(RugSize::class);
    }
}
