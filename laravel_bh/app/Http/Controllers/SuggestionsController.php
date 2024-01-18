<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class SuggestionsController extends Controller
{


    //I need to know th user's interests to know what to suggest.
    //User has to have a partner in order to get to here.
    // So, i need to:
    // 1. query the list of types/themes that the user said yes to.
    // 2. query the list of types/thems my partner said yes to.
    // 3. query the answers given about the relationship
    public function get_suggestions(){
        return "\n Hello, this is sugestions";
    }
}
