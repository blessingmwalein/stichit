<?php


namespace App\Repositories\Order;

use App\Http\Requests\CreateOrderRequest;
use App\Http\Requests\UpdateOrderRequest;

interface OrderRepositoryInterface
{
    public function all(array $filters = []);
    public function findById($id);
    public function create(CreateOrderRequest $data);
    public function update($id, UpdateOrderRequest $data);
    public function delete($id);
}
