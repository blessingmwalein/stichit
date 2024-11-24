<?php

namespace App\Repositories\Order;

use App\Http\Requests\CreateOrderRequest;
use App\Http\Requests\UpdateOrderRequest;
use App\Models\Order;
use App\Models\User;
use App\Repositories\Order\OrderRepositoryInterface;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;

class OrderRepository implements OrderRepositoryInterface
{
    protected $model;

    public function __construct(Order $model)
    {
        $this->model = $model;
    }


    public function all(array $filters = [])
    {
        $paginationLimit = env('DEFAULT_PAGE_ITEMS', 10);

        $query = $this->model->query();

        // Filter by status
        if (!empty($filters['status'])) {
            $query->where('status', $filters['status']);
        }

        // Filter by delivery_date
        if (!empty($filters['delivery_date'])) {
            $query->whereDate('delivery_date', $filters['delivery_date']);
        }

        // Filter by client_name
        if (!empty($filters['client_name'])) {
            $query->whereHas('order.user', function ($q) use ($filters) {
                $q->where('name', 'like', '%' . $filters['client_name'] . '%');
            });
        }

        // Filter by client_email
        if (!empty($filters['client_email'])) {
            $query->whereHas('order.user', function ($q) use ($filters) {
                $q->where('email', 'like', '%' . $filters['client_email'] . '%');
            });
        }

        // Include related models
        return $query->paginate($paginationLimit);
    }

    public function findById($id)
    {
        return $this->model->find($id);
    }

    public function create(CreateOrderRequest $data)
    {
        try {
            $orderData = $data->except(['image']);
            $orderData['image_url'] = $data->file('image')->store('orders', 'public');
            $orderData['color_palet'] = json_encode($data->color_palet);
            return $this->model->create($orderData);
        } catch (\Exception $e) {
            Log::error('Order creation failed: ' . $e->getMessage());
            // dd($e->getMessage());
            throw new \Exception($e->getMessage());
        }
    }

    public function update($id, UpdateOrderRequest $data)
    {
        try {
            // Find the order by ID
            $order = $this->model->find($id);

            // If order not found, throw an exception
            if (!$order) {
                throw new \Exception("Order not found", 404); // 404 Not Found
            }

            // If image is provided, update the image
            if ($data->hasFile('image')) {
                //delete the old image
                if ($order->image_url) {
                    Storage::disk('public')->delete($order->image_url);
                }
                $data['image_url'] = $data->file('image')->store('orders', 'public');
            }

            // Perform the update
            $order->update($data->except('image'));

            // Return the updated order
            return $order;
        } catch (\Exception $e) {
            // Log the error for debugging purposes
            Log::error('Order update failed: ' . $e->getMessage());

            // Throw a more user-friendly exception
            throw new \Exception($e->getMessage(), $e->getCode() ?: 500); // Handle both order and server errors
        }
    }

    public function delete($id)
    {
        $order = $this->model->find($id);
        if ($order) {
            return $order->delete();
        }
        return false;
    }
}
