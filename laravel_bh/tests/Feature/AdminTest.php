<?php

namespace Tests\Feature;

use App\Models\Role;
use App\Models\User;
use Database\Factories\RoleFactory;
use Database\Factories\UserFactory;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Illuminate\Support\Facades\Hash;
use Tests\TestCase;

class AdminTest extends TestCase
{
    use RefreshDatabase;
    
    public function test_failed_admin_login(): void {
        $this -> create_role();
        $this -> create_user('mousa@hotmail.com');

        $response = $this->post('/api/signin', ['email' => 'mousa@hotmail.com', "password" => "password"]);
        
        $response->assertStatus(401);
    }

    public function create_role(){
        Role::factory() -> create(["role" => 'admin']);
        Role::factory() -> create(["role" => 'user']);
    }

    public function create_user($email){
        User::factory() -> create([
            "email" => $email,
            "password" => Hash::make('password'),
            'birthdate' => fake()->date(), 
        ]);
    }

}
