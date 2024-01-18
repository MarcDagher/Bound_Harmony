<?php

namespace App\Http\Controllers;

use App\Models\Connection;
use App\Models\SurveyResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class SuggestionsController extends Controller
{

     // helper method 
     public function search_for_connection_and_partner($user){
        // search for user's partner
        $connection_where_partner_is_requester = Connection::where(['status' => 'accepted', "responder" => $user -> id]) -> get() -> first();
        $connection_where_partner_is_responder = Connection::where(['status' => 'accepted', "requester" => $user -> id]) -> get() -> first();

        // user's partner is the requester
        if ($connection_where_partner_is_requester) {
            $connection_id = $connection_where_partner_is_requester['id'];
            $partner_id = $connection_where_partner_is_requester['requester'];
            return ["partner_id" => $partner_id, "connection_id" => $connection_id];

        // user's partner is the responder
        } else if ($connection_where_partner_is_responder) {
            $connection_id = $connection_where_partner_is_responder['id'];
            $partner_id = $connection_where_partner_is_responder['responder'];
            return ["partner_id" => $partner_id, "connection_id" => $connection_id];
        }
    }

    public function get_couple_survey_Q_responses($user_id, $connection_id, $question_id){
        $user_Q_couple_survey_response = SurveyResponse::where(['connection_id' => $connection_id, 'user_id' => $user_id, "question_id" => $question_id]) 
                                        -> get('option_id');
        return $user_Q_couple_survey_response;
    }

    
    public function get_suggestions(){
        $user = Auth::user();
        $couples_combined_interests = []; // answers of Q28 + user's + partner's(if Q25 is yes)

        //get the connection id and partner id of this user's relationship
        $connection_and_partner_ids = $this -> search_for_connection_and_partner($user);
        $connection_id = $connection_and_partner_ids['connection_id'];
        $partner_id = $connection_and_partner_ids['partner_id'];

        //get Couple Survey Responses of Q28 (Q = question) of the user and the partner 
        $user_Q28_couple_survey_response = $this -> get_couple_survey_Q_responses($user -> id, $connection_id, 28);
        $partner_Q28_couple_survey_response = $this -> get_couple_survey_Q_responses($partner_id, $connection_id, 28);

        // activities which the user enjoys with their partner 
        foreach ($user_Q28_couple_survey_response as $option) {
            switch ($option){
                case ($option["option_id"] == "93") : array_push($couples_combined_interests, "outdoor", "nature"); break;
                case ($option["option_id"] == "94") : array_push($couples_combined_interests, "social", "entertainment"); break;
                case ($option["option_id"] == "95") : array_push($couples_combined_interests, "sports", "physical activity"); break;
                case ($option["option_id"] == "96") : array_push($couples_combined_interests, "yoga", "spa"); break;
                case ($option["option_id"] == "97") : array_push($couples_combined_interests, "meditation"); break;
                case ($option["option_id"] == "98") : array_push($couples_combined_interests, "museum", "history"); break;
                case ($option["option_id"] == "99") : array_push($couples_combined_interests, "movies", "amusement"); break;
            }
        }

        // activities which the partner enjoys with the user 
        foreach ($partner_Q28_couple_survey_response as $option) {
            switch ($option){
                case ($option["option_id"] == "93") : array_push($couples_combined_interests, "outdoor", "nature"); break;
                case ($option["option_id"] == "94") : array_push($couples_combined_interests, "social", "entertainment"); break;
                case ($option["option_id"] == "95") : array_push($couples_combined_interests, "sports", "physical activity"); break;
                case ($option["option_id"] == "96") : array_push($couples_combined_interests, "yoga", "spa"); break;
                case ($option["option_id"] == "97") : array_push($couples_combined_interests, "meditation"); break;
                case ($option["option_id"] == "98") : array_push($couples_combined_interests, "museum", "history"); break;
                case ($option["option_id"] == "99") : array_push($couples_combined_interests, "movies", "amusement"); break;
            }
        }

        // if user answers yes to Q25 : open to experiencing my partner's activities and interests
        $user_Q25_couple_survey_response = SurveyResponse::where(["user_id" => $user -> id, "connection_id" => $connection_id, "question_id" => 25])
                                          -> with('option') -> latest() -> first('option_id')['option']['option'];

        // echo $user_Q25_couple_survey_response; 
        if ($user_Q25_couple_survey_response == "yes"){

            // add partners interests
        }

        // add user interests (as google places queries) to $couples_combined_interests
        $my_interests = SurveyResponse::where(["user_id" => $user -> id, "survey_id" => 1]) -> get(['question_id', 'option_id']);
        foreach($my_interests as $interest){
            switch($interest){ // consider the opposite case. if crowded = no then calm
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 1: array_push($couples_combined_interests, "crowded"); break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 2: array_push($couples_combined_interests, "nightlife"); break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 3: array_push($couples_combined_interests, "outdoor"); break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 4: array_push($couples_combined_interests, "nature"); break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 5: array_push($couples_combined_interests, "museum", "art gallery"); break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 6: array_push($couples_combined_interests, "culture", "education"); break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 7: array_push($couples_combined_interests, "book"); break; 
                case $interest['option_id'] % 2 != 0 && $interest['question_id'] == 8: array_push($couples_combined_interests, "religion"); break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 9: array_push($couples_combined_interests, "calm"); break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 10: array_push($couples_combined_interests, "spiritual"); break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 11: array_push($couples_combined_interests, "self-care"); break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 12: array_push($couples_combined_interests, "shopping"); break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 13: array_push($couples_combined_interests, "exercise"); break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 14: array_push($couples_combined_interests, "restaurant"); break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 15: array_push($couples_combined_interests, "shopping"); break; 
                case $interest['option_id'] % 2 != 0 && $interest['question_id'] == 16: array_push($couples_combined_interests, "shopping"); break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 17: array_push($couples_combined_interests, "sports"); break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 18: array_push($couples_combined_interests, "home activities"); break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 19: array_push($couples_combined_interests, "movie"); break;  
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 20: array_push($couples_combined_interests, "animals"); break;  
            }
        }

        print_r(array_unique($couples_combined_interests));
                
    }
}
