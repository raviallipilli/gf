<?php

namespace Database\Factories;

use App\Models\UserRole;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

class UserRoleFactory extends Factory
{
    protected $model = UserRole::class;

    public function definition()
    {
        return [
            'user_id' => User::factory(),
            'role' => $this->faker->randomElement(['employee', 'admin', 'admin_applications', 'admin_reports']),
        ];
    }
}
