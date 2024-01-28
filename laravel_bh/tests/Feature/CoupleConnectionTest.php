<?php

namespace Tests\Feature;

use App\Models\Connection;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class CoupleConnectionTest extends TestCase {
    use RefreshDatabase;
    
    public function test_successful_send_connection_request(): void {
        HelperFunctions::create_roles();
        $user = HelperFunctions::create_user('mousa@hotmail.com');
        HelperFunctions::create_user('nancy@hotmail.com');
        
        $response = $this-> actingAs($user) -> post('/api/send_request', ['email' => 'nancy@hotmail.com']);

        $response->assertStatus(200);
    }

    public function test_successful_accept_connection_request() {
        HelperFunctions::create_roles();
        HelperFunctions::create_user('mousa@hotmail.com');
        $user = HelperFunctions::create_user('nancy@hotmail.com');
        Connection::factory() -> create([
            'requester' => 1,
            'responder' => 2,
            'status' => 'pending'
        ]);

        $response = $this -> actingAs($user) -> post('api/respond_to_request', ['request_id' => 1, 'response' => 'accepted']);

        $response -> assertStatus(200);
    }
}
