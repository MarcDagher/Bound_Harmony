<?php

namespace Database\Seeders;

use App\Models\Connection;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class ConnectionsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Connection::create([
            "requester" => 1,
            "responder" => 5,
            "status" => "accepted"
        ]);

        Connection::create([
            "requester" => 6,
            "responder" => 1,
            "status" => "pending"
        ]);

        Connection::create([
            "requester" => 1,
            "responder" => 7,
            "status" => "pending"
        ]);

        Connection::create([
            "requester" => 8,
            "responder" => 1,
            "status" => "disconnected"
        ]);

        Connection::create([
            "requester" => 1,
            "responder" => 9,
            "status" => "disconnected"
        ]);

        Connection::create([
            "requester" => 13,
            "responder" => 1,
            "status" => "pending"
        ]);

        Connection::create([
            "requester" => 1,
            "responder" => 14,
            "status" => "pending"
        ]);
        ////// user 1 done

        Connection::create([
            "requester" => 5,
            "responder" => 2,
            "status" => "pending"
        ]);

        Connection::create([
            "requester" => 2,
            "responder" => 6,
            "status" => "disconnected"
        ]);

        Connection::create([
            "requester" => 7,
            "responder" => 2,
            "status" => "accepted"
        ]);

        Connection::create([
            "requester" => 2,
            "responder" => 8,
            "status" => "disconnected"
        ]);

        Connection::create([
            "requester" => 9,
            "responder" => 2,
            "status" => "pending"
        ]);

        Connection::create([
            "requester" => 2,
            "responder" => 12,
            "status" => "pending"
        ]);

        Connection::create([
            "requester" => 13,
            "responder" => 2,
            "status" => "pending"
        ]);

        Connection::create([
            "requester" => 2,
            "responder" => 14,
            "status" => "pending"
        ]);
        // user 2 done

        Connection::create([
            "requester" => 3,
            "responder" => 5,
            "status" => "pending"
        ]);

        Connection::create([
            "requester" => 6,
            "responder" => 3,
            "status" => "disconnected"
        ]);

        Connection::create([
            "requester" => 3,
            "responder" => 7,
            "status" => "pending"
        ]);

        Connection::create([
            "requester" => 8,
            "responder" => 3,
            "status" => "accepted"
        ]);

        Connection::create([
            "requester" => 3,
            "responder" => 9,
            "status" => "pending"
        ]);

        Connection::create([
            "requester" => 13,
            "responder" => 3,
            "status" => "disconnected"
        ]);

        Connection::create([
            "requester" => 3,
            "responder" => 14,
            "status" => "pending"
        ]);

        // user 3 done

        Connection::create([
            "requester" => 5,
            "responder" => 4,
            "status" => "pending"
        ]);

        Connection::create([
            "requester" => 4,
            "responder" => 6,
            "status" => "pending"
        ]);

        Connection::create([
            "requester" => 7,
            "responder" => 4,
            "status" => "pending"
        ]);

        Connection::create([
            "requester" => 4,
            "responder" => 8,
            "status" => "pending"
        ]);

        Connection::create([
            "requester" => 9,
            "responder" => 4,
            "status" => "pending"
        ]);

        Connection::create([
            "requester" => 4,
            "responder" => 12,
            "status" => "accepted"
        ]);

        Connection::create([
            "requester" => 13,
            "responder" => 4,
            "status" => "disconnected"
        ]);

        Connection::create([
            "requester" => 4,
            "responder" => 14,
            "status" => "disconnected"
        ]);

        // user 4 done
        
        Connection::create([
            "requester" => 10,
            "responder" => 5,
            "status" => "pending"
        ]);

        Connection::create([
            "requester" => 6,
            "responder" => 10,
            "status" => "pending"
        ]);

        Connection::create([
            "requester" => 10,
            "responder" => 7,
            "status" => "disconnected"
        ]);

        Connection::create([
            "requester" => 8,
            "responder" => 10,
            "status" => "disconnected"
        ]);

        Connection::create([
            "requester" => 10,
            "responder" => 9,
            "status" => "pending"
        ]);

        Connection::create([
            "requester" => 13,
            "responder" => 10,
            "status" => "pending"
        ]);

        Connection::create([
            "requester" => 10,
            "responder" => 14,
            "status" => "pending"
        ]);

        // user 10 done

        Connection::create([
            "requester" => 5,
            "responder" => 11,
            "status" => "disconnected"
        ]);

        Connection::create([
            "requester" => 11,
            "responder" => 6,
            "status" => "pending"
        ]);

        Connection::create([
            "requester" => 7,
            "responder" => 11,
            "status" => "disconnected"
        ]);

        Connection::create([
            "requester" => 11,
            "responder" => 8,
            "status" => "pending"
        ]);

        Connection::create([
            "requester" => 9,
            "responder" => 11,
            "status" => "pending"
        ]);

        Connection::create([
            "requester" => 11,
            "responder" => 12,
            "status" => "pending"
        ]);

        Connection::create([
            "requester" => 13,
            "responder" => 11,
            "status" => "pending"
        ]);

        Connection::create([
            "requester" => 11,
            "responder" => 14,
            "status" => "disconnected"
        ]);
    }
}
