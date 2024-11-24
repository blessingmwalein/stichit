<?php

namespace App\Http\Controllers;

use App\Helpers\ResponseHelper;
use App\Http\Requests\CreateOrderRequest;
use App\Http\Requests\UpdateOrderRequest;
use App\Http\Resources\ClientCollection;
use App\Http\Resources\OrderCollection;
use App\Http\Resources\OrderResource;
use App\Http\Resources\RugCollection;
use App\Repositories\Order\OrderRepositoryInterface;
use App\Repositories\Client\ClientRepositoryInterface;
use App\Repositories\Rug\RugRepositoryInterface;
use Illuminate\Http\Request;
use Inertia\Inertia;

class OrderController extends Controller
{
    protected $orderRepositoryInterface;
    protected $clientRepositoryInterface;
    protected $rugRepositoryInterface;
    //
    public function __construct(OrderRepositoryInterface $orderRepositoryInterface, ClientRepositoryInterface $clientRepositoryInterface, RugRepositoryInterface $rugRepositoryInterface)
    {
        $this->orderRepositoryInterface = $orderRepositoryInterface;
        $this->clientRepositoryInterface = $clientRepositoryInterface;
        $this->rugRepositoryInterface = $rugRepositoryInterface;
    }

    //create order details
    public function create()
    {
        return Inertia::render('Orders/Create', [
            'clients' => new ClientCollection($this->clientRepositoryInterface->all()),
            'rugs' => new RugCollection($this->rugRepositoryInterface->all())
        ]);
    }

    public function store(CreateOrderRequest $request)
    {
        try {
            // $validatedData = $request->validated();
            $order = $this->orderRepositoryInterface->create($request);

            // return ResponseHelper::success('Order created successfully', $order);
            return Inertia::render('Orders/Index')->with('success', 'Order created successfully');
        } catch (\Exception $e) {
            // return ResponseHelper::error('Failed to create order', $e->getMessage(), 500);
            return Inertia::render('Orders/Create')->with('error', $e->getMessage());
        }
    }

    //
    //update order details
    public function update(UpdateOrderRequest $request, $id)
    {
        try {
            $validatedData = $request->validated();

            $order = $this->orderRepositoryInterface->update($id, $request);

            return Inertia::render('Orders/Index')->with('success', 'Order updated successfully');
        } catch (\Exception $e) {
            return Inertia::render('Orders/Edit')->with('error', 'Failed to update order');
        }
    }

    //all order details
    public function all(Request $request)
    {
        try {
            $filters = $request->all();
            $rugs = $this->orderRepositoryInterface->all($filters);

            // return $rugs;

            return ResponseHelper::success('Order details retrieved successfully', new OrderCollection($rugs));
        } catch (\Exception $e) {
            return ResponseHelper::error('Failed to retrieve order details', $e->getMessage(), 500);
        }
    }

    //delete order details
    public function delete($id)
    {
        try {
            $order = $this->orderRepositoryInterface->delete($id);

            return Inertia::render('Orders/Index')->with('success', 'Order deleted successfully');
        } catch (\Exception $e) {
            return Inertia::render('Orders/Index')->with('error', 'Failed to delete order');
        }
    }

    //get order details by id
    public function findById($id)
    {
        try {
            $order = $this->orderRepositoryInterface->findById($id);

            return ResponseHelper::success('Order details retrieved successfully', new OrderResource($order));
        } catch (\Exception $e) {
            return ResponseHelper::error('Failed to retrieve order details', $e->getMessage(), 500);
        }
    }

    //pages

    public function index()
    {

        return Inertia::render('Orders/Index');
    }

    //edit order details
    public function edit($id)
    {
        $order = $this->orderRepositoryInterface->findById($id);

        return Inertia::render('Orders/Edit', [
            'order' => new OrderResource($order),
            'clients' => new ClientCollection($this->clientRepositoryInterface->all()),
            'rugs' => new RugCollection($this->rugRepositoryInterface->all())
        ]);
    }
}
