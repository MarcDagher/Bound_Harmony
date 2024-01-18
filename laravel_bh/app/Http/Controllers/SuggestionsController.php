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
                                        -> with('option') -> get('option_id');
        return $user_Q_couple_survey_response;
    }

    //I need to know th user's interests to know what to suggest.
    //User has to have a partner in order to get to here.
    
    public function get_suggestions(){
        $user = Auth::user();
        $couples_combined_interests = []; // answers of Q28 + user's + partner's(if Q25 is yes)
        //get the connection id of this user's relationship
        $connection_and_partner_ids = $this -> search_for_connection_and_partner($user);
        $connection_id = $connection_and_partner_ids['connection_id'];
        $partner_id = $connection_and_partner_ids['partner_id'];

        //get Couple Survey Responses of the user (Q = question)
        $user_Q28_couple_survey_response = $this -> get_couple_survey_Q_responses($user -> id, $connection_id, 28);
        $partner_Q28_couple_survey_response = $this -> get_couple_survey_Q_responses($partner_id, $connection_id, 28);

        foreach ($user_Q28_couple_survey_response as $option) {
            if (!in_array($option['option']['option'], $couples_combined_interests)){
                array_push($couples_combined_interests, $option['option']['option']);    
            }
        }
        foreach ($partner_Q28_couple_survey_response as $option) {
            if (!in_array($option['option']['option'], $couples_combined_interests)){
                array_push($couples_combined_interests, $option['option']['option']);    
            }
        }

        // if user answers yes to Q25 : open to experiencing my partner's activities and interests
        $user_Q25_couple_survey_response = SurveyResponse::where(["user_id" => $user -> id, "connection_id" => $connection_id, "question_id" => 25])
                                          -> with('option') -> latest() -> first('option_id')['option']['option'];
        // if ($user_Q25_couple_survey_response == "yes"){
        //     // add partners interests
        // }

        // add my interests
        // $my_interests = SurveyResponse::where(["user_id" => $user -> id]) -> with('option');
                
    }
}
