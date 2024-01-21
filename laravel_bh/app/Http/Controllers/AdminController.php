<?php

namespace App\Http\Controllers;

use App\Models\Connection;
use App\Models\SurveyResponse;
use App\Models\User;
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
            $connections = Connection::where('requester', $user -> id) -> orWhere('responder', $user -> id) -> get();
            // $survey_responses = SurveyResponse::where('user_id', $user -> id);
            // foreach ($connections as $connection){
            //     // $connection -> delete();
            //     echo $connection;
            // }

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
}
