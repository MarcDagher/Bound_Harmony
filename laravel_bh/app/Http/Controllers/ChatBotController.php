<?php

namespace App\Http\Controllers;

use App\Models\UserPrompt;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;


class ChatBotController extends Controller
{
    public function save_user_prompt (Request $request) {
        // save prompt in user_prompts 
        
        $request -> validate(["prompt" => "required|string"]);
        $token = Auth::user();

        try {
            UserPrompt::create([
                "user_id" => $token -> id,
                "prompt" => $request -> prompt
            ]);
    
            return response() -> json([
                "status" => "success",
                "message" => "Awaiting response"
            ]);        
        } catch (\Exception $e) {
            return response() -> json([
                "status" => "failed",
                "message" => $e->getMessage()
            ]); 
        }           
    }

    public function handle_response () {
        // Send user's prompt to openAI 
        // Get openAI's response
    }
}
