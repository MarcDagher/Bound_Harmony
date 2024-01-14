<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class CheckConnectionForCouplesSurvey
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response   
    {

        $request -> validate([
            ["survey_id" => "required|integer|in:1,2"]
        ]);
        $user = Auth::user();
        if ($user -> connection_status == "true" && $request->survey_id == 2){
            return $next($request);
        } else {
            return response()->json([
                "status" => "rejected",
                "message" => "User needs to be connected"
            ], 403);
        }
    }
}
