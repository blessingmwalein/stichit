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
        Schema::create('rug_sizes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('rug_id')->constrained('rugs')->onDelete('cascade');
            $table->foreignId('size_id')->constrained('sizes')->onDelete('cascade');
            $table->enum('shape', ['Rectangle', 'Square', 'Circle', 'Oval', 'Octagon', 'Hexagon', 'Runner', 'Custom'])->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('rug_sizes');
    }
};
