<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\ChatBotController;
use App\Http\Controllers\ConnectionsController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\SurveysController;
use App\Http\Middleware\AuthMiddleware;

Route::controller(AuthController::class)->group(function () {
    Route::post('/login', 'login');
    Route::post('/register', 'register');
    Route::post('/logout', 'logout');
    Route::post('/refresh', 'refresh');

});

Route::controller(ProfileController::class)->group(function () {
    Route::post('/update_profile', 'update_profile');
    Route::post('/edit_image', 'edit_image');
});

Route::controller(ConnectionsController::class)->group(function () {
    Route::get('/display_history', 'display_history');
    Route::post('/send_request', 'send_request');
    Route::get('/display_requests', 'display_requests');
    Route::post('/respond_to_request', 'respond_to_request');
    Route::post('/disconnect', 'disconnect');
});

Route::controller(SurveysController::class)->group(function (){
    Route::get('/get_survey', 'get_survey');
    Route::post('/save_responses', 'save_responses');
});

Route::controller(ChatBotController::class) -> group (function (){
    Route::post('/save_user_prompt', 'save_user_prompt');
});

// Route::middleware('auth.user')->group(function () {
//     Route::post('favorite_hobby/create',  [ Controller ::class, 'createFavoriteHobby']);});