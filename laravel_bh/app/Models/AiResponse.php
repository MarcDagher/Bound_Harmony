<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class AiResponse extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_prompt_id',
        'response'   
    ];

    // user_prompt_id inside AiResponse references to the UserPrompt
    public function user_prompt() : BelongsTo{
        return $this -> belongsTo(UserPrompt::class, 'user_prompt_id');
    }
}
