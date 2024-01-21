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
    /// General Stats: Number of filled personal surveys
    public function get_number_of_personal_surveys(){
        
        echo "hello";
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

    // query answer where: user_id - survey_id - question_id because a survey cant be misssing a question. so find one question, that will count as a survey completed 
    public function number_of_completed_surveys (){
        $personal_survey_responses = SurveyResponse::where(["survey_id" =>  1, "question_id" => 1]) -> get();
        $couples_survey_responses = SurveyResponse::where(["survey_id" =>  2, "question_id" => 21]) -> get();
        echo $personal_survey_responses;
    }

}
