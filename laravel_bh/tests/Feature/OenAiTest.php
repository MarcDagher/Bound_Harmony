<?php

namespace Tests\Feature;

use App\Models\Role;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Illuminate\Support\Facades\Hash;
use Tests\TestCase;

class OenAiTest extends TestCase{
    use RefreshDatabase;

    public function test_save_open_ai_response(): void
    {
        $this -> create_roles();
        $user = $this -> create_user('nancy@hotmail.com', 2);


        $response = $this -> actingAs($user) -> post('/api/save_user_prompt', ["prompt" => "This is the prompt"]);

        $response->assertStatus(200);
    }

    public function create_roles(){
        Role::factory() -> create(["role" => 'admin']);
        Role::factory() -> create(["role" => 'user']);
    }

    public function create_user($email, $role_id = 2) : User{
        $user = User::factory() -> create([
            "role_id" => $role_id,
            "email" => $email,
            "password" => Hash::make('password'),
            'birthdate' => fake()->date(), 
        ]);
        return $user;
    }
}
