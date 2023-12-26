<?php

namespace Database\Seeders;

use App\Models\Option;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class OptionsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Option::create([ "option" => "1 question 1", "question_id" => "2" ]);
        Option::create([ "option" => "2 question 1", "question_id" => "2" ]);
        Option::create([ "option" => "1 question 2", "question_id" => "3" ]);
        Option::create([ "option" => "1 question 3", "question_id" => "4" ]);
    }
}
