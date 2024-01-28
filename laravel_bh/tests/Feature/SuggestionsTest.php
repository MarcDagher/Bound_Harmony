<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class SuggestionsTest extends TestCase
{
    
    public function test_failed_get_suggestion(): void{

        $response = $this->get('/api/get_suggestions', ['place_type' => 'dates']);

        $response->assertStatus(200);
    }



}
