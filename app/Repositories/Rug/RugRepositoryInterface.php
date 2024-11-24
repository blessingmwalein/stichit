<?php


namespace App\Repositories\Rug;

use App\Http\Requests\CreateRugRequest;
use App\Http\Requests\UpdateRugRequest;

interface RugRepositoryInterface
{
    public function all(array $filters = []);
    public function findById($id);
    public function create(CreateRugRequest $rugData);
    public function update($id, UpdateRugRequest $rugData);
    public function delete($id);

    //get all rug sizes
    public function getSizes();
}
