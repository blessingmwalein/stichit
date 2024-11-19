<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('rugs', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->enum("type", ['small', 'medium', 'large']);
            $table->float('approx_production_cost')->default(0);
            $table->float('approx_cost')->default(0);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('rugs');
    }
};
