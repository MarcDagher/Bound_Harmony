<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UsersSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        User::create([
            "role_id" => 2,
            "username" => "mouse",
            "email" => "mouse@hotmail.com",
            "password" => Hash::make("123456"),
            "birthdate" => "2001-01-15",
        ]);

        User::create([
            "role_id" => 2,
            "username" => "speaker",
            "email" => "speaker@hotmail.com",
            "password" => Hash::make("123456"),
            "birthdate" => "2001-01-15",
        ]);

        User::create([
            "role_id" => 2,
            "username" => "screen",
            "email" => "screen@hotmail.com",
            "password" => Hash::make("123456"),
            "birthdate" => "2001-01-15",
        ]);

        User::create([
            "role_id" => 2,
            "username" => "box",
            "email" => "box@hotmail.com",
            "password" => Hash::make("123456"),
            "birthdate" => "2001-01-15",
        ]);
    }
}
