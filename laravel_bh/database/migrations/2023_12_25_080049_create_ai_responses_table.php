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
        Schema::create('ai_responses', function (Blueprint $table) {
            $table->bigInteger('id')->primary();
            $table->bigInteger('user_prompt_id');
            $table->longText('response');
            $table->timestamps();

            $table->foreign('user_prompt_id')->references('id')->on('user_prompts');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('ai_responses');
    }
};
