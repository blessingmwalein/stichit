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
        Schema::create('orders', function (Blueprint $table) {
            $table->id();
            $table->foreignId('rugs_id')->constrained('rugs')->onDelete('cascade');
            $table->foreignId('client_id')->constrained('client_details')->onDelete('cascade');
            $table->float('total_price')->default(0);
            $table->json('color_palet');
            $table->string('image_url')->nullable();
            $table->string('file_url')->nullable();
            $table->enum('status', ['Pending', 'Processing', 'Tufting', 'Binding','Delivered','Cancelled'])->default('Pending');
            $table->date('delivery_date')->nullable();
            $table->string('description')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('orders');
    }
};
