<?php

namespace App\Providers;

use App\Repositories\Client\ClientRepository;
use App\Repositories\Client\ClientRepositoryInterface;
use App\Repositories\Rug\RugRepository;
use App\Repositories\Rug\RugRepositoryInterface;
use App\Repositories\Order\OrderRepository;
use App\Repositories\Order\OrderRepositoryInterface;
use App\Repositories\Material\MaterialRepository;
use App\Repositories\Material\MaterialRepositoryInterface;
use App\Repositories\AvailableMaterial\AvailableMaterialRepository;
use App\Repositories\AvailableMaterial\AvailableMaterialRepositoryInterface;
use Illuminate\Support\ServiceProvider;

class RepositoryServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     */
    public function register(): void
    {
        //
        $this->app->bind(ClientRepositoryInterface::class, ClientRepository::class);
        $this->app->bind(RugRepositoryInterface::class, RugRepository::class);
        $this->app->bind(OrderRepositoryInterface::class, OrderRepository::class);
        $this->app->bind(MaterialRepositoryInterface::class, MaterialRepository::class);
        $this->app->bind(AvailableMaterialRepositoryInterface::class, AvailableMaterialRepository::class);

    }

    /**
     * Bootstrap services.
     */
    public function boot(): void
    {
        //
    }
}
