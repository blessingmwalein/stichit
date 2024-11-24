<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class RugResource extends JsonResource
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
            'type' => $this->type,
            'approx_production_cost' => $this->approx_production_cost,
            'approx_cost' => $this->approx_cost,
            'sizes' => RugSizeResource::collection($this->sizes),
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
