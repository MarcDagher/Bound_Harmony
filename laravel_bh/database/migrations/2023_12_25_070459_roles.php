<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // username - email - password - location - virthdate - image - connection_status - couple_survey_status - Roles_id - created_at
        Schema::create('roles', function(Blueprint $table){
            $table -> bigInteger('id') -> primary();
            $table -> string('role');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        //
    }
};
