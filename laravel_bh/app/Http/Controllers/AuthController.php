<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use Carbon\Carbon;

class AuthController extends Controller
{

    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['login','register', 'signin']]);
    }

    public function register(Request $request){
        $request->validate([
            'username' => 'required|string|max:80',
            'email' => 'required|string|email|max:100|unique:users',
            'password' => 'required|string|min:6',
            'birthdate' => 'required|date_format:d-m-Y'
        ]);
        
        $user = User::create([
            'username' => $request->username,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'birthdate' => Carbon::createFromFormat('d-m-Y', $request->birthdate) -> format('Y-m-d') 
            // Carbon is a class that handles date type
        ]);

        // $token = Auth::login($user);
        return response()->json([
            'status' => 'success',
            'message' => 'User created successfully',
            'user' => $user,
            // 'authorisation' => [
            //     'token' => $token,
            //     'type' => 'bearer',
            // ]
        ]);
    }

    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|string|email',
            'password' => 'required|string',
        ]);
        $credentials = $request->only('email', 'password');

        $token = Auth::attempt($credentials);
        if (!$token) {
            return response()->json([
                'status' => 'error',
                'message' => 'Unauthorized',
            ], 401);
        }

        $user = Auth::user();
        return response()->json([
                'status' => 'success',
                'user' => $user,
                'authorisation' => [
                    'token' => $token,
                    'type' => 'bearer',
                ]
            ]);
    }

    public function signin(Request $request){
        $request -> validate([
            'email' => "required|email",
            'password' => "required"
        ]);

        $credentials = $request -> only('email', 'password');
        $token = Auth::attempt($credentials);

        if($token){
            $user = Auth::user();
            if($user -> role_id == 1){
                return response() -> json([
                    "status" => "success",
                    "token" => $token
                ]);
            } else {
                return response() -> json([
                    "status" => "failed",
                    "message" => "Wrong credentials"
                ], 401);    
            }

        } else {
            return response() -> json([
                "status" => "failed",
                "message" => "Wrong credentials"
            ], 401);
        }
    }

    public function logout()
    {
        Auth::logout();
        return response()->json([
            'status' => 'success',
            'message' => 'Successfully logged out',
        ]);
    }

    public function refresh()
    {
        return response()->json([
            'status' => 'success',
            'user' => Auth::user(),
            'authorisation' => [
                'token' => Auth::refresh(),
                'type' => 'bearer',
            ]
        ]);
    }

}