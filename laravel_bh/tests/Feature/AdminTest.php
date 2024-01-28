<?php

namespace Tests\Feature;


use App\Models\Role;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Hash;
use Tests\TestCase;

class AdminTest extends TestCase
{
    use RefreshDatabase;
    
    public function test_failed_admin_login(): void {
        HelperFunctions::create_roles();
        HelperFunctions::create_user('mousa@hotmail.com');

        $response = $this->post('/api/signin', ['email' => 'mousa@hotmail.com', "password" => "password"]);

        $response->assertStatus(401);
    }

    public function test_admin_login_success(){
        HelperFunctions::create_roles();
        HelperFunctions::create_user('mousa@hotmail.com', 1);

        $response = $this->post('/api/signin', ['email' => 'mousa@hotmail.com', "password" => "password"]);

        $response->assertStatus(200);
    }

    public function test_admin_delete_user(){
        HelperFunctions::create_roles();
        HelperFunctions::create_user("mousa@hotmail.com");
        $admin = HelperFunctions::create_user("admin123@hotmail.com", 1);

        $response =  $this -> actingAs($admin) -> post('/api/delete_user', ['email' => 'mousa@hotmail.com']);

        $response -> assertStatus(200);

    }
    

    public function test_admin_restore_user(){
        HelperFunctions::create_roles();
        HelperFunctions::create_user("mousa@hotmail.com");
        $admin = HelperFunctions::create_user("admin123@hotmail.com", 1);
        $response =  $this -> actingAs($admin) -> post('/api/delete_user', ['email' => 'mousa@hotmail.com']);

        $response =  $this -> actingAs($admin) -> post('/api/restore_deleted_user', ['email' => 'mousa@hotmail.com']);

        $response -> assertStatus(200);

    }

}
