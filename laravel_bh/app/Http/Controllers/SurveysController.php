<?php

namespace App\Http\Controllers;

use App\Models\Option;
use App\Models\Question;
use App\Models\SurveyResponse;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

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

    public function save_responses (Request $request) {
        // save user's responses 

        // expecting an array of json objects - *. is a wildcard that validates the values of each key
        // array of objects {user_id, question_id, response}
        $request -> validate([ 
            "*.question_id" => "required|integer",
             "*.response" => "required|string"
             ]);
        
        // extracts the json payload from the incoming http request
        //  $request->json() will return an instance of Illuminate\Http\JsonResponse
        // all() will convert the json into accessible arrays 
        $jsonData = $request->json()->all();

        $user = Auth::user();

        foreach($jsonData as $data){
            $question_id = $data['question_id'];
            $response = $data['response'];
    
            $response_validation = Option::where(["question_id" => $question_id, "option" => $response]) -> get();
            if (isset($response_validation[0])){
                SurveyResponse::create([
                    "user_id" => $user->id,
                    "question_id" => $question_id,
                    "option_id" => $response_validation[0] -> id
                ]);

            } else {
                return response() -> json([
                    "status" => "failed",
                    "message" => "Invalid response"
                ]);
            }

        }

        return response() -> json([
            "status" => "success",
            "message" => "Your responses have been saved"
        ]);
    }
}