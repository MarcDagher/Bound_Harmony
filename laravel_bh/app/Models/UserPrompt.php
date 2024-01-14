<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class UserPrompt extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'prompt'
    ];

    // user_id is the foreign key in UserPrompt that references to User
    public function user_of_the_prompt() : BelongsTo {
        return $this -> belongsTo(User::class, 'user_id');
    }
}
