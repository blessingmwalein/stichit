<?php

namespace App\Repositories\AvailableMaterial;

use App\Http\Requests\CreateAvailableMaterialRequest;
use App\Http\Requests\CreateMaterialRequest;
use App\Http\Requests\UpdateMaterialRequest;
use App\Models\AvailableMaterial;
use App\Models\AvailbleMaterial;
use App\Models\MaterialType;
use App\Models\User;
use App\Repositories\AvailableMaterial\AvailableMaterialRepositoryInterface;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;

class AvailableMaterialRepository implements AvailableMaterialRepositoryInterface
{
    protected $model;

    public function __construct(AvailableMaterial $model)
    {
        $this->model = $model;
    }


    public function all(array $filters = [])
    {
        $paginationLimit = env('DEFAULT_PAGE_ITEMS', 10);

        $query = $this->model->query();

        // Filter by name
        if (!empty($filters['desciption'])) {
            ///like desciption
            $query->where('desciption', 'like', '%' . $filters['desciption'] . '%');
        }

        //filter by material type id relation
        if (!empty($filters['material_id'])) {
            $query->where('material_id', $filters['material_id']);
        }

        //filter by price per unit range
        if (!empty($filters['total_unit'])) {
            $priceRange = explode(',', $filters['total_unit']);
            $query->whereBetween('total_unit', $priceRange);
        }

        //filter by unit
        // quantity
        if (!empty($filters['quantity'])) {
            $query->where('quantity', $filters['quantity']);
        }


        // Include related models
        return $query->paginate($paginationLimit);
    }

    public function findById($id)
    {
        return $this->model->find($id);
    }

    public function create(CreateAvailableMaterialRequest $data)
    {
        try {
            return $this->model->create($data->validated());
        } catch (\Exception $e) {
            Log::error('Availble Material creation failed: ' . $e->getMessage());
            // dd($e->getMessage());
            throw new \Exception($e->getMessage());
        }
    }

    public function update($id, CreateAvailableMaterialRequest $data)
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
            Log::error('Available Material update failed: ' . $e->getMessage());

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
}
