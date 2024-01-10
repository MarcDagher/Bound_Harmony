<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class SurveyResponse extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'question_id',
        'option_id',
    ];

    // foreign key in SurveyResponse belongs to User
    public function user() : BelongsTo{
        return $this -> belongsTo(User::class);
    }
}
