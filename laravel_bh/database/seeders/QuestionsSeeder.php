<?php

namespace Database\Seeders;

use App\Models\Question;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class QuestionsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Question::create([
            "question" => "First question in Couple's Survey",
            "survey_id" => "2",
        ]);

        Question::create([
            "question" => "First question in Personal Survey",
            "survey_id" => "1",
        ]);
    }
}
