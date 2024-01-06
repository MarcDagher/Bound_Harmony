<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Connection extends Model
{
    use HasFactory;

    protected $fillable = [
        'requester',
        'responder',
        'status'
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
