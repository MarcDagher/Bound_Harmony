<?php

namespace App\Http\Controllers;

use App\Models\AiResponse;
use App\Models\Connection;
use App\Models\SurveyResponse;
use App\Models\User;
use App\Models\UserPrompt;
use Illuminate\Http\Request;

class AdminController extends Controller
{

    public function delete_user(Request $request){
        $request -> validate([
            'email' => 'required|email'
        ]);

        $user = User::where('email', $request -> email) -> first();
        if($user){

            $user -> delete();

            return response() -> json([
                'status' => 'success',
                'message' => "user deleted successfully",
                'user' => $user
            ]);

        } else {
            return response() -> json([
                'status' => 'rejected',
                'message' => "user doesn't exist"
            ]);
        }
    }

    public function restore_deleted_user(Request $request){
        $request -> validate([
            'email' => 'required|email'
        ]);

        $user = User::withTrashed() -> where('email', $request -> email) -> first();
        if($user){

            $user -> restore();

            return response() -> json([
                'status' => 'success',
                'message' => "user restored successfully",
                'user' => $user
            ]);

        } else {
            return response() -> json([
                'status' => 'rejected',
                'message' => "user doesn't exist"
            ]);
        }
    }

    // query answer where: find one question. That will count as a survey completed 
    public function number_of_completed_surveys (Request $request){

        $request -> validate([
            'type' => 'required|string|in:couple,personal,all'
        ]);

        $number_of_users = User::all();
        
        try {
            if ($request -> type == "couple"){
            $couples_survey_responses = SurveyResponse::where(["survey_id" =>  2, "question_id" => 21]) -> get();
            $number_of_couples = Connection::where("status", "accepted") -> orWhere("status", "disconnected") -> get();
            return response() -> json([
                "status" => "success",
                "number of users" => count($number_of_users),
                "accepted-disconnected connections" => count($number_of_couples),
                "Couple Survey Responses" => count($couples_survey_responses)
            ]);

        } else if ($request -> type == "personal"){

            $personal_survey_responses = SurveyResponse::where(["survey_id" =>  1, "question_id" => 1]) -> get();
            return response() -> json([
                "status" => "success",
                "number of users" => count($number_of_users),
                "Personal Survey Responses" => count($personal_survey_responses)
            ]);

        } else if ($request -> type == "all"){

            $number_of_responses = SurveyResponse::where("question_id", 1) -> orWhere("question_id", 21) -> get();
            return response() -> json([
                "status" => "success",
                "number of users" => count($number_of_users),
                "Couple Survey Responses" => count($number_of_responses)
            ]);

        }} catch (\Throwable $th) {
             return response() -> json([
                "status" => "failed",
                "message" => "something went wrong",
                "error" => $th
             ]);
        }
    }

    public function most_common_response(){
        $responses = SurveyResponse::with('question', 'option') -> get(['question_id', 'option_id']);
        $divided_responses = [];

        try {
        foreach($responses as $response){
            $option = $response['option']['option'];
            $question = $response['question']['question'];

            if (in_array($question, array_keys($divided_responses))){

                array_push($divided_responses[$question], $option);

            } else {
                $divided_responses[$question] = [$option];
            }
        }
        
        return response() -> json([
            'status' => 'success',
            'divided responses' => $divided_responses
            
        ]);} catch (\Throwable $th){
            return response() -> json([
                'status' => 'failed',
                'error' => $th
            ]);
        }
    }
}
