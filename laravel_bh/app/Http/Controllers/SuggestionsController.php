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
        if ($user_Q25_couple_survey_response == "yes"){
            // add partners interests
        }

        // add my interests
        $my_interests = SurveyResponse::where(["user_id" => $user -> id, "survey_id" => 1]) -> with('question', 'option') -> get(['question_id', 'option_id']);
        foreach($my_interests as $interest){
            // echo $interest['question']['question'] .': '. $interest['option']['option'] ."\n";   
            // echo $interest; 
            // issue now is, how will I extract a query from the question. I need to assign a query or a type, to each interest
        }

        print_r(array_unique($couples_combined_interests));
                
    }
}
