<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class SizeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Default sizes
        $sizes = [
            ['width' => 50, 'length' => 50],
            ['width' => 80, 'length' => 80],
            ['width' => 60, 'length' => 100],
            ['width' => 100, 'length' => 100],
            ['width' => 80, 'length' => 100],
        ];

        // Insert sizes into the database
        DB::table('sizes')->insert($sizes);
    }
}
