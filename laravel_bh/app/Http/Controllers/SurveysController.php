<?php

namespace App\Http\Controllers;

use App\Models\Option;
use App\Models\Question;
use Illuminate\Http\Request;

class SurveysController extends Controller
{
    
    public function get_survey (Request $request) {
        // query questions and options of the survey

        $request -> validate(["survey_id" => "required|integer|in:1,2"]);

        $response_array = [];
        $questions = Question::where('survey_id', $request -> survey_id) -> get();
        if ($questions){
            foreach($questions as $question){
                $response_array[] = [
                    "question" => [ "question" => $question -> question, "question_id" => $question -> id],
                    "options" => Option::where('question_id', $question->id) ->select('id', 'question_id', 'option') -> get()
                ];
            }
    
            return response() -> json([
                "status" => "success",
                "survey" => $response_array
            ]);

        } else {
            return response() -> json([
                "status" => "failed",
                "message" => "error loading survey"
            ]);
        }
    }

    public function send_responses () {
        // send user's responses
        // array of objects {user_id, question_id, response}
        
    }
}
