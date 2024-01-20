<?php

namespace App\Http\Controllers;

use App\Models\Connection;
use App\Models\SurveyResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Http;

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
            case ($option["option_id"] == "93") : return ["campground", "park"]; break; // outdoor and nature
            case ($option["option_id"] == "94") : return ["cafe", "restaurant", "bar", "casino", "shopping_mall"]; break; // social and entertainment
            case ($option["option_id"] == "95") : return ["gym"]; break; //sports, physical activity
            case ($option["option_id"] == "96") : return [ "spa","beauty_salon", "hair_care"]; break; //yoga, spa
            case ($option["option_id"] == "97") : return []; break; // meditation
            case ($option["option_id"] == "98") : return ["art_gallery", "museum", "tourist_attraction"]; break; // museum, history
            case ($option["option_id"] == "99") : return ["amusement_park", "clothing_store", "bowling_alley", "movie_theater"]; break; // movies, amusement
        }
    }

    // helper method: change user's options to useable Google Places Api query parameters
    public function filter_Q25_responses($interest){
        switch($interest){ // consider the opposite case. if crowded = no then calm
            case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 1:  return ["cafe", "amusement_park"]; break; // crowded
            case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 2:  return ["night_club", "casino", "bar"]; break; // nightlife 
            case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 3:  return "campground"; break; // outdoor
            case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 4:  return "campground"; break; // nature
            case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 5:  return ["museum", "art gallery"]; break; // art
            case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 6:  return ["tourist_attraction", "museum"]; break; // culture
            // case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 7:  return "book"; break; // books
            // case $interest['option_id'] % 2 != 0 && $interest['question_id'] == 8:  return "religion"; break; // religion
            // case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 9:  return "calm"; break; // calm
            // case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 10:  return "spiritual"; break; // spiritual
            case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 11:  return ["spa", "beauty_salon"]; break; // self-care
            case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 12:  return ["shopping_mall", "clothing_store"]; break; // shopping clothes
            case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 13:  return "gym"; break; // exercise
            case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 14:  return "restaurant"; break; // restaurants
            case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 15:  return ["shopping_mall", "department_store"]; break; // shopping grocery
            case $interest['option_id'] % 2 != 0 && $interest['question_id'] == 16:  return "shopping_mall"; break; // shopping in general
            case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 17:  return "gym"; break; // sports
            // case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 18:  return "home activities"; break; // places that are not crowded
            case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 19:  return "movie_theater"; break;  // movies
            case $interest['option_id'] % 2 == 0 && $interest['question_id'] == 20:  return "zoo"; break;   // animals
            }
    }

    public function get_date_places($location, $radius, $list_of_interests, $key){
        $date_places = ["bar", "restaurant", "movie_theater", "museum", "art gallery", "spa"];
        $filtered_types = [];
        foreach ($list_of_interests as $date){
            if (in_array($date, $date_places)){array_push($filtered_types, $date);}
        }

        $type = $filtered_types[array_rand($filtered_types, 1)];
        $response = Http::get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$location&radius=$radius&types=$type&key=$key");
        if ($response->successful()) {
            $places_data = $response->json();

            $list_of_places = [];
            foreach($places_data['results'] as $place){
                $list_of_places[] = [
                    "name" => isset($place["name"]) ? $place["name"] : "no name",
                    "business_status" => isset($place["business_status"]) ? $place["business_status"] : "no business status",
                    "opening_hours" => isset($place["opening_hours"]) ? $place["opening_hours"] : "no opening hours",
                    "place_id" => isset($place["place_id"]) ? $place["place_id"] : "no place id",
                    "plus_code" => isset($place["plus_code"]) ? $place["plus_code"] : "no plus code",
                    "photos" => isset($place["photos"]) ? $place["photos"] : "no photos",
                    "types" => isset($place["types"]) ? $place["types"] : "no types",
                    "rating" => isset( $place["rating"]) ? $place["rating"] : "no ratings",
                    "user_ratings_total" => isset($place["user_ratings_total"]) ? $place["user_ratings_total"] : "no total ratings",
                    "vicinity" => isset($place["vicinity"]) ? $place["vicinity"] : "no vicinity",
                ];
            }
            return $list_of_places;
            
        } else {
            $error = $response->json();
            return response()->json($error, $response->status());
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
    

        $location = '33.895234124742615%2C35.49990688179016'; // beirut
        $radius = '40000';
        $key = env("GOOGLE_PLACES_API_KEY");

        $places = $this -> get_date_places($location, $radius, $couples_combined_interests_without_duplicates, $key); // google places
        // return $places;
        return response() -> json([
            "status" => "success",
            "places" => $places
        ]);
        // location(longitude-latitude), a background color, a link to their place on google maps, name, open_now, place_id, types(resto, pub...), Vicinity.
        // value field we can display: icon_background_color, icon_mask_base_uri, name, types, vicinity
    }
}
