<?php

namespace App\Http\Controllers;

use App\Helpers\ResponseHelper;
use App\Http\Requests\CreateMaterialRequest;
use App\Http\Requests\UpdateMaterialRequest;
use App\Http\Resources\ClientCollection;
use App\Http\Resources\MaterialCollection;
use App\Http\Resources\MaterialResource;
use App\Repositories\Client\ClientRepositoryInterface;
use App\Repositories\Material\MaterialRepositoryInterface;
use App\Repositories\Rug\RugRepositoryInterface;
use Illuminate\Http\Request;
use Inertia\Inertia;

class MaterialController extends Controller
{
    protected $materialRepositoryInterface;
    protected $clientRepositoryInterface;
    protected $rugRepositoryInterface;
    //
    public function __construct(MaterialRepositoryInterface $materialRepositoryInterface, ClientRepositoryInterface $clientRepositoryInterface, RugRepositoryInterface $rugRepositoryInterface)
    {
        $this->materialRepositoryInterface = $materialRepositoryInterface;
        $this->clientRepositoryInterface = $clientRepositoryInterface;
        $this->rugRepositoryInterface = $rugRepositoryInterface;
    }

    //create material details
    public function create()
    {
        return Inertia::render('Materials/Create', [
            'materialTypes' => $this->materialRepositoryInterface->getMaterialTypes()
        ]);
    }

    public function store(CreateMaterialRequest $request)
    {
        try {
            // $validatedData = $request->validated();
            $material = $this->materialRepositoryInterface->create($request);

            // return ResponseHelper::success('Material created successfully', $material);
            return Inertia::render('Materials/Index')->with('success', 'Material created successfully');
        } catch (\Exception $e) {
            // return ResponseHelper::error('Failed to create material', $e->getMessage(), 500);
            return Inertia::render('Materials/Create')->with('error', $e->getMessage());
        }
    }

    //
    //update material details
    public function update(UpdateMaterialRequest $request, $id)
    {
        try {
            $validatedData = $request->validated();

            dd($validatedData);

            $material = $this->materialRepositoryInterface->update($id, $request);

            return Inertia::render('Materials/Index')->with('success', 'Material updated successfully');
        } catch (\Exception $e) {
            return Inertia::render('Materials/Edit')->with('error', 'Failed to update material');
        }
    }

    //all material details
    public function all(Request $request)
    {
        try {
            $filters = $request->all();
            $materials = $this->materialRepositoryInterface->all($filters);

            // return $materials;

            return ResponseHelper::success('Material details retrieved successfully', new MaterialCollection($materials));
        } catch (\Exception $e) {
            return ResponseHelper::error('Failed to retrieve material details', $e->getMessage(), 500);
        }
    }

    //delete material details
    public function delete($id)
    {
        try {
            $material = $this->materialRepositoryInterface->delete($id);

            return Inertia::render('Materials/Index')->with('success', 'Material deleted successfully');
        } catch (\Exception $e) {
            return Inertia::render('Materials/Index')->with('error', 'Failed to delete material');
        }
    }

    //get material details by id
    public function findById($id)
    {
        try {
            $material = $this->materialRepositoryInterface->findById($id);

            return ResponseHelper::success('Material details retrieved successfully', new MaterialResource($material));
        } catch (\Exception $e) {
            return ResponseHelper::error('Failed to retrieve material details', $e->getMessage(), 500);
        }
    }

    //pages

    public function index()
    {

        return Inertia::render('Materials/Index');
    }

    //edit material details
    public function edit($id)
    {
        $material = $this->materialRepositoryInterface->findById($id);

        return Inertia::render('Materials/Edit', [
            'material' => new MaterialResource($material),
            'materialTypes' => $this->materialRepositoryInterface->getMaterialTypes()

        ]);
    }
}
