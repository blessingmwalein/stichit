<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Material extends Model
{
    protected $guarded;

    public function materialType()
    {
        return $this->belongsTo(MaterialType::class);
    }
}
