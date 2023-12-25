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
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('role_id');
            $table->string('username');
            $table->string('email');
            $table->string('password');
            $table->date('birthdate');
            $table->string('location')->nullable();
            $table->string('image')->default('no image')->nullable();
            $table->enum('connection_status', ['true', 'false'])->default('false');
            $table->enum('couple_survey_status', ['completed', 'uncompleted'])->default('uncompleted');
            $table->timestamps();
            
            $table->foreign('role_id')->references('id')->on('roles');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('users');
    }
};
