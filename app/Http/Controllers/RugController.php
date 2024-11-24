<?php

namespace App\Http\Controllers;

use App\Helpers\ResponseHelper;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Http\Requests\CreateRugRequest;
use App\Http\Requests\UpdateRugRequest;
use App\Http\Resources\RugCollection;
use App\Http\Resources\RugResource;
use App\Repositories\Rug\RugRepositoryInterface;

class RugController extends Controller
{
    protected $rugRepositoryInterface;
    //
    public function __construct(RugRepositoryInterface $rugRepositoryInterface)
    {
        $this->rugRepositoryInterface = $rugRepositoryInterface;
    }
    //create rug details
    public function create()
    {
        return Inertia::render('Rugs/Create', ['sizes' => $this->rugRepositoryInterface->getSizes()]);
    }
    public function store(CreateRugRequest $request)
    {
        try {
            // $validatedData = $request->validated();
            $rug = $this->rugRepositoryInterface->create($request);

            // return ResponseHelper::success('Rug created successfully', $rug);
            return Inertia::render('Rugs/Index')->with('success', 'Rug created successfully');
        } catch (\Exception $e) {
            // return ResponseHelper::error('Failed to create rug', $e->getMessage(), 500);


            return Inertia::render('Rugs/Create')->with('error', $e->getMessage());
        }
    }

    //
    //update rug details
    public function update(UpdateRugRequest $request, $id)
    {
        try {
            $validatedData = $request->validated();

            $rug = $this->rugRepositoryInterface->update($id, $request);

            return Inertia::render('Rugs/Index')->with('success', 'Rug updated successfully');
        } catch (\Exception $e) {
            return Inertia::render('Rugs/Edit')->with('error', 'Failed to update rug');
        }
    }

    //all rug details
    public function all(Request $request)
    {
        try {
            $filters = $request->all();
            $rugs = $this->rugRepositoryInterface->all($filters);

            // return $rugs;

            return ResponseHelper::success('Rug details retrieved successfully', new RugCollection($rugs));
        } catch (\Exception $e) {
            return ResponseHelper::error('Failed to retrieve rug details', $e->getMessage(), 500);
        }
    }

    //delete rug details
    public function delete($id)
    {
        try {
            $rug = $this->rugRepositoryInterface->delete($id);

            return Inertia::render('Rugs/Index')->with('success', 'Rug deleted successfully');
        } catch (\Exception $e) {
            return Inertia::render('Rugs/Index')->with('error', 'Failed to delete rug');
        }
    }

    //get rug details by id
    public function findById($id)
    {
        try {
            $rug = $this->rugRepositoryInterface->findById($id);

            return ResponseHelper::success('Rug details retrieved successfully', new RugResource($rug));
        } catch (\Exception $e) {
            return ResponseHelper::error('Failed to retrieve rug details', $e->getMessage(), 500);
        }
    }

    //pages

    public function index()
    {

        return Inertia::render('Rugs/Index');
    }

    //edit rug details
    public function edit($id)
    {
        $rug = $this->rugRepositoryInterface->findById($id);

        return Inertia::render('Rugs/Edit', ['rug' => new RugResource($rug),'sizes' => $this->rugRepositoryInterface->getSizes()]);
    }
}
