<?php

namespace App\Http\Middleware;

use App\Models\Connection;
use App\Models\User;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class SuggestionsMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {

        $user = Auth::user();

        // Check if user has a partner and if user completed couples survey
        if($user -> connection_status == "false" || $user -> couple_survey_status == "incomplete"){
            return response() -> json([
                "status" => "failed",
                "message" => "Make sure you are connected and your couple's survey is submitted"
            ]);
        }

        // get user's partner
        $partner_as_requester = Connection::where(['status' => 'accepted', "responder" => $user -> id]) -> with("requester_user") -> get('requester') -> first();
        $partner_as_responder = Connection::where(['status' => 'accepted', "requester" => $user -> id]) -> with("responder_user") -> get('responder') -> first();

        // check if user's partner completed couple's survey
        // user is the requester
        if ($partner_as_requester) {
            if ($partner_as_requester['requester_user']['couple_survey_status'] == "incomplete"){
                return response() -> json([
                    "status" => "failed",
                    "message" => "Make sure your partner submitted their couple's survey"
                ]); 
            }

        // user is the responder
        } else if ($partner_as_responder) {
            if ($partner_as_responder['requester_user']['couple_survey_status'] == "incomplete"){
                return response() -> json([
                    "status" => "failed",
                    "message" => "Make sure your partner submitted their couple's survey"
                ]); 
            }
        }
        return $next($request);
    }
}
// https://laravel-news.com/openai-for-laravel