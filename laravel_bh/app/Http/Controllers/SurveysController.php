<?php

namespace App\Http\Controllers;

use App\Models\Connection;
use App\Models\Option;
use App\Models\Question;
use App\Models\SurveyResponse;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class SurveysController extends Controller
{
    // helper method 
    public function search_for_partner($user){
        // search for user's partner using their connection's relation
        $partner_as_requester = Connection::where(['status' => 'accepted', "responder" => $user -> id]) 
                                -> with("requester_user") -> get('requester') -> first();

        $partner_as_responder = Connection::where(['status' => 'accepted', "requester" => $user -> id]) 
                                -> with("responder_user") -> get('responder') -> first();

        // check if user's partner completed couple's survey
        // user is the requester
        if ($partner_as_requester) {
            return $partner_as_requester['requester_user'];

        // user is the responder
        } else if ($partner_as_responder) {
            return $partner_as_responder['responder_user'];
        }
    }
    
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
        $survey_id = Question::find($jsonData[0]['question_id']) -> survey_id; // find survey_id to add my partner's id if survey is for couples
    
        foreach($jsonData as $data){
            $question_id = $data['question_id'];
            $response = $data['response'];            

            /// If a question has a type text, it doesn't have options. Add response to the text column in survey_responses
            if (Question::find($data['question_id']) -> question_type == "text"){

                // if couple's survey find my partner and add id to my response
                if ($survey_id == 2){
                    $partner = $this -> search_for_partner($user);
                    SurveyResponse::create([
                        "user_id" => $user->id,
                        "question_id" => $question_id,
                        "option_id" => 100,
                        "partner_id" => $partner -> id,
                        "text_input" => $response
                    ]);
                } elseif ($survey_id == 1) {
                    SurveyResponse::create([
                        "user_id" => $user->id,
                        "question_id" => $question_id,
                        "option_id" => 100,
                        "text_input" => $response
                    ]);
                }
                
            } else {
                // check if the option exists in options table
                $response_validation = Option::where(["question_id" => $question_id, "option" => $response]) -> get();
                
                if (isset($response_validation[0])){
                    // if couple's survey find my partner and add id to my response
                    if ($survey_id == 2){
                        $partner = $this -> search_for_partner($user);
                        SurveyResponse::create([
                            "user_id" => $user->id,
                            "question_id" => $question_id,
                            "option_id" => $response_validation[0] -> id,
                            "partner_id" => $partner -> id
                        ]);    
                    } elseif ($survey_id == 1) {
                        SurveyResponse::create([
                            "user_id" => $user->id,
                            "question_id" => $question_id,
                            "option_id" => $response_validation[0] -> id
                        ]);
                    }
    
                } else {
                    return response() -> json([
                        "status" => "failed",
                        "message" => "Invalid response"
                    ]);
                }
            }
            
        }

        // check which survey we're answering and change the user's survey status to complete
        $user_in_model = User::find($user -> id);
        if ( $survey_id == 2) {
            $user_in_model -> couple_survey_status = "complete";
            $user_in_model -> save();
        } else if ($survey_id == 1) {
            $user_in_model -> personal_survey_status = "complete";
            $user_in_model -> save();
        }

        return response() -> json([
            "status" => "success",
            "message" => "Your responses have been saved",
            "updated user" => $user_in_model
        ]); 
    }

    
}