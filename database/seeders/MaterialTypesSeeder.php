<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class MaterialTypesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $materialTypes = [
            ['name' => 'Yarn', 'description' => 'High-quality yarn suitable for making rugs and other textile products.'],
            ['name' => 'Primary Cloth', 'description' => 'Durable cloth used as the base layer for tufted rugs.'],
            ['name' => 'Backing Cloth', 'description' => 'Cloth for providing a strong backing for finished rugs.'],
            ['name' => 'Hot Glue', 'description' => 'Adhesive used for securing edges and finer details in rugs.'],
            ['name' => 'Adhesive Glue', 'description' => 'Strong adhesive for attaching backing cloth and securing tufted materials.'],
        ];

        DB::table('material_types')->insert($materialTypes);
    }
}
