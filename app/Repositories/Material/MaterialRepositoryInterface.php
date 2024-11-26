<?php


namespace App\Repositories\Material;

use App\Http\Requests\CreateMaterialRequest;
use App\Http\Requests\UpdateMaterialRequest;

interface MaterialRepositoryInterface
{
    public function all(array $filters = []);
    public function findById($id);
    public function create(CreateMaterialRequest $data);
    public function update($id, UpdateMaterialRequest $data);
    public function delete($id);

    //get all material types
    public function getMaterialTypes();
}
