<?php

namespace App\Http\Controllers;

use App\Helpers\ResponseHelper;
use App\Http\Requests\CreateClientRequest;
use App\Http\Requests\UpdateClientRequest;
use App\Http\Resources\ClientCollection;
use App\Http\Resources\ClientDetailResource;
use App\Models\ClientDetail;
use App\Repositories\Client\ClientRepositoryInterface;
use Illuminate\Http\Request;
use Inertia\Inertia;


class ClientDetailController extends Controller
{

    protected $clientRepositoryInterface;
    //
    public function __construct(ClientRepositoryInterface $clientRepositoryInterface)
    {
        $this->clientRepositoryInterface = $clientRepositoryInterface;
    }
    //create client details
    public function create()
    {
        return Inertia::render('Clients/Create');
    }
    public function store(CreateClientRequest $request)
    {
        try {
            $validatedData = $request->validated();
            $client = $this->clientRepositoryInterface->create($validatedData);

            return ResponseHelper::success('Client created successfully', $client);
        } catch (\Exception $e) {
            return ResponseHelper::error('Failed to create client', $e->getMessage(), 500);
        }
    }

    //
    //update client details
    public function update(UpdateClientRequest $request, $id)
    {
        try {
            $validatedData = $request->validated();

            $client = $this->clientRepositoryInterface->update($id, $validatedData);

            return ResponseHelper::success('Client updated successfully', $client);
        } catch (\Exception $e) {
            return ResponseHelper::error('Failed to update client', $e->getMessage(), 500);
        }
    }

    //all client details
    public function all(Request $request)
    {
        try {
            $filters = $request->all();
            $clients = $this->clientRepositoryInterface->all($filters);

            // return $clients;

            return ResponseHelper::success('Client details retrieved successfully', new ClientCollection($clients));
        } catch (\Exception $e) {
            return ResponseHelper::error('Failed to retrieve client details', $e->getMessage(), 500);
        }
    }

    //delete client details
    public function delete($id)
    {
        try {
            $client = $this->clientRepositoryInterface->delete($id);

            return ResponseHelper::success('Client deleted successfully', $client);
        } catch (\Exception $e) {
            return ResponseHelper::error('Failed to delete client', $e->getMessage(), 500);
        }
    }

    //get client details by id
    public function findById($id)
    {
        try {
            $client = $this->clientRepositoryInterface->findById($id);

            return ResponseHelper::success('Client details retrieved successfully', new ClientDetailResource($client));
        } catch (\Exception $e) {
            return ResponseHelper::error('Failed to retrieve client details', $e->getMessage(), 500);
        }
    }

    //pages

    public function index()
    {
        return Inertia::render('Clients/Index');
    }
}
