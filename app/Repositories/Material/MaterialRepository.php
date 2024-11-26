<?php

namespace App\Repositories\Material;

use App\Http\Requests\CreateMaterialRequest;
use App\Http\Requests\UpdateMaterialRequest;
use App\Models\Material;
use App\Models\MaterialType;
use App\Models\User;
use App\Repositories\Material\MatarialRepositoryInterface;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;

class MaterialRepository implements MaterialRepositoryInterface
{
    protected $model;

    public function __construct(Material $model)
    {
        $this->model = $model;
    }


    public function all(array $filters = [])
    {
        $paginationLimit = env('DEFAULT_PAGE_ITEMS', 10);

        $query = $this->model->query();

        // Filter by name
        if (!empty($filters['name'])) {
            $query->where('name', $filters['name']);
        }

        //filter by material type id relation
        if (!empty($filters['material_type_id'])) {
            $query->where('material_type_id', $filters['material_type_id']);
        }

        //filter by price per unit range
        if (!empty($filters['price_per_unit'])) {
            $priceRange = explode(',', $filters['price_per_unit']);
            $query->whereBetween('price_per_unit', $priceRange);
        }

        //filter by unit
        if (!empty($filters['unit'])) {
            $query->where('unit', $filters['unit']);
        }

        //filter by brand
        if (!empty($filters['brand'])) {
            $query->where('brand', $filters['brand']);
        }

        // Include related models
        return $query->paginate($paginationLimit);
    }

    public function findById($id)
    {
        return $this->model->find($id);
    }

    public function create(CreateMaterialRequest $data)
    {
        try {
            return $this->model->create($data->validated());
        } catch (\Exception $e) {
            Log::error('Material creation failed: ' . $e->getMessage());
            // dd($e->getMessage());
            throw new \Exception($e->getMessage());
        }
    }

    public function update($id, UpdateMaterialRequest $data)
    {
        try {
            $material = $this->model->find($id);
            if ($material) {
                $material->update($data);
                return $material;
            }
            return false;
        } catch (\Exception $e) {
            // Log the error for debugging purposes
            Log::error('Material update failed: ' . $e->getMessage());

            // Throw a more user-friendly exception
            throw new \Exception($e->getMessage(), $e->getCode() ?: 500); // Handle both order and server errors
        }
    }

    public function delete($id)
    {
        $material = $this->model->find($id);
        if ($material) {
            return $material->delete();
        }
        return false;
    }

    public function getMaterialTypes()
    {
        return MaterialType::all();
    }
}
