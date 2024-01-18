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
        Schema::create('survey_responses', function (Blueprint $table) {
            $table -> id();
            $table -> unsignedBigInteger('user_id');
            $table -> unsignedBigInteger('partner_id') -> nullable();
            $table -> unsignedBigInteger('connection_id') -> nullable();
            $table -> unsignedBigInteger('question_id');
            $table -> unsignedBigInteger('option_id');
            $table -> string('text_input') -> nullable();
            $table -> timestamps();

            $table -> foreign('user_id') -> references('id') -> on('users');
            $table -> foreign('question_id') -> references('id') -> on('questions');
            $table -> foreign("option_id") -> references('id') ->on ('options');
            $table -> foreign("partner_id") -> references('id') -> on('users');
            $table -> foreign('connection_id') -> references('id') -> on('connections');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('responses');
    }
};
