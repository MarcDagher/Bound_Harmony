<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class SurveysController extends Controller
{
    
    public function get_survey () {
        // query questions and options of the survey
    }

    public function send_responses () {
        // send user's responses
        // array of objects {user_id, question_id, response}
        
    }
}
