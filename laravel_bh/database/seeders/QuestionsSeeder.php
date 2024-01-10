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


        /// Questions for the Personal Survey
        ///
        Question::create([
            "question" => "I enjoy places that are crowded with people",
            "survey_id" => 1,
        ]);

        Question::create([
            "question" => "I enjoy nightlife",
            "survey_id" => 1
        ]);

        Question::create([
            "question" => "I can't wait for my next outdoor activity",
            "survey_id" => 1
        ]);

        Question::create([
            "question" => "I find spending time in nature to be relaxing",
            "survey_id" => 1
        ]);

        Question::create([
            "question" => "I like to go to museums and art galleries",
            "survey_id" => 1
        ]);

        Question::create([
            "question" => "I find cultural and educational topics interesting",
            "survey_id" => 1
        ]);

        Question::create([
            "question" => "In my free time, you will find me reading a book",
            "survey_id" => 1
        ]);

        Question::create([
            "question" => "I am not a religious person",
            "survey_id" => 1
        ]);

        Question::create([
            "question" => "I enjoy places that are calm and not too crowded with people",
            "survey_id" => 1
        ]);

        Question::create([
            "question" => "I consider myself a spiritual person",
            "survey_id" => 1
        ]);

        Question::create([
            "question" => "I enjoy spending some time on self-care and personal services",
            "survey_id" => 1
        ]);

        Question::create([
            "question" => "I enjoy shopping for clothes",
            "survey_id" => 1
        ]);

        Question::create([
            "question" => "I enjoy physical exercise ",
            "survey_id" => 1
        ]);

        Question::create([
            "question" => "I enjoy dining in restaurants",
            "survey_id" => 1
        ]);

        Question::create([
            "question" => "I find grocery shopping fun",
            "survey_id" => 1
        ]);

        Question::create([
            "question" => "I absolutely hate shopping in general",
            "survey_id" => 1
        ]);

        Question::create([
            "question" => "I like to practice sports",
            "survey_id" => 1
        ]);

        Question::create([
            "question" => "I prefer take-away and delivery over dining in a restaurant",
            "survey_id" => 1
        ]);

        Question::create([
            "question" => "Sometimes a movie night is what I need",
            "survey_id" => 1
        ]);

        Question::create([
            "question" => "I like animals",
            "survey_id" => 1
        ]);
        /////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////
    }
}
