<?php

namespace App\Http\Controllers;

use App\Models\Connection;
use App\Models\SurveyResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class SuggestionsController extends Controller
{

    // helper method: gets user's current partner 
    public function search_for_connection_and_partner($user){
        // search for user's partner where connection_status is accepted
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

    // helper method: gets the couple survey responses of the given question_id and user_id 
    public function get_couple_survey_Q_responses($user_id, $connection_id, $question_id){
        $user_Q_couple_survey_response = SurveyResponse::where(['connection_id' => $connection_id, 'user_id' => $user_id, "question_id" => $question_id]) 
                                        -> get('option_id');
        return $user_Q_couple_survey_response;
    }

    // helper method: change user's options to useable Google Places Api query parameters
    public function filter_Q28_responses($option){
        switch ($option){
            case ($option["option_id"] == "93") : return ["outdoor", "nature"]; break;
            case ($option["option_id"] == "94") : return ["social", "entertainment"]; break;
            case ($option["option_id"] == "95") : return ["sports", "physical activity"]; break;
            case ($option["option_id"] == "96") : return ["yoga", "spa"]; break;
            case ($option["option_id"] == "97") : return ["meditation"]; break;
            case ($option["option_id"] == "98") : return ["museum", "history"]; break;
            case ($option["option_id"] == "99") : return ["movies", "amusement"]; break;
        }
    }

    // helper method: change user's options to useable Google Places Api query parameters
    public function filter_Q25_responses($interest){
        switch($interest){ // consider the opposite case. if crowded = no then calm
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 1:  return "crowded"; break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 2:  return "nightlife"; break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 3:  return "outdoor"; break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 4:  return "nature"; break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 5:  return ["museum", "art gallery"]; break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 6:  return ["culture", "education"]; break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 7:  return "book"; break; 
                case $interest['option_id'] % 2 != 0 && $interest['question_id'] == 8:  return "religion"; break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 9:  return "calm"; break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 10:  return "spiritual"; break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 11:  return "self-care"; break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 12:  return "shopping"; break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 13:  return "exercise"; break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 14:  return "restaurant"; break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 15:  return "shopping"; break; 
                case $interest['option_id'] % 2 != 0 && $interest['question_id'] == 16:  return "shopping"; break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 17:  return "sports"; break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 18:  return "home activities"; break; 
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 19:  return "movie"; break;  
                case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 20:  return "animals"; break;  
            }
    }

    // adds user's interests (data is from personal survey) - adds user's and partner's interests (data is from couples survey) 
    // if Q25 == "Yes" adds partner's interests (data is from personal survey)
    public function get_suggestions(){
        $user = Auth::user();
        $couples_combined_interests = []; // answers of Q28 + user's + partner's(if Q25 is yes)

        //get the connection id and partner id of this user's relationship (connection_id)
        $connection_and_partner_ids = $this -> search_for_connection_and_partner($user);
        $connection_id = $connection_and_partner_ids['connection_id'];
        $partner_id = $connection_and_partner_ids['partner_id'];
        
        //get Couple Survey Responses of Q28 (Q = question) of the user and the partner 
        $user_Q28_couple_survey_response = $this -> get_couple_survey_Q_responses($user -> id, $connection_id, 28);
        $partner_Q28_couple_survey_response = $this -> get_couple_survey_Q_responses($partner_id, $connection_id, 28);

        // activities which the user enjoys with their partner 
        foreach ($user_Q28_couple_survey_response as $option) {
            $value = $this -> filter_Q28_responses($option);
            if (is_array($value)){
                foreach($value as $new_value){
                    array_push($couples_combined_interests, $new_value);    
                }
            } elseif (is_string($value)){
                array_push($couples_combined_interests, $value);
            }
        }

        // activities which the partner enjoys with the user 
        foreach ($partner_Q28_couple_survey_response as $option) {
            $value = $this -> filter_Q28_responses($option);
            if (is_array($value)){
                foreach($value as $new_value){
                    array_push($couples_combined_interests, $new_value);    
                }
            } elseif (is_string($value)){
                array_push($couples_combined_interests, $value);
            }
        }

        // if user answers yes to Q25 : "open to experiencing my partner's activities and interests"
        $user_Q25_couple_survey_response = SurveyResponse::where(["user_id" => $user -> id, "connection_id" => $connection_id, "question_id" => 25])
                                          -> with('option') -> latest() -> first('option_id')['option']['option'];

        // if user is interested in trying their partner's interests
        if ($user_Q25_couple_survey_response == "Yes"){
            $partner_interests = SurveyResponse::where(["user_id" => $partner_id, "survey_id" => 1]) -> get(['question_id', 'option_id']);

            foreach($partner_interests as $interest){
                $value = $this -> filter_Q25_responses($interest);
                if (is_array($value)){
                    foreach($value as $new_value)
                    array_push($couples_combined_interests, $new_value);
                } elseif (is_string($value)){array_push($couples_combined_interests, $value);}
            }
        }

        // add user's interests to $couples_combined_interests
        $my_interests = SurveyResponse::where(["user_id" => $user -> id, "survey_id" => 1]) -> get(['question_id', 'option_id']);

        foreach($my_interests as $interest){
            $value = $this -> filter_Q25_responses($interest);
            if (is_array($value)){
                foreach($value as $new_value)
                array_push($couples_combined_interests, $new_value);
            } elseif (is_string($value)){array_push($couples_combined_interests, $value);}
        }

        // Parameters which will be used in Google Places api
        $couples_combined_interests_without_duplicates = array_unique($couples_combined_interests);
    }

    
}
