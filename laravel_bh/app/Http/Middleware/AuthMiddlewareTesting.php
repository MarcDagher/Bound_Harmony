<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class AuthMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {

    // 1 -> write code here: get the user, authorize his existence.
    // 2 -> Take the namespace path from above
    // 3 -> go to kernel.php in Http folder
    // 4 -> in kernel, write the name(aliasis) and full the path.
    // 5 -> add it to the route
        $user = Auth::user();
        if($user){
            return $next($request);
        }
        return response()->json([
            'status' => "failed",
            "message" => "Fel 3a baytak"
        ], 403);
    }
}
