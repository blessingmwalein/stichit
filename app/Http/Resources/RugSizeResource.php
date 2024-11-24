<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class RugSizeResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'size_id' => $this->size_id,
            'shape' => $this->shape,
            'width' => $this->size->width,
            'length' => $this->size->length,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
