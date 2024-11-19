<?php

use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::get('/', function () {
    return Inertia::render('Welcome', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
        'laravelVersion' => Application::VERSION,
        'phpVersion' => PHP_VERSION,
    ]);
});

Route::middleware([
    'auth:sanctum',
    config('jetstream.auth_session'),
    'verified',
])->group(function () {
    Route::get('/dashboard', function () {
        return Inertia::render('Dashboard');
    })->name('dashboard');

    //client routes
    Route::group(['prefix' => 'client'], function () {
        Route::get('/accounts', [App\Http\Controllers\ClientDetailController::class, 'index'])->name('clients.index');
        //get create client form
        Route::get('/create', [App\Http\Controllers\ClientDetailController::class, 'create'])->name('clients.create');
        //get all clients
        Route::get('/all', [App\Http\Controllers\ClientDetailController::class, 'all'])->name('clients.all');
        //create client
        Route::post('/create', [App\Http\Controllers\ClientDetailController::class, 'create'])->name('clients.create');
        //g
    
    });
});
