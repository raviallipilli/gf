<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use Notifiable, HasApiTokens, HasFactory;

    // Mass assignable attributes
    protected $fillable = [
        'name',
        'email'
    ];

    /**
     * Get the user roles associated with the user.
     */
    public function userRoles()
    {
        return $this->hasMany(UserRole::class);
    }

    /**
     * Check if the user has a specific role.
     * 
     * @param string $role
     * @return bool
     */
    public function hasRole($role)
    {
        return $this->userRoles()->where('role', $role)->exists();
    }

    /**
     * Determine if the user can create an application.
     * 
     * @return bool
     */
    public function canCreateApplication()
    {
        // User can create an application if they have the 'employee' role
        return $this->hasRole('employee');
    }

    /**
     * Determine if the user can move an application.
     * 
     * @return bool
     */
    public function canMoveApplication()
    {
        // User can move an application if they have the 'admin_applications' role
        return $this->hasRole('admin_applications');
    }

    /**
     * Determine if the user can approve a charity.
     * 
     * @return bool
     */
    public function canApproveCharity()
    {
        // User can approve a charity if they have the 'admin' role
        return $this->hasRole('admin');
    }

    /**
     * Determine if the user can see reports.
     * 
     * @return bool
     */
    public function canSeeReports()
    {
        // User can see reports if they have the 'admin_reports' role
        return $this->hasRole('admin_reports');
    }
}
