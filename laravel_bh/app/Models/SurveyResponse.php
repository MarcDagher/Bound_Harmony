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
        'partner_id',
        'option_id',
        'connection_id',
        'survey_id',
        'text_input'
    ];

    protected $hidden = [
        'updated_at',
        'created_at'
    ];

    // foreign key in SurveyResponse belongs to User
    public function user() : BelongsTo{
        return $this -> belongsTo(User::class, 'user_id');
    }

    public function partner() : BelongsTo{
        return $this -> belongsTo(User::class, 'partner_id');
    }

    public function option() : BelongsTo{
        return $this -> belongsTo(Option::class, 'option_id');
    }

    public function question() : BelongsTo{
        return $this -> belongsTo(Question::class, 'question_id');
    }
}
