<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Carbon;
use App\Models\Application;

class ApplicationFactory extends Factory
{
    protected $model = Application::class;

    public function definition()
    {
        return [
            'user_id' => \App\Models\User::factory(),
            'charity_id' => \App\Models\Charity::factory(),
            'date_created' => Carbon::now()->subDays(rand(1, 30)),
            'stage' => $this->faker->randomElement(['Organisation Approval', 'Allow to Proceed', 'Paid']),
        ];
    }
}

