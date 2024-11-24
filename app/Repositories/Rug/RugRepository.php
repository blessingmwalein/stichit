<?php

namespace App\Repositories\Rug;

use App\Http\Requests\CreateRugRequest;
use App\Http\Requests\UpdateRugRequest;
use App\Models\ClientDetail;
use App\Models\Rug;
use App\Models\Size;
use App\Models\User;
use App\Repositories\Rug\RugRepositoryInterface;
use Illuminate\Support\Facades\Log;

class RugRepository implements RugRepositoryInterface
{
    protected $model;

    public function __construct(Rug $model)
    {
        $this->model = $model;
    }

    public function all(array $filters = [])
    {
        // Get the pagination limit from the .env file, with a default value of 10
        $paginationLimit = env('DEFAULT_PAGE_ITEMS', 10);

        // Start building the query with relationships
        $query = $this->model->query(); // Start a query builder for the Rug model

        // Dynamically apply filters if provided
        if (isset($filters['name'])) {
            $query->where('name', 'like', '%' . $filters['name'] . '%');
        }

        if (isset($filters['type'])) {
            $query->where('type', $filters['type']);
        }

        if (isset($filters['min_production_cost'])) {
            $query->where('approx_production_cost', '>=', $filters['min_production_cost']);
        }

        if (isset($filters['max_production_cost'])) {
            $query->where('approx_production_cost', '<=', $filters['max_production_cost']);
        }

        if (isset($filters['min_cost'])) {
            $query->where('approx_cost', '>=', $filters['min_cost']);
        }

        if (isset($filters['max_cost'])) {
            $query->where('approx_cost', '<=', $filters['max_cost']);
        }

        if (isset($filters['created_after'])) {
            $query->whereDate('created_at', '>=', $filters['created_after']);
        }

        if (isset($filters['created_before'])) {
            $query->whereDate('created_at', '<=', $filters['created_before']);
        }

        // Return paginated results
        return $query->paginate($paginationLimit);
    }


    public function findById($id)
    {
        return $this->model->find($id);
    }

    public function create(CreateRugRequest $data)
    {
        try {
            // Extract the data excluding sizes
            $rugData = $data->except('sizes');
            $rug = $this->model->create($rugData);

            // Extract sizes and prepare them for storage
            $sizes = $data->only('sizes')['sizes'];

            // Check if sizes are provided and ensure they are correctly formatted
            $sizesToCreate = [];
            foreach ($sizes as $sizeId) {
                $sizesToCreate[] = [
                    'rug_id' => $rug->id,  // Associate each size with the created rug
                    'size_id' => $sizeId,  // Assuming size_id is the identifier
                    // Add any additional fields required for the RugSize model, e.g., `width`, `length`, etc.
                ];
            }

            // Create the associated sizes
            $rug->sizes()->createMany($sizesToCreate);

            return $rug;
        } catch (\Exception $e) {
            Log::error('Rug creation failed: ' . $e->getMessage());
            throw new \Exception($e->getMessage(), $e->getCode() ?: 500);
        }
    }


    public function update($id, UpdateRugRequest $data)
    {
        try {
            // Find the rug by ID
            $rug = $this->model->find($id);

            if (!$rug) {
                throw new \Exception('Rug not found', 404);
            }

            $rugData = $data->except('sizes');

            // Update the rug data
            $rug->update($rugData);

            // Get the sizes data
            $sizesData = $data->only('sizes');

            // Prepare sizes data for syncing
            $sizeIds = collect($sizesData)->pluck('id')->filter();

            // Remove sizes that are no longer in the provided data
            $rug->sizes()->whereNotIn('id', $sizeIds)->delete();

            foreach ($sizesData as $sizeData) {
                if (isset($sizeData['id'])) {
                    // Update existing size
                    $rug->sizes()->where('id', $sizeData['id'])->update($sizeData);
                } else {
                    // Create new size
                    $rug->sizes()->create($sizeData);
                }
            }
        } catch (\Exception $e) {
            // Log the error for debugging purposes
            Log::error('Rug update failed: ' . $e->getMessage());

            // Throw a user-friendly exception
            throw new \Exception($e->getMessage(), $e->getCode() ?: 500);
        }
    }


    public function delete($id)
    {
        $rug = $this->model->find($id);
        if ($rug) {
            //delete rug sizes
            $rug->sizes()->delete();
            return $rug->delete();
        }
        return false;
    }

    public function getSizes()
    {
        return Size::all();
    }
}
