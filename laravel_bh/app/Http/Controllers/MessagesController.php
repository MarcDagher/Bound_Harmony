<?php

namespace App\Http\Controllers;

use App\Models\AiResponse;
use App\Models\Connection;
use App\Models\SurveyResponse;
use App\Models\UserPrompt;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use OpenAI\Laravel\Facades\OpenAI;


class MessagesController extends Controller
{
    protected $description = "You are a relationship expert, love expert, personal development/life guide. Your ideas will be about my romantic relationship, my love life.";
    protected $purpose = "You will answer my questions, help me figure out what I want in life and in a romantic relationship and how to make my romantic relationship with my partner better. Any time you notice questions that are not related to my romantic relationship or self-developent or relationships in general, you will redirect the conversation to the topic of me, my romantic relationship, and both of their development. ";
    protected $tone_of_speech = "You will be thoughtful, understanding, friendly, empathetic, supportive, encouraging and take emotions into consideration. ";
    protected $end_statements = "Occasionally, You will end with necessary questions that will be thought provoking and of the types/context I mentioned earlier, note that the question is not to be answered back, its only to leave me with ideas that will help. You will also occasionally suggest solutions";
    protected $removals = "make your answers concise and not too long. state your answers directly and DO NOT return any text or explanation or notes before or after your response. be human and don't be robotic. your answers should be in texts not bullet points and most importantly give one idea per response";


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
        // im preparing the conditions to know which prompt to give based on what data I have
        $user = Auth::user(); // this will be a parameter
        $partner = $this -> search_for_partner($user);

        // if user has a partner (is connected)
        if ($user -> connection_status == "true") {
            
            // if partner answered couple's survey
            if ($partner -> couple_survey_status == "complete"){
                $partner_responses = SurveyResponse::where(['user_id' => $partner -> id, "partner_id" =>  $user -> id]) 
                -> with('question', 'option') -> get();
            } else {
                echo "your partner has no responses\n";
            }

            // if the user answered couple's survey
            if ($user -> couple_survey_status == "complete"){
                $user_responses = SurveyResponse::where(['user_id' => $user -> id, "partner_id" => $partner -> id]) 
                -> with('question', 'option') -> get();
            } else {
                echo "you have no responses\n";
            }

            /// if only user answered: give a prompt with context of user's answers
            /// if only partner answered: give a prompt with context of partner's answers
            /// if both answered: give a prompt with context of both partners' answers

        } else {

            // If user has no relationship (connection_status == "false")
            //  prompt includes the user's personal survey answers and conditional request
            $my_interests = "I am currently not in a reltionship and these are my interests:\n";

            // get user's interests (questions + answer)
            $personal_survey_responses = SurveyResponse::where(['user_id' => $user -> id]) -> with('question', 'option') -> get();
            foreach ($personal_survey_responses as $personal_response){
                $my_interests .= $personal_response['question']['question'] . ": " . $personal_response['option']['option'] . "\n";
            }

            $my_interests .= "Take all of my interests into consideration when sending your response.";
            $system_config = $this -> description . $this -> purpose . $my_interests . $this -> tone_of_speech . $this -> removals ;
            $result = OpenAI::chat()->create([
                'model' => 'gpt-4',
                'messages' => [
                    ["role"=> "system_config", "content" => $system_config], 
                    ["role"=> "user", "content" => "Hello, how can I start finding a girlfriend?"],
                ],
                'max_tokens' => 2500, 
            ]);
            return response()->json([
                'status' => 'success',
                'openai' => $result,
            ]);
        }

        // $result = OpenAI::chat()->create([
        //     'model' => 'gpt-3.5-turbo',
        //     'messages' => [
        //         ["role"=> "system",
        //         "content" => "You are a dog."], 

        //         ["role"=> "user",
        //         "content" => "Tell me how was your day?"],

        //     ],
        //     'max_tokens' => 4000,
            
        // ]);
        
        // return response()->json([
        //     'status' => 'success',
        //     'openai' => $result,
        // ]);
        
    }

}