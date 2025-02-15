<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\File;

class ProfileController extends Controller
{
    
    public function change_username(Request $request){

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

    public function change_location(Request $request){

        $request -> validate([
            "location" => "required|string|max:100"
        ]);

        $user = Auth::user();
        $user_info = User::find($user -> id);
        
        if (!$user_info){
            return response() -> json([
                "status" => "failed",
                "message" => "User not found"
            ], 403);
        } else {
            $user_info -> location = $request -> location;
            $user_info -> save();
            return response() -> json([
                "status" => "success",
                "message" => "New location saved"
            ]);
        }
    }


    public function edit_image(Request $request){
        $token = Auth::user();
        $request -> validate([
            "profile_pic_url" => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048'
        ]);
        
        if ($request->hasFile('profile_pic_url')){
            $user = User::find($token->id);
            // image path is in storage/app/public/images
            $image_path = $request->file('profile_pic_url')->store('images', 'public');
            $user->profile_pic_url = $image_path;
            $user->save();
            
            return response()->json([
                "status" => "success",
                "message" => "Image changed successfully",
                "image_path" => $image_path

            ]);
        } else {
            return response()->json([
                "status" => "failed",
                "message" => "please insert an image"
            ]);
        }
    }

    public function get_profile_photo(){
            $user = Auth::user();
            if ($user -> profile_pic_url == "no image") {
                return response() -> json([
                    "status" => "rejected",
                    "message" => "no image"
                ]);
            } else {
                $image_path = $user->profile_pic_url;
                return response() -> json([
                    "status" => "success",
                    "img_path" => $image_path,
                ]);
            }
    }

    public function remove_profile_photo(){
        $user = Auth::user();

        $user_in_db = User::find($user -> id);
        if($user_in_db){
            $user_in_db -> profile_pic_url = "no image";
            // $user_in_db -> save();
            return response() -> json([
                "status" => "success",
                "users_profile_pic" => $user_in_db -> profile_pic_url 
            ]);
        }
    }
}
