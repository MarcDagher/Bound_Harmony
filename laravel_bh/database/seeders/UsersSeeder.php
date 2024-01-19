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
            "username" => "Mousa",
            "email" => "mousa@hotmail.com",
            "password" => Hash::make("123456"),
            "birthdate" => "2001-01-15",
            "connection_status" => "true"
        ]);

        User::create([
            "role_id" => 2,
            "username" => "Kevin",
            "email" => "kevin@hotmail.com",
            "password" => Hash::make("123456"),
            "birthdate" => "2001-01-15",
            "connection_status" => "true"
        ]);

        User::create([
            "role_id" => 2,
            "username" => "Charbel",
            "email" => "charbel@hotmail.com",
            "password" => Hash::make("123456"),
            "birthdate" => "2001-01-15",
            "connection_status" => "true"
        ]);

        User::create([
            "role_id" => 2,
            "username" => "Riyad",
            "email" => "riyad@gmail.com",
            "password" => Hash::make("123456"),
            "birthdate" => "2001-01-15",
        ]);
        
        User::create([
            "role_id" => 2,
            "username" => "Rita",
            "email" => "rita@hotmail.com",
            "password" => Hash::make("123456"),
            "birthdate" => "2001-01-15",
            "connection_status" => "true"
        ]);

        User::create([
            "role_id" => 2,
            "username" => "Marwa",
            "email" => "marwa@hotmail.com",
            "password" => Hash::make("123456"),
            "birthdate" => "2001-01-15",
        ]);

        User::create([
            "role_id" => 2,
            "username" => "Basma",
            "email" => "basma@hotmail.com",
            "password" => Hash::make("123456"),
            "birthdate" => "2001-01-15",
            "connection_status" => "true"
        ]);

        User::create([
            "role_id" => 2,
            "username" => "Nancy",
            "email" => "nancy@hotmail.com",
            "password" => Hash::make("123456"),
            "birthdate" => "2001-01-15",
            "connection_status" => "true"
        ]);

        User::create([
            "role_id" => 2,
            "username" => "Haifa",
            "email" => "haifa@hotmail.com",
            "password" => Hash::make("123456"),
            "birthdate" => "2001-01-15",
        ]);

        User::create([
            "role_id" => 2,
            "username" => "Ricardo",
            "email" => "ricardo@hotmail.com",
            "password" => Hash::make("123456"),
            "birthdate" => "2001-01-15",
        ]);

        User::create([
            "role_id" => 2,
            "username" => "John",
            "email" => "john@hotmail.com",
            "password" => Hash::make("123456"),
            "birthdate" => "2001-01-15",
        ]);

        User::create([
            "role_id" => 2,
            "username" => "Pia",
            "email" => "pia@hotmail.com",
            "password" => Hash::make("123456"),
            "birthdate" => "2001-01-15",
        ]);

        User::create([
            "role_id" => 2,
            "username" => "Mia",
            "email" => "mia@hotmail.com",
            "password" => Hash::make("123456"),
            "birthdate" => "1997-10-15",
        ]);

        User::create([
            "role_id" => 2,
            "username" => "Tia",
            "email" => "tia@hotmail.com",
            "password" => Hash::make("123456"),
            "birthdate" => "2004-07-10",
        ]);
        //////
        User::create([
            "role_id" => 1,
            "username" => "Admin",
            "email" => "admin123@hotmail.com",
            "password" => Hash::make("123456"),
            "birthdate" => "2001-01-15",
        ]);

        //// Admin done
    }
}
