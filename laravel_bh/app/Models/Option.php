<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Option extends Model
{
    use HasFactory;

    protected $fillable = [
        'option',
        'question_id'
    ];

    public function survey_responses() : HasMany{
        return $this -> hasMany(SurveyResponse::class, 'option_id');
    }
}
