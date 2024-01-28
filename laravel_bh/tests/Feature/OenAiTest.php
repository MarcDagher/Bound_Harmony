<?php

namespace Tests\Feature;

use App\Models\Role;
use App\Models\User;
use Tests\Feature\HelperFunctions;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Hash;
use Tests\TestCase;

class OenAiTest extends TestCase{
    use RefreshDatabase;

    public function test_save_open_ai_response(): void
    {
        HelperFunctions::create_roles();
        $user = HelperFunctions::create_user('nancy@hotmail.com', 2);

        $response = $this -> actingAs($user) -> post('/api/save_user_prompt', ["prompt" => "This is the prompt"]);

        $response->assertStatus(200);
    }
}
