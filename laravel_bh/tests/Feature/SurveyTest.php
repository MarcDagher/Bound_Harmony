<?php

namespace Tests\Feature;

use App\Models\Survey;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class SurveyTest extends TestCase {
    use RefreshDatabase;
    
    // public function test_successful_get_personal_survey(): void{
    //     $survey = Survey::factory()->create(["title" => 'Personal Survey']);
    //     Survey::factory()->create(["title" => "Couple's Survey"]);
    //     HelperFunctions::create_roles();
    //     $user = HelperFunctions::create_user('nancy@hotmail.com', 2, "true");
    //     $response = $this -> actingAs($user) -> get('/api/get_survey', ['survey_id' => 1]);

    //     $response -> assertStatus(200); 
    // }

    public function test_failed_get_couple_survey(): void{
        Survey::factory()->create(["title" => 'Personal Survey']);
        Survey::factory()->create(["title" => "Couple's Survey"]);
        HelperFunctions::create_roles();
        $user = HelperFunctions::create_user('nancy@hotmail.com', 2, "false");
        // $response = $this -> actingAs($user) -> getJson('/api/get_survey', ["survey_id" => 2]);
        $response = $this->actingAs($user)->getJson('/api/get_survey?survey_id=2');

        $response -> assertStatus(403); 
    }
}
