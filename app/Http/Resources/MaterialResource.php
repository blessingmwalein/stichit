<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class MaterialResource extends JsonResource
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
            'name' => $this->name,
            'material_type_id' => $this->material_type_id,
            'material_type_name' => $this->materialType->name,
            'material_type_description' => $this->materialType->description,
            'price_per_unit' => $this->price_per_unit,
            'unit' => $this->unit,
            'brand' => $this->brand,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
