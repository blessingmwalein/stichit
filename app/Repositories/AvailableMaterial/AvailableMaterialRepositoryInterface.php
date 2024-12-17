<?php


namespace App\Repositories\AvailableMaterial;

use App\Http\Requests\CreateAvailableMaterialRequest;
use App\Http\Requests\CreateMaterialRequest;
use App\Http\Requests\UpdateMaterialRequest;

interface AvailableMaterialRepositoryInterface
{
    public function all(array $filters = []);
    public function findById($id);
    public function create(CreateAvailableMaterialRequest $data);
    public function update($id, CreateAvailableMaterialRequest $data);
    public function delete($id);
}
