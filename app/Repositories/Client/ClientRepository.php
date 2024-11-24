<?php

namespace App\Repositories\Client;

use App\Models\ClientDetail;
use App\Models\User;
use App\Repositories\Client\ClientRepositoryInterface;
use Illuminate\Support\Facades\Log;

class ClientRepository implements ClientRepositoryInterface
{
    protected $model;

    public function __construct(ClientDetail $model)
    {
        $this->model = $model;
    }

    public function all(array $filters = [])
    {
        // Get the pagination limit from the .env file, with a default value of 10
        $paginationLimit = env('DEFAULT_PAGE_ITEMS', 10);

        // Start building the query with the relationship
        $query = $this->model->with('user');  // Eager load the 'user' relationship

        // Dynamically apply filters if they are provided
        if (isset($filters['name'])) {
            $query->whereHas('user', function ($query) use ($filters) {
                $query->where('name', 'like', '%' . $filters['name'] . '%');
            });
        }
        if (isset($filters['email'])) {
            $query->whereHas('user', function ($query) use ($filters) {
                $query->where('email', 'like', '%' . $filters['email'] . '%');
            });
        }
        if (isset($filters['phone_number'])) {
            $query->where('phone_number', 'like', '%' . $filters['phone_number'] . '%');
        }
        if (isset($filters['address'])) {
            $query->where('address', 'like', '%' . $filters['address'] . '%');
        }
        if (isset($filters['city'])) {
            $query->where('city', 'like', '%' . $filters['city'] . '%');
        }

        // Return the paginated result
        return $query->paginate($paginationLimit);
    }

    public function findById($id)
    {
        return $this->model->find($id);
    }

    public function create(array $data)
    {
        try {
            // Hash password and create a new user
            $data['password'] = bcrypt($data['name']);
            $user = User::create([
                'name' => $data['name'],
                'email' => $data['email'],
                'password' => $data['password'],
            ]);

            // Create a client detail entry
            return $this->model->create([
                'user_id' => $user->id,
                'gender' => $data['gender'],
                'phone_number' => $data['phone_number'],
                'address' => $data['address'],
                'city' => $data['city'],
            ]);
        } catch (\Exception $e) {
            Log::error('Client creation failed: ' . $e->getMessage());
            throw new \Exception('Unable to create client');
        }
    }

    public function update($id, array $data)
    {
        try {
            // Find the client by ID
            $client = $this->model->find($id);

            // If client not found, throw an exception
            if (!$client) {
                throw new \Exception("Client not found", 404); // 404 Not Found
            }

            // Perform the update
            $client->update($data);

            // Return the updated client
            return $client;
        } catch (\Exception $e) {
            // Log the error for debugging purposes
            Log::error('Client update failed: ' . $e->getMessage());

            // Throw a more user-friendly exception
            throw new \Exception($e->getMessage(), $e->getCode() ?: 500); // Handle both client and server errors
        }
    }

    public function delete($id)
    {
        $user = $this->model->find($id);
        if ($user) {
            return $user->delete();
        }
        return false;
    }
}
