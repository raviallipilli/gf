<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use App\Models\Charity;

class CharityFactory extends Factory
{
    protected $model = Charity::class;

    public function definition()
    {
        return [
            'charity_name' => $this->faker->company,
            'is_approved' => $this->faker->boolean,
            'country_id' => \App\Models\Country::factory(),
        ];
    }
}
