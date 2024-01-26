<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class PredictionsController extends Controller
{
    public function get_prediction(Request $request){

        $response = Http::get('http://127.0.0.1:8080/prediction/battikha');

        return response()->json([
            'laravel_message' => 'Hello from laravel.',
            'django_response' => $response, 
        ]);


        // $curl = curl_init();
        // curl_setopt_array($curl, [
        //         CURLOPT_URL => 'http://127.0.0.1:8080/prediction',
        //         CURLOPT_RETURNTRANSFER => true,
        //         CURLOPT_CUSTOMREQUEST => "GET",
        //         CURLOPT_HTTPHEADER => ['Content-Type: application/json', "accept: */*",],
        //     ]
        // );

        // $response = curl_exec($curl);
        // $err = curl_error($curl);
        // curl_close($curl);
        // if ($err) {
        //     echo "cURL Error #:" . $err;
        // } else {
        //     print_r(json_decode($response));
        // }
    }
}
