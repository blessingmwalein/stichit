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
        Route::post('/store', [App\Http\Controllers\ClientDetailController::class, 'store'])->name('clients.store');
        //update client
        Route::put('/update/{id}', [App\Http\Controllers\ClientDetailController::class, 'update'])->name('clients.update');
        //delete client
        Route::delete('/delete/{id}', [App\Http\Controllers\ClientDetailController::class, 'delete'])->name('clients.delete');
        //g
        Route::get('/edit/{id}', [App\Http\Controllers\ClientDetailController::class, 'edit'])->name('clients.edit');
    });

    //rug routes
    Route::group(['prefix' => 'rugs'], function () {
        Route::get('/create', [App\Http\Controllers\RugController::class, 'create'])->name('rugs.create');
        Route::post('/store', [App\Http\Controllers\RugController::class, 'store'])->name('rugs.store');
        Route::put('/update/{id}', [App\Http\Controllers\RugController::class, 'update'])->name('rugs.update');
        Route::get('/all', [App\Http\Controllers\RugController::class, 'all'])->name('rugs.all');
        Route::get('/', [App\Http\Controllers\RugController::class, 'index'])->name('rugs.all');
        Route::get('/edit/{id}', [App\Http\Controllers\RugController::class, 'edit'])->name('rugs.edit');
        Route::delete('/delete/{id}', [App\Http\Controllers\RugController::class, 'delete'])->name('rugs.delete');
        
    });

    //order routes
    Route::group(['prefix' => 'orders'], function () {
        Route::get('/create', [App\Http\Controllers\OrderController::class, 'create'])->name('orders.create');
        Route::post('/store', [App\Http\Controllers\OrderController::class, 'store'])->name('orders.store');
        Route::put('/update/{id}', [App\Http\Controllers\OrderController::class, 'update'])->name('orders.update');
        Route::get('/all', [App\Http\Controllers\OrderController::class, 'all'])->name('orders.all');
        Route::get('/', [App\Http\Controllers\OrderController::class, 'index'])->name('orders.all');
        Route::get('/edit/{id}', [App\Http\Controllers\OrderController::class, 'edit'])->name('orders.edit');
        Route::delete('/delete/{id}', [App\Http\Controllers\OrderController::class, 'delete'])->name('orders.delete');
    });
});
