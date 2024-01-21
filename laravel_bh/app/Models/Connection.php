<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class Connection extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'requester',
        'responder',
        'status'
    ];

    protected $hidden = [
        'updated_at',
        'created_at'
    ];

    // foreign key requester in Connections table referencing User
    public function requester_user() : BelongsTo {
        return $this -> belongsTo(User::class, 'requester');
    }

    // foreign key responder in Connections table referencing User
    public function responder_user() : BelongsTo {
        return $this -> belongsTo(User::class, 'responder');
    }
}
