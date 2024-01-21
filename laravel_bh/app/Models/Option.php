<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Option extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'option',
        'question_id'
    ];

    protected $hidden = [
        'updated_at',
        'created_at'
    ];

    public function survey_responses() : HasMany{
        return $this -> hasMany(SurveyResponse::class, 'option_id');
    }
}
