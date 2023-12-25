<?php

namespace App\Http\Controllers;

use App\Models\Connection;
use Illuminate\Support\Facades\Auth;

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
}
