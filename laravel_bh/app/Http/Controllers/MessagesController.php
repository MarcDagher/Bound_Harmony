<?php

namespace App\Http\Controllers;

use App\Models\AiResponse;
use App\Models\Connection;
use App\Models\UserPrompt;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use OpenAI\Laravel\Facades\OpenAI;


class MessagesController extends Controller
{
    // helper method 
    public function search_for_partner($user){
        // search for user's partner using their connection's relation
        $partner_as_requester = Connection::where(['status' => 'accepted', "responder" => $user -> id]) 
                                -> with("requester_user") -> get('requester') -> first();

        $partner_as_responder = Connection::where(['status' => 'accepted', "requester" => $user -> id]) 
                                -> with("responder_user") -> get('responder') -> first();

        // check if user's partner completed couple's survey
        // user is the requester
        if ($partner_as_requester) {
            return $partner_as_requester['requester_user'];

        // user is the responder
        } else if ($partner_as_responder) {
            return $partner_as_responder['responder_user'];
        }
    }

    public function get_conversation() {
        $user = Auth::user();
        // fetch user_prompts + ai_responses 
        $messages = AiResponse::where('user_prompt_id', $user->id) -> get();

        if (count($messages) > 0){
            $ordered_conversation = [];
            foreach ($messages as $message){
                $ordered_conversation[] = [
                    // user_prompt_in_ai_responses is in AiResponse model realtions
                    "user_prompt" => $message -> user_prompt_in_ai_responses -> prompt,
                    "user_prompt_date" => $message -> user_prompt_in_ai_responses -> created_at,
                    "ai_response" => $message -> response,
                    "ai_response_date" => $message -> created_at
                ];
            }

            return response() -> json([
                "status" => "success",
                "conversation" => $ordered_conversation
            ]);

        } else {
            return response() -> json([
                "status" => "rejected",
                "message" => "Empty conversation"
            ]);
        }
    }

    // Save user prompts, then send request to OpenAi.
    // Receive response from OpenAi
    // Return ai_response to the user
    public function save_user_prompt (Request $request) {
        // save prompt in user_prompts 
        
        $request -> validate(["prompt" => "required|string"]);
        $token = Auth::user();

        try {

            $prompt = UserPrompt::create([
                "user_id" => $token -> id,
                "prompt" => $request -> prompt
            ]);

            //// send_user_prompt_to_ai(){} return the response

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

    public function send_user_prompt_to_ai () {
 
        $result = OpenAI::chat()->create([
            'model' => 'gpt-3.5-turbo',
            'messages' => [
                ["role"=> "system",
                "content" => "You are a dog."], 

                ["role"=> "user",
                "content" => "Tell me how was your day?"],

            ],
            'max_tokens' => 4000,
            
        ]);
        
        return response()->json([
            'status' => 'success',
            'openai' => $result,
        ]);
        
    }

}