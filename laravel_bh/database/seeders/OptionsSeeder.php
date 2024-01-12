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

        /// Options for the questions of the Personal Survey with survey_id = 1
        ///

        $personalQ1tillQ20 = ["No", "Yes"];

        foreach($personalQ1tillQ20 as $option){
            Option::create([
                "question_id" => 1,
                "option" => $option,
            ]);
        }
        foreach($personalQ1tillQ20 as $option){
            Option::create([
                "question_id" => 2,
                "option" => $option,
            ]);
        }
        foreach($personalQ1tillQ20 as $option){
            Option::create([
                "question_id" => 3,
                "option" => $option,
            ]);
        }
        foreach($personalQ1tillQ20 as $option){
            Option::create([
                "question_id" => 4,
                "option" => $option,
            ]);
        }
        foreach($personalQ1tillQ20 as $option){
            Option::create([
                "question_id" => 5,
                "option" => $option,
            ]);
        }
        foreach($personalQ1tillQ20 as $option){
            Option::create([
                "question_id" => 6,
                "option" => $option,
            ]);
        }
        foreach($personalQ1tillQ20 as $option){
            Option::create([
                "question_id" => 7,
                "option" => $option,
            ]);
        }
        foreach($personalQ1tillQ20 as $option){
            Option::create([
                "question_id" => 8,
                "option" => $option,
            ]);
        }
        foreach($personalQ1tillQ20 as $option){
            Option::create([
                "question_id" => 9,
                "option" => $option,
            ]);
        }
        foreach($personalQ1tillQ20 as $option){
            Option::create([
                "question_id" => 10,
                "option" => $option,
            ]);
        }
        foreach($personalQ1tillQ20 as $option){
            Option::create([
                "question_id" => 11,
                "option" => $option,
            ]);
        }
        foreach($personalQ1tillQ20 as $option){
            Option::create([
                "question_id" => 12,
                "option" => $option,
            ]);
        }
        foreach($personalQ1tillQ20 as $option){
            Option::create([
                "question_id" => 13,
                "option" => $option,
            ]);
        }
        foreach($personalQ1tillQ20 as $option){
            Option::create([
                "question_id" => 14,
                "option" => $option,
            ]);
        }
        foreach($personalQ1tillQ20 as $option){
            Option::create([
                "question_id" => 15,
                "option" => $option,
            ]);
        }
        foreach($personalQ1tillQ20 as $option){
            Option::create([
                "question_id" => 16,
                "option" => $option,
            ]);
        }
        foreach($personalQ1tillQ20 as $option){
            Option::create([
                "question_id" => 17,
                "option" => $option,
            ]);
        }
        foreach($personalQ1tillQ20 as $option){
            Option::create([
                "question_id" => 18,
                "option" => $option,
            ]);
        }
        foreach($personalQ1tillQ20 as $option){
            Option::create([
                "question_id" => 19,
                "option" => $option,
            ]);
        }
        foreach($personalQ1tillQ20 as $option){
            Option::create([
                "question_id" => 20,
                "option" => $option,
            ]);
        }
        ///////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////

        /// Options for the questions of the Couples Survey with syrvey_id = 2

        // How do you feel about your current relationship?
        $coupleQ1 = ["I'm satisfied", "Slippery Slope", "I found the one!", "I'm happy", "Neutral", "I'm not happy"];

        foreach ($coupleQ1 as $option){
            Option::create([
                "question_id" => 21,
                "option" => $option,
            ]);
        }


        // Select the choices that describe your partner:
        $coupleQ2Q3 = ["Thoughtful" , "Compassionate" , "Supportive" , "Understanding" , "Patient" , "Dishonest" , "Poor communication skills" , "Unempathetic" , "Selfish" , "Poor temper control" , "Unreliable" , "Has good sense of humor", "Close-minded" , "Impatient" , "Controlling"];
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
        $coupleQ5Q6 = ["No", "Yes"];

        foreach($coupleQ5Q6 as $option){
            Option::create([
                "question_id" => 25,
                "option" => $option,
            ]);
        }

        foreach($coupleQ5Q6 as $option){
            Option::create([
                "question_id" => 26,
                "option" => $option,
            ]);
        }

        $coupleQ7 = ["Every day", "A few times a week", "Every once in a while, but not every week", "We are very busy and don't spend quality time together"];

        foreach($coupleQ7 as $option){
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

        // What is one thing, or multiple things, that you struggle with in your relationship? (If none then type in "n/a") => qustion 19 is a text input its doesnt have options 
        

    }
}
