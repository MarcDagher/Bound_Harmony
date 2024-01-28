<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class SurveyTest extends TestCase
{
    /**
     * A basic feature test example.
     */
    public function test_example(): void
    {
        
        $response = $this->get('/api/get_survey', ['survey_id' => 1]);

        $response->assertStatus(200);
    }
}
