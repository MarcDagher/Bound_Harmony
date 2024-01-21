<?php

namespace App\Http\Controllers;

use App\Models\AiResponse;
use App\Models\Connection;
use App\Models\SurveyResponse;
use App\Models\User;
use App\Models\UserPrompt;
use Dotenv\Repository\RepositoryInterface;
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
        // get number of users - get number of answered(type)surveys 


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
                "All Survey Responses" => count($number_of_responses)
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
        $most_common_responses =[];

        try {
        // organinzing queried responses in an array    
        foreach($responses as $response){
            $option = $response['option']['option'];
            $question = $response['question']['question'];
            if (in_array($question, array_keys($divided_responses))){
                array_push($divided_responses[$question], $option);
            } else {
                $divided_responses[$question] = [$option];
            }
        }

        // getting most common responses
        foreach($divided_responses as $question => $response){

            // $response_count = ['count' => 0, 'index' => 0];

            // for ($i = 0; $i < count($response); $i ++){
            //     $count = count($response[$i]);
            //     if ($count > $response_count['count']){$response_count['count'] = $count; $response_count['index'] = $i;}
            // }
            // return $response_count;
        }
        
        return response() -> json([
            'status' => 'success',
            'divided responses' => $divided_responses

        ]);} catch (\Throwable $th){
            return response() -> json([
                'status' => 'failed',
                'error' => $th -> getMessage()
            ]);
        }
    }

    public function count_of_connection_status_type(){
        $array_of_connections = Connection::all();
        
        $count_of_accepted_connections = 0;
        $count_of_rejected_connections = 0;
        $count_of_disconnected_connections = 0;
        $count_of_pending_connections = 0;

        foreach ($array_of_connections as $connection) {
            if ($connection['status'] == "accepted"){$count_of_accepted_connections ++;};
            if ($connection['status'] == "rejected"){$count_of_rejected_connections ++;};
            if ($connection['status'] == "disconnected"){$count_of_disconnected_connections ++;};
            if ($connection['status'] == "pending"){$count_of_pending_connections ++;};
        }
        return response() -> json([
            "status" => "success",
            "count of type" => [
                "accepted" => $count_of_accepted_connections, 
                "rejected" => $count_of_rejected_connections, 
                "disconnected" => $count_of_disconnected_connections, 
                "pending" => $count_of_pending_connections]
        ]);
    }

}
