<?php

namespace App\Http\Controllers;

use App\Models\Connection;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;

class ConnectionsController extends Controller
{
    // query the records with accepted or disconnected related to the user
    public function display_history (){
        $token = Auth::user();
        
        // records where status is [connected or disconnected] and requester or responder are the current user
        $connections = Connection::whereIn('status', ['accepted', 'disconnected']) -> where (function ($query) use ($token)  {
            $query -> where('requester', $token->id)->orWhere('responder', $token->id);
        })->get();

        if (isset($connections[0])) {
            return response()->json([
                "status" => 'success',
                "connections" => $connections
                // then display connections in frontend
            ]);
        } else {
            return response()->json([
                "status" => "failed",
                "message" => "You don't have any past or current connections"
            ]);
        } 

    }

    public function send_request(Request $request){

        $request -> validate([
            "email" => "required|max:100"
        ]);

        $email_exists = User::where('email', $request->email)->get();
        if (isset($email_exists[0])){
            $token = Auth::user();
            $requester_id = $token->id;
            $responder_id = $email_exists[0]->id;
            
            $connection = Connection::create([
                "requester" => $requester_id,
                "responder" => $responder_id,
            ]);

            return response()->json([
                "status" => "success",
                "message" =>  "Request has been sent. Good Luck!",
                "connection" => $connection
            ]);
            
        } else {
            return response()->json([
                "status" => "failed",
                "message" => "Request failed. User doesn't exist"
            ]);
        }

    }
}
