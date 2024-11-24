<?php

namespace App\Http\Resources;

use App\Models\RugSize;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class OrderResource extends JsonResource
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
            'rug_id' => $this->rug_id,
            'size_id' => $this->size_id,
            'rug' => new RugResource($this->rug),
            'size' => new RugSizeResource($this->size),
            'client_id' => $this->client_id,
            'client_name' => $this->client->user->name,
            'email' => $this->client->user->email,
            'total_price' => $this->total_price,
            'color_palet' => json_decode($this->color_palet),
            'image_url' => $this->image_url,
            'status' => $this->status,
            'file_url' => $this->file_url,
            'delivery_date' => $this->delivery_date,
            'description' => $this->description,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
