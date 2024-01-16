<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasOne;

class UserPrompt extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'prompt'
    ];

    public function response_to_user_prompt() : HasOne{
        return $this -> hasOne(AiResponse::class, 'user_prompt_id');
    }
}
