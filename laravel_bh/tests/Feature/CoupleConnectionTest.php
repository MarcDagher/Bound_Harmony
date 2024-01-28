<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class CoupleConnectionTest extends TestCase {
    use RefreshDatabase;
    /**
     * A basic feature test example.
     */
    public function test_send_connection_request(): void
    {
        HelperFunctions::create_roles();
        $user = HelperFunctions::create_user('mousa@hotmail.com');
        HelperFunctions::create_user('nancy@hotmail.com');
        
        $response = $this-> actingAs($user) -> post('/api/send_request', ['email' => 'nancy@hotmail.com']);

        $response->assertStatus(200);
    }
}
