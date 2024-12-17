<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class AvailableMaterialResource extends JsonResource
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
            'quantity' =>$this->quantity,
            'total_unit' => $this->total_unit,
            'desciption' => $this->total_unit,
            'material_id' => $this->material_id,
            'material_unit'=> $this->material->unit,
            'material_unit_price'=> $this->material->price_per_unit,
            'material_type_name' => $this->material->materialType->name,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
