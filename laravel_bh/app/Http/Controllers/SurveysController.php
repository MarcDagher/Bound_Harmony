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
    
    // query questions and options of the survey
    public function get_survey (Request $request) {

        $request -> validate(["survey_id" => "required|integer|in:1,2"]);

        $response_array = [];
        $questions = Question::where('survey_id', $request -> survey_id) -> get();
        if ($questions){
            foreach($questions as $question){
                $response_array[] = [
                    "question" => [ "question" => $question -> question, "question_id" => $question -> id, "question_type" => $question -> question_type],
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

    // save user's responses 
    public function save_responses (Request $request) {

        // expecting an array of json objects - *. is a wildcard that validates the values of each key
        // array of objects {"question_id" : id , "response" : response} 
        $request -> validate([ 
            "*.question_id" => "required|integer",
            "*.response" => "required|string"
            ]);
        
        // extracts the json payload from the incoming http request
        //  $request->json() will return an instance of Illuminate\Http\JsonResponse
        // all() will convert the json into accessible arrays 
        $jsonData = $request->json()->all();

        $user = Auth::user();
        
        try {
            foreach($jsonData as $data){
                $question_id = $data['question_id'];
                $response = $data['response'];            
    
                /// If a question has a type text, it doesn't have options. Add it to the text column in survey_responses
                if (Question::find($data['question_id']) -> question_type == "text"){
    
                    SurveyResponse::create([
                        "user_id" => $user->id,
                        "question_id" => $question_id,
                        "option_id" => 100,
                        "text_input" => $response
                    ]);
                    
                } else {
                    // check if the option exists in options table
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
    
            }
        } catch (\Throwable $th) {
            echo "from laravel $th";
        }
        

        return response() -> json([
            "status" => "success",
            "message" => "Your responses have been saved"
        ]); 
    }
}