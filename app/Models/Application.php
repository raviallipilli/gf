<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Carbon;

class Application extends Model
{
    use HasFactory;

    // Mass assignable attributes
    protected $fillable = ['user_id', 'charity_id', 'date_created', 'stage'];

    /**
     * Get the user that owns the application.
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Get the charity that the application is for.
     */
    public function charity()
    {
        return $this->belongsTo(Charity::class);
    }

    /**
     * Get the roles associated with the application.
     */
    public function roles()
    {
        return $this->hasMany(UserRole::class);
    }

    /**
     * Determine if the application can be moved forward.
     * 
     * @return bool
     */
    public function canBeMovedForward()
    {
        $charity = $this->charity;
        $isPast = $this->date_created <= Carbon::now();
        
        // Application can be moved forward if it is in the past, charity is approved, and located in GBR
        return $isPast && $charity->country->country_code === 'GBR' && $charity->is_approved;
    }

    /**
     * Determine if the application can be moved backward.
     * 
     * @return bool
     */
    public function canBeMovedBackward()
    {
        // Application can be moved backward if the charity is located in GBR
        return $this->charity->country->country_code === 'GBR';
    }
}
