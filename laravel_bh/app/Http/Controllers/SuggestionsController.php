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

    //I need to know th user's interests to know what to suggest.
    //User has to have a partner in order to get to here.
    
    public function get_suggestions(){
        $user = Auth::user();
        $connection_and_partner = $this -> search_for_connection_and_partner($user);
        echo $connection_and_partner['connection_id'];
        echo $connection_and_partner['partner_id'];
        //get the connection id of this user's relationship
        //get CSR of the user
        // SurveyResponse::where('');

        return "\n Hello, this is sugestions";
    }
}
