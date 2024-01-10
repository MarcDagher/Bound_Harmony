<?php

namespace Database\Seeders;

use App\Models\Option;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class OptionsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Option::create([ "option" => "no", "question_id" => 1 ]);
        Option::create([ "option" => "yes", "question_id" => 1 ]);

        Option::create([ "option" => "no", "question_id" => 2 ]);
        Option::create([ "option" => "yes", "question_id" => 2 ]);

        Option::create([ "option" => "no", "question_id" => 3 ]);
        Option::create([ "option" => "yes", "question_id" => 3 ]);

        Option::create([ "option" => "no", "question_id" => 4 ]);
        Option::create([ "option" => "yes", "question_id" => 4 ]);

        Option::create([ "option" => "no", "question_id" => 5 ]);
        Option::create([ "option" => "yes", "question_id" => 5 ]);

        Option::create([ "option" => "no", "question_id" => 6 ]);
        Option::create([ "option" => "yes", "question_id" => 6 ]);

        Option::create([ "option" => "no", "question_id" => 7 ]);
        Option::create([ "option" => "yes", "question_id" => 7 ]);

        Option::create([ "option" => "no", "question_id" => 8 ]);
        Option::create([ "option" => "yes", "question_id" => 8 ]);

        Option::create([ "option" => "no", "question_id" => 9 ]);
        Option::create([ "option" => "yes", "question_id" => 9 ]);

        Option::create([ "option" => "no", "question_id" => 10 ]);
        Option::create([ "option" => "yes", "question_id" => 10 ]);

        Option::create([ "option" => "no", "question_id" => 11 ]);
        Option::create([ "option" => "yes", "question_id" => 11 ]);

        Option::create([ "option" => "no", "question_id" => 12 ]);
        Option::create([ "option" => "yes", "question_id" => 12 ]);

        Option::create([ "option" => "no", "question_id" => 13 ]);
        Option::create([ "option" => "yes", "question_id" => 13 ]);

        Option::create([ "option" => "no", "question_id" => 14 ]);
        Option::create([ "option" => "yes", "question_id" => 14 ]);

        Option::create([ "option" => "no", "question_id" => 15 ]);
        Option::create([ "option" => "yes", "question_id" => 15 ]);

        Option::create([ "option" => "no", "question_id" => 16 ]);
        Option::create([ "option" => "yes", "question_id" => 16 ]);

        Option::create([ "option" => "no", "question_id" => 17 ]);
        Option::create([ "option" => "yes", "question_id" => 17 ]);

        Option::create([ "option" => "no", "question_id" => 18 ]);
        Option::create([ "option" => "yes", "question_id" => 18 ]);

        Option::create([ "option" => "no", "question_id" => 19 ]);
        Option::create([ "option" => "yes", "question_id" => 19 ]);

        Option::create([ "option" => "no", "question_id" => 20 ]);
        Option::create([ "option" => "yes", "question_id" => 20 ]);
    }
}
