<?php

use App\Http\Controllers\AdminController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\ConnectionsController;
use App\Http\Controllers\MessagesController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\SuggestionsController;
use App\Http\Controllers\SurveysController;
use App\Http\Middleware\AuthMiddleware;

// LogIn and Register Pages
Route::controller(AuthController::class)->group(function () {
    Route::post('/login', 'login');
    Route::post('/register', 'register');
    Route::post('/logout', 'logout');
    Route::post('/refresh', 'refresh');
});

// Admin page
Route::middleware('auth.admin')->group(function () {
     Route::post('/delete_user', [AdminController::class, 'delete_user']);
     Route::post('/restore_deleted_user', [AdminController::class, 'restore_deleted_user']);
     Route::get('/user_connection_surveys_stats', [AdminController::class, 'user_connection_surveys_stats']);
     Route::get('/most_common_response', [AdminController::class, 'most_common_response']);
     Route::get('/count_of_connection_status_type', [AdminController::class, 'count_of_connection_status_type']);
});

// Profile Page
Route::controller(ProfileController::class)->group(function () {
    Route::post('/change_username', 'change_username');
    Route::post('change_location', 'change_location');
    Route::post('/edit_image', 'edit_image');
    Route::get('/get_profile_photo', 'get_profile_photo');
});

// Incoming Requests - My Partners pages
Route::controller(ConnectionsController::class)->group(function () {
    Route::get('/display_history', 'display_history');
    Route::post('/send_request', 'send_request');
    Route::get('/display_requests', 'display_requests');
    Route::post('/respond_to_request', 'respond_to_request');
    Route::post('/disconnect', 'disconnect');
});

// Advice Page
Route::controller(MessagesController::class) -> group (function (){
    Route::post('/save_user_prompt', 'save_user_prompt');
    Route::get('/get_conversation', 'get_conversation');
    Route::get('/send_user_prompt_to_ai', 'send_user_prompt_to_ai');
});

// Suggestions Page
Route::middleware('validate.for.suggestions') -> group(function(){
    Route::get('/get_suggestions', [SuggestionsController::class, 'get_suggestions']);
});

/// Personal Survey - Couples Survey pages
/// checks if user connection_status == true and if personal_survey_status == true
Route::middleware('validate.for.couples.survey')->group(function(){
    Route::get('/get_survey', [SurveysController::class ,'get_survey']);
});

// Personal Survey - Couples Survey pages
Route::controller(SurveysController::class)->group(function (){
    Route::post('/save_responses', 'save_responses');
});

