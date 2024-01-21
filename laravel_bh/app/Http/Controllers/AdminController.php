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
}
