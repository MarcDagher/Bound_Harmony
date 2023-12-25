<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ProfileController extends Controller
{
    // query approach used here is called Eloquent ORM (Object-Relational Mapping)
    // get email or user id from token then change he user's username
    //NOTE: STILL NEED TO FIGURE OUT LOCATION. WHAT SUGGESTIONS NEED, WHAT TO GET, HOW TO STORE
    public function update_profile(Request $request){

        $token = Auth::user();
        $request -> validate([
            'username' => 'required|string|max:80'
        ]);

        $user = User::find($token -> id);
        if (!$user){
            return response()->json([
                "status" => "failed",
                "message" => "User not found."
            ]);
        } else {
            $user -> username = $request -> username;
            $user -> save();
    
            return response()->json([
                'status' => 'success',
                'message' => 'Profile updated successfully',
                'user' => $user, // You can include the updated user data in the response if needed
            ]);
        }
    }
}
