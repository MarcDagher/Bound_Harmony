<?php

namespace App\Http\Controllers;

use App\Models\AiResponse;
use App\Models\Connection;
use App\Models\SurveyResponse;
use App\Models\User;
use App\Models\UserPrompt;
use Carbon\Carbon;
use DateTime;
use Dotenv\Repository\RepositoryInterface;
use Illuminate\Http\Request;

class AdminController extends Controller
{

    // helper method used in user_connection_surveys_stats()
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
        return [
                "number of connections" => count($array_of_connections),
                "accepted" => $count_of_accepted_connections, 
                "rejected" => $count_of_rejected_connections, 
                "disconnected" => $count_of_disconnected_connections, 
                "pending" => $count_of_pending_connections];
    }


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

     
    public function connection_and_surveys_stats (){
        
        try {
            // $number_of_users = User::all();
            $survey_responses = SurveyResponse::where(["question_id" => 21]) -> orWhere(["question_id" => 1]) -> get();
            $connection_status_stats = $this -> count_of_connection_status_type();

            $couples_survey_responses = [];
            $personal_survey_responses = [];

            foreach($survey_responses as $response){
                if ($response["survey_id"] == 2){
                    array_push($couples_survey_responses, $response);
                } else {
                    array_push($personal_survey_responses, $response);
                }
            }
            
            return response() -> json([
                "status" => "success",
                // "number of users" => count($number_of_users),
                "number of connections" => $connection_status_stats['number of connections'],
                "pending connections" => $connection_status_stats['pending'],
                "accepted connections" => $connection_status_stats['accepted'],
                "disconnected connections" => $connection_status_stats['disconnected'],
                "rejected connections" => $connection_status_stats['rejected'],
                "Couple Survey Responses" => count($couples_survey_responses),
                "Personal Survey Responses" => count($personal_survey_responses),
                "All Survey Responses" => count($survey_responses)
            ]);

        } catch (\Throwable $th) {
             return response() -> json([
                "status" => "failed",
                "message" => "something went wrong",
                "error" => $th
             ]);
        }
    }

    // gets list of all users and increments the respective variable corresponding to each age range
    public function users_age_range(){
        try {
            $users = User::all('birthdate');
            // $list_of_users_age = [];
            $below_18 = 0;
            $between_18_and_24 = 0;
            $between_24_and_35 = 0;
            $above_35 = 0;
            foreach($users as $user){
                $current_year = Carbon::now()->year;
                $user_birth_year = Carbon::parse($user['birthdate'])->year;
                $user_age = $current_year - $user_birth_year;
                // array_push($list_of_users_age, $user_age);
                if ($user_age < 18){$below_18 ++;}
                else if($user_age > 18 && $user_age < 24){$between_18_and_24++;}
                else if($user_age > 24 && $user_age < 35){$between_24_and_35++;}
                else if($user_age > 35){$above_35++;}
            }

            return response() -> json([
                "status" => "success",
                "total users" => count($users),
                "below_18" => $below_18,
                "between_18_and_24" =>  $between_18_and_24,
                "between_24_and_35" => $between_24_and_35,
                "above_35" => $above_35
            ]);

        } catch (\Throwable $th) {
            return response() -> json([
                "status" => "failed",
                "message" => "Something went wrong",
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
}
