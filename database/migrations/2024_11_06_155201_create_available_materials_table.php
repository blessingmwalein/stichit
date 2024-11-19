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
        Schema::create('available_materials', function (Blueprint $table) {
            $table->id();
            $table->foreignId('material_id')->constrained('material_types')->onDelete('cascade');
            $table->float('quantity')->default(0);
            $table->float('total_unit')->default(0);
            $table->string('desciption')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('available_materials');
    }
};
