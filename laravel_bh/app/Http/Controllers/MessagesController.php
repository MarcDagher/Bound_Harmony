<?php

namespace App\Http\Controllers;

use App\Models\UserPrompt;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;


class MessagesController extends Controller
{

    public function get_conversation() {
        $user = Auth::user();
        // fetch messages from ai_responses
    }


    public function save_user_prompt (Request $request) {
        // save prompt in user_prompts 
        
        $request -> validate(["prompt" => "required|string"]);
        $token = Auth::user();

        try {
            $prompt = UserPrompt::create([
                "user_id" => $token -> id,
                "prompt" => $request -> prompt
            ]);
    
            return response() -> json([
                "status" => "success",
                "message" => "Awaiting response",
                "user_prompt" => $prompt
            ]);        
        } catch (\Exception $e) {
            return response() -> json([
                "status" => "failed",
                "message" => $e
            ]); 
        }           
    }

    public function handle_response () {
        // Send user's prompt to openAI 
        // Get openAI's response
    }
}
