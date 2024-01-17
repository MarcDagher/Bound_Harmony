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

    // helper method
    public function get_personal_survey_responses($user){
        $survey_responses = SurveyResponse::where(['user_id' => $user -> id])
                                        -> whereHas('question', function ($query) { $query 
                                        -> where('survey_id', 1);}) -> with('question', 'option') -> get();
        return $survey_responses;
    }

    // helper method
    public function summary_of_couple_survey_answers($user_responses){
            $summary_of_responses = ""; 
            $previous_question = "";
        foreach($user_responses as $response){

            $current_question = $response['question']['question'];
            $current_option = $response['option']['option'];

            if ($previous_question == $current_question){
                $summary_of_responses .= ", " . $current_option;
            } else {
                $summary_of_responses .= "\n" . $current_question . ": " . $current_option;
                $previous_question = $current_question;
            }
        } 
        return $summary_of_responses;
    }

    // helper method
    public function send_to_open_ai_api($system_config, $user_prompt){
        
        $result = OpenAI::chat()->create([
            'model' => 'gpt-4',
            'messages' => [
                ["role"=> "system", "content" => $system_config], 
                ["role"=> "user", "content" => $user_prompt],
            ],
            'max_tokens' => 3000, 
        ]);
        return $result;
    }

    // main helper function: handling couple's conditions and preparing prompt
    public function send_user_prompt_to_ai ($user, $user_prompt) {
        // im preparing the conditions to know which prompt to give based on what data I have
        $partner = $this -> search_for_partner($user);

        // if user has a partner (is connected)
        if ($user -> connection_status == "true") {
            
            // if partner answered couple's survey and user answered couple survey
            if ($partner -> couple_survey_status == "complete" && $user ->  couple_survey_status == "complete"){

                $user_couple_responses = SurveyResponse::where(['user_id' => $user -> id, "partner_id" => $partner -> id]) 
                                                    -> whereHas('question', function ($query){$query -> where ('survey_id', 2);}) 
                                                    -> with('question', 'option') -> get();

                $partner_couple_responses = SurveyResponse::where(['user_id' => $partner -> id, "partner_id" =>  $user -> id]) 
                                                    -> whereHas('question', function ($query){$query -> where ('survey_id', 2);}) 
                                                    -> with('question', 'option') -> get();

                $user_summary_of_responses = $this -> summary_of_couple_survey_answers($user_couple_responses); // string
                $partners_summary_of_responses = $this -> summary_of_couple_survey_answers($partner_couple_responses); // string


                $our_interests = "This is my opinion on my current relationship: " . $user_summary_of_responses;
                $our_interests .= " and this my partner's opinion of our current relationship: ". $partners_summary_of_responses;
                $our_interests .= "Take our opinions of eachother into consideration, in order to guide us and support us more accurately. If I ever mention finding another partner or lover, you will strictly not support me. You will tell me to make things work with my partner and in only the hopeless cases, you will tell me to slightly consider searching for someone else. ";
                $system_config = $this -> description . $this -> purpose . $our_interests . $this -> tone_of_speech . $this -> removals;
                
                return $this -> send_to_open_ai_api($system_config, $user_prompt);

            } else  // if partner did not answer couple's survey and user answered couple survey
                if ($partner -> couple_survey_status == "incomplete" && $user ->  couple_survey_status == "complete" ) {
                    $user_couple_responses = SurveyResponse::where(['user_id' => $user -> id, "partner_id" => $partner -> id]) 
                                                    -> whereHas('question', function ($query){$query -> where ('survey_id', 2);}) 
                                                    -> with('question', 'option') -> get();

                    $user_summary_of_responses = $this -> summary_of_couple_survey_answers($user_couple_responses); // string

                    $our_interests = "This is my opinion on my current relationship: " . $user_summary_of_responses;
                    
                    $our_interests .= "Take my opinions of the relationship into consideration, in order to guide us and support us more accurately. If I ever mention finding another partner or lover, you will strictly not support me. You will tell me to make things work with my partner and in only the hopeless cases, you will tell me to slightly consider searching for someone else. Make sure to mention at the end of your response, that It would be advisable to have my partner fill the couple's survey to give you more insight.";
                    $system_config = $this -> description . $this -> purpose . $our_interests . $this -> tone_of_speech . $this -> removals;
                    
                    return $this -> send_to_open_ai_api($system_config, $user_prompt);
                    

            } else // if partner answered couple's survey and user did not answered couple survey
                if ($partner -> couple_survey_status == "complete" && $user ->  couple_survey_status == "incomplete"){

                    $partner_couple_responses = SurveyResponse::where(['user_id' => $partner -> id, "partner_id" =>  $user -> id]) 
                                                    -> whereHas('question', function ($query){$query -> where ('survey_id', 2);}) 
                                                    -> with('question', 'option') -> get();

                    $partners_summary_of_responses = $this -> summary_of_couple_survey_answers($partner_couple_responses); // string
                    
                    $our_interests = " This my partner's opinion of our current relationship: ". $partners_summary_of_responses;
                    $our_interests .= "Take our opinions of eachother into consideration, in order to guide us and support us more accurately. If I ever mention finding another partner or lover, you will strictly not support me. You will tell me to make things work with my partner and in only the hopeless cases, you will tell me to slightly consider searching for someone else. Make sure to mention at the end of your response, that It would be advisable for me to fill the couple's survey to give you more insight.";
                    $system_config = $this -> description . $this -> purpose . $our_interests . $this -> tone_of_speech . $this -> removals;
                    
                    return $this -> send_to_open_ai_api($system_config, $user_prompt);
                    

            } else // if none of them answered couples survey
                if ($partner -> couple_survey_status == "incomplete" && $user ->  couple_survey_status == "incomplete"){
                    $our_interests = "These are my interests:\n";

                    // get user's interests (questions + answer)
                    $users_personal_survey_responses = $this -> get_personal_survey_responses($user, 1);
                    $partners_personal_survey_responses = $this -> get_personal_survey_responses($partner, 1);

                    foreach ($users_personal_survey_responses as $personal_response){
                        $our_interests .= $personal_response['question']['question'] . ": " . $personal_response['option']['option'] . "\n";
                    }

                    $our_interests .= " Now, these are my partner's interests";

                    foreach ($partners_personal_survey_responses as $personal_response){
                        $our_interests .= $personal_response['question']['question'] . ": " . $personal_response['option']['option'] . "\n";
                    }

                    $our_interests .= "We are in a romantic relationship, Take all of our interests into consideration and use them occasionally when sending your response. If I ever mention finding another partner or lover, you will strictly not support me. You will tell me to make things work with my partner and in only the hopeless cases, you will tell me to slightly consider searching for someone else. Make sure to mention at the end of your response, that It would be advisable for both me and my partner to fill the couple's survey to give you more insight.";
                    $system_config = $this -> description . $this -> purpose . $our_interests . $this -> tone_of_speech . $this -> removals ;
                    
                    return $this -> send_to_open_ai_api($system_config, $user_prompt);

            } 

        } else {
            // If user has no relationship (connection_status == "false")
            //  prompt includes the user's personal survey answers and conditional request
            $my_interests = "I am currently not in a reltionship and these are my interests:\n";

            // get user's interests (questions + answer)
            $personal_survey_responses = $this -> get_personal_survey_responses($user, 1);

            foreach ($personal_survey_responses as $personal_response){
                $my_interests .= $personal_response['question']['question'] . ": " . $personal_response['option']['option'] . "\n";
            }

            $my_interests .= "Take all of my interests into consideration and use them occasionally when sending your response.";
            $system_config = $this -> description . $this -> purpose . $my_interests . $this -> tone_of_speech . $this -> removals ;
            
            return $this -> send_to_open_ai_api($system_config, $user_prompt);
        }

        
    }


    // Save user prompts, then send request to OpenAi.
    // Receive response from OpenAi
    // Return ai_response to the user
    public function save_user_prompt (Request $request) {
        // save prompt in user_prompts 
        
        $request -> validate(["prompt" => "required|string"]);
        $user = Auth::user();

        try {

            $prompt = UserPrompt::create([
                "user_id" => $user -> id,
                "prompt" => $request -> prompt
            ]);

            //// send_user_prompt_to_ai(){} return the response
            $openAi_response = $this -> send_user_prompt_to_ai($user, $request -> prompt);

            AiResponse::create([
                "user_prompt_id" => $prompt -> id,
                "response" => $openAi_response -> choices[0] -> message -> content,
                "user_id" => $user -> id 
            ]);

            return response() -> json([
                "status" => "success",
                "ai_response" => $openAi_response -> choices[0] -> message -> content
            ]);        

        } catch (\Exception $e) {
            echo $e;
            return response() -> json([
                "status" => "failed",
                "message" => $e
            ]); 
        }           
    }

    public function get_conversation() {
        $user = Auth::user();
        // fetch user_prompts + ai_responses 
        $messages = AiResponse::where('user_id', $user->id) -> with('user_prompt') -> get();
        
        if (count($messages) > 0){
            $ordered_conversation = [];
            foreach ($messages as $message){
                $ordered_conversation[] = [
                    // user_prompt_in_ai_responses is in AiResponse model realtions
                    "user_prompt" => $message['user_prompt']['prompt'],
                    "user_prompt_date" => $message['user_prompt']['created_at'],
                    "ai_response" => $message["response"],
                    "ai_response_date" => $message["created_at"]
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
}
