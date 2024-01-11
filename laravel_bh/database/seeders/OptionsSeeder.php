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

        /// Options for the questions of the Personal Survey with syrvey_id = 1
        ///
        Option::create([ "option" => "No", "question_id" => 1 ]);
        Option::create([ "option" => "Yes", "question_id" => 1 ]);

        Option::create([ "option" => "No", "question_id" => 2 ]);
        Option::create([ "option" => "Yes", "question_id" => 2 ]);

        Option::create([ "option" => "No", "question_id" => 3 ]);
        Option::create([ "option" => "Yes", "question_id" => 3 ]);

        Option::create([ "option" => "No", "question_id" => 4 ]);
        Option::create([ "option" => "Yes", "question_id" => 4 ]);

        Option::create([ "option" => "No", "question_id" => 5 ]);
        Option::create([ "option" => "Yes", "question_id" => 5 ]);

        Option::create([ "option" => "No", "question_id" => 6 ]);
        Option::create([ "option" => "Yes", "question_id" => 6 ]);

        Option::create([ "option" => "No", "question_id" => 7 ]);
        Option::create([ "option" => "Yes", "question_id" => 7 ]);

        Option::create([ "option" => "No", "question_id" => 8 ]);
        Option::create([ "option" => "Yes", "question_id" => 8 ]);

        Option::create([ "option" => "No", "question_id" => 9 ]);
        Option::create([ "option" => "Yes", "question_id" => 9 ]);

        Option::create([ "option" => "No", "question_id" => 10 ]);
        Option::create([ "option" => "Yes", "question_id" => 10 ]);

        Option::create([ "option" => "No", "question_id" => 11 ]);
        Option::create([ "option" => "Yes", "question_id" => 11 ]);

        Option::create([ "option" => "No", "question_id" => 12 ]);
        Option::create([ "option" => "Yes", "question_id" => 12 ]);

        Option::create([ "option" => "No", "question_id" => 13 ]);
        Option::create([ "option" => "Yes", "question_id" => 13 ]);

        Option::create([ "option" => "No", "question_id" => 14 ]);
        Option::create([ "option" => "Yes", "question_id" => 14 ]);

        Option::create([ "option" => "No", "question_id" => 15 ]);
        Option::create([ "option" => "Yes", "question_id" => 15 ]);

        Option::create([ "option" => "No", "question_id" => 16 ]);
        Option::create([ "option" => "Yes", "question_id" => 16 ]);

        Option::create([ "option" => "No", "question_id" => 17 ]);
        Option::create([ "option" => "Yes", "question_id" => 17 ]);

        Option::create([ "option" => "No", "question_id" => 18 ]);
        Option::create([ "option" => "Yes", "question_id" => 18 ]);

        Option::create([ "option" => "No", "question_id" => 19 ]);
        Option::create([ "option" => "Yes", "question_id" => 19 ]);

        Option::create([ "option" => "No", "question_id" => 20 ]);
        Option::create([ "option" => "Yes", "question_id" => 20 ]);
        ///////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////

        /// Options for the questions of the Couples Survey with syrvey_id = 2

        // How do you feel about your current relationship?
        $coupleQ1 = ["Everything is going well. I'm satisfied.", "Slippery Slope.", "I found the one!", "I'm happy.", "Neutral."];

        foreach ($coupleQ1 as $option){
            Option::create([
                "question_id" => 21,
                "option" => $option,
            ]);
        }


        // Select the choices that describe your partner:
        $coupleQ2Q3 = ["Thoughtful" , "Compassionate" , "Supportive" , "Understanding" , "Patient" , "Dishonest" , "Poor communication skills" , "Un,empathetic" , "Selfish" , "Poor temper control" , "Unreliable" , "Has good sense of humor", "Close-minded" , "Impatient" , "Controlling"];
        foreach ($coupleQ2Q3 as $option){
            Option::create([
                "question_id" => 22,
                "option" => $option,
            ]);
        }
        
        // Select the choices that describe yourself: 
        foreach ($coupleQ2Q3 as $option){
            Option::create([
                "question_id" => 23,
                "option" => $option,
            ]);
        }

        // Select the qualities that are not missing in your current relationship:
        $coupleQ4 = ["Communication (Healthy conflict resolution included)", "Trust and Commitment", "Respect", "Support", "Shared Values (Alignment on important issues)", "Intimacy", "Independence", "I will pass on this one..."];
        foreach ($coupleQ4 as $option) {
            Option::create([
                "question_id" => 24,
                "option" => $option,
            ]);
        }

        // yes or no questions 5-6-7
        $coupleQ5Q6Q7 = ["No", "Yes"];

        foreach($coupleQ5Q6Q7 as $option){
            Option::create([
                "question_id" => 25,
                "option" => $option,
            ]);
        }

        foreach($coupleQ5Q6Q7 as $option){
            Option::create([
                "question_id" => 26,
                "option" => $option,
            ]);
        }

        foreach($coupleQ5Q6Q7 as $option){
            Option::create([
                "question_id" => 27,
                "option" => $option,
            ]);
        }

        // Select the type of activities/outings that you enjoy doing with your partner:
        $coupleQ8 = ["Outdoor and Nature Activities", "Social and Entertainment (Shopping, Dining, Parties, Bars ...)", "Sports or any physical activity", "Relaxation and Self-care (Yoga, spa ...)", "Spiritual activities (Meditation, prayers ...)", "Cultural and Educational (Museums, Historical sites ...)", "Entertainment (Movies, Amusement parks ...)"];

        foreach($coupleQ8 as $option){
            Option::create([
                "question_id" => 28,
                "option" => $option,
            ]);
        }

        // What is one thing, or multiple things, that you struggle with in your relationship? (If none then type in "n/a")
        Option::create([
            "question_id" => 29,
            "option" => "N/A",
        ]);

    }
}
