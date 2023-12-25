<?php

namespace App\Http\Controllers;

use App\Models\Connection;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;

class ConnectionsController extends Controller
{
    public function display_history (){
        // query the records with accepted or disconnected related to the user
        
        $token = Auth::user();
        
        // records where status is [accepted or disconnected] and requester or responder are the current user
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
        // sends a request only when users don't have a connection or if their previous connections are [rejected, disconnected]
        // if status is [pending, connected] request will not be sent

        $request -> validate([
            "email" => "required|max:100"
        ]);

        $email_exists = User::where('email', $request->email)->get();

        if (isset($email_exists[0])){
            // if status is rejected or disconnected I want to be able to send again
            $token = Auth::user();
            $requester_id = $token->id;
            $responder_id = $email_exists[0]->id;

            // records where connection exists and status is [accepted or pending] => i only want to request when status [rejected, desconnected] 
            $connection_exists = Connection::whereIn('status', ['pending', 'accepted']) -> where (function ($query) use ($requester_id, $responder_id) {
                $query -> where(["requester"=>$requester_id , "responder"=>$responder_id]) -> orWhere(["responder"=>$requester_id , "requester"=>$responder_id]);
            })->get();

            if (isset($connection_exists[0])) {
                return response()->json([
                    "status" => "failed",
                    "message" =>  "You can only send a request if you were rejected or disconncted",
                ]);
            } else {
                $connection = Connection::create([
                    "requester" => $requester_id,
                    "responder" => $responder_id,
                ]);

                return response()->json([
                    "status" => "success",
                    "message" =>  "Request has been sent. Good Luck!",
                    "connection" => $connection
                ]);
            }
            
        } else {
            return response()->json([
                "status" => "failed",
                "message" => "Request failed. User doesn't exist"
            ]);
        }

    }
}
