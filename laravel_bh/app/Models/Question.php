<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Question extends Model
{
    use HasFactory;

    protected $fillable = [
        'question',
        'survey_id',
        'question_type'
    ];

    protected $hidden = [
        'updated_at',
        'created_at'
    ];

    // one to one relation with Surveys table - one question belongs to one specific survey
    // foreign key in Question represents Survey
    public function survey() : BelongsTo {
        return $this -> belongsTo(Survey::class, 'survey_id');
    }

    // foreign key questions inside Options table
    public function options() : HasMany {
        return $this -> hasMany(Option::class, 'question_id');
    }

    // foreign key questions in Survey Responses table
    public function survey_responses() : HasMany {
        return $this -> hasMany(SurveyResponse::class, 'question_id');
    }
}
