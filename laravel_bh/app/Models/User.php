<?php

namespace App\Models;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use PHPOpenSourceSaver\JWTAuth\Contracts\JWTSubject;

class User extends Authenticatable implements JWTSubject
{
    use HasFactory, SoftDeletes, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'username',
        'email',
        'password',
        'birthdate',
        'location',
        'profile_pic_url',
        'connection_status',
        'couple_survey_status',
        'personal_survey_status'
    ];

    

    // one to one relation with roles table - one user belongs to one role
    // foreign key in User represents Role
    public function role() : BelongsTo
    {
        return $this->belongsTo(Role::class, 'role_id');
    }
    
    public function responder_user() : HasMany{
        return $this -> hasMany(Connection::class, 'responder');
    }

    public function requester_user() : HasMany{
        return $this -> hasMany(Connection::class, 'requester');
    }

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
        'created_at', 
        'updated_at'
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

     /**
     * Get the identifier that will be stored in the subject claim of the JWT.
     *
     * @return mixed
     */
    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    /**
     * Return a key value array, containing any custom claims to be added to the JWT.
     *
     * @return array
     */
    public function getJWTCustomClaims()
    {
        return [
            'username' => $this -> username,
            'role_id' => $this -> role_id,
            'email' => $this -> email,
            'birthdate' => $this -> birthdate,
            'location'=> $this -> location,
            'image' => $this -> image,
            'connection status' => $this -> connection_status,
            'couple survey status' => $this -> couple_survey_status
        ];
    }

}