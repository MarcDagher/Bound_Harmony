<?php

namespace Tests\Feature;

use App\Models\Role;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class HelperFunctions{

  public static function create_roles(){
    Role::factory() -> create(["role" => 'admin']);
    Role::factory() -> create(["role" => 'user']);
  }

  public static function create_user($email, $role_id = 2) : User{
    $user = User::factory() -> create([
        "role_id" => $role_id,
        "email" => $email,
        "password" => Hash::make('password'),
        'birthdate' => fake()->date(), 
    ]); 
    return $user;

 }
}