<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\File;

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

    public function edit_image(Request $request){
        $token = Auth::user();
        $request -> validate([
            "profile_pic_url" => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048'
        ]);

        if ($request->hasFile('profile_pic_url')){
            $user = User::find($token->id);
            // image path is in storage/app/public/images
            $imagePath = $request->file('profile_pic_url')->store('images', 'public');
            $user->profile_pic_url = $imagePath;
            $user->save();
            //Use the File class to retrieve image file
            $imageFile = File::get(storage_path('app/public/'.$imagePath));
            return response()->json([
                "status" => "success",
                "message" => "Image changed successfully",
                "profile_pic_url" => base64_encode($imageFile)
                //   NOTE: convert to base64 and return image for the frontend
            ]);
        } else {
            return response()->json([
                "status" => "failed",
                "message" => "please insert an image"
            ]);
        }
    }
}
