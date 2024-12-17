<?php

namespace App\Http\Controllers;

use App\Helpers\ResponseHelper;
use App\Http\Requests\CreateAvailableMaterialRequest;
use App\Http\Resources\AvailableMaterialCollection;
use App\Http\Resources\AvailableMaterialResource;
use App\Repositories\AvailableMaterial\AvailableMaterialRepositoryInterface;
use App\Repositories\Client\ClientRepositoryInterface;
use App\Repositories\Rug\RugRepositoryInterface;
use Illuminate\Http\Request;
use Inertia\Inertia;

class AvailableMaterialController extends Controller
{
    protected $availableMaterialRepositoryInterface;
    protected $clientRepositoryInterface;
    protected $rugRepositoryInterface;
    //
    public function __construct(AvailableMaterialRepositoryInterface $availableMaterialRepositoryInterface, ClientRepositoryInterface $clientRepositoryInterface, RugRepositoryInterface $rugRepositoryInterface)
    {
        $this->availableMaterialRepositoryInterface = $availableMaterialRepositoryInterface;
        $this->clientRepositoryInterface = $clientRepositoryInterface;
        $this->rugRepositoryInterface = $rugRepositoryInterface;
    }

    //create material details
    public function create()
    {
        return Inertia::render('Materials/Available/Create', []);
    }

    public function store(CreateAvailableMaterialRequest $request)
    {
        try {
            // $validatedData = $request->validated();
            $material = $this->availableMaterialRepositoryInterface->create($request);

            // return ResponseHelper::success('Material created successfully', $material);
            return Inertia::render('Materials/Availbale/Index')->with('success', 'Material created successfully');
        } catch (\Exception $e) {
            // return ResponseHelper::error('Failed to create material', $e->getMessage(), 500);
            return Inertia::render('Materials/Available/Create')->with('error', $e->getMessage());
        }
    }

    //
    //update material details
    public function update(CreateAvailableMaterialRequest $request, $id)
    {
        try {
            $validatedData = $request->validated();

            $material = $this->availableMaterialRepositoryInterface->update($id, $request);

            return Inertia::render('Materials/Available/Index')->with('success', 'Material updated successfully');
        } catch (\Exception $e) {
            return Inertia::render('Materials/Available/Edit')->with('error', 'Failed to update material');
        }
    }

    //all material details
    public function all(Request $request)
    {
        try {
            $filters = $request->all();
            $materials = $this->availableMaterialRepositoryInterface->all($filters);

            // return $materials;

            return ResponseHelper::success('Material details retrieved successfully', new AvailableMaterialCollection($materials));
        } catch (\Exception $e) {
            return ResponseHelper::error('Failed to retrieve material details', $e->getMessage(), 500);
        }
    }

    //delete material details
    public function delete($id)
    {
        try {
            $material = $this->availableMaterialRepositoryInterface->delete($id);

            return Inertia::render('Materials/Index')->with('success', 'Material deleted successfully');
        } catch (\Exception $e) {
            return Inertia::render('Materials/Index')->with('error', 'Failed to delete material');
        }
    }

    //get material details by id
    public function findById($id)
    {
        try {
            $material = $this->availableMaterialRepositoryInterface->findById($id);

            return ResponseHelper::success('Material details retrieved successfully', new AvailableMaterialResource($material));
        } catch (\Exception $e) {
            return ResponseHelper::error('Failed to retrieve material details', $e->getMessage(), 500);
        }
    }

    //pages

    public function index()
    {

        return Inertia::render('Materials/Available/Index');
    }

    //edit material details
    public function edit($id)
    {
        $material = $this->availableMaterialRepositoryInterface->findById($id);

        return Inertia::render('Materials/Available/Edit', [
            'material' => new AvailableMaterialResource($material),
        ]);
    }
}
