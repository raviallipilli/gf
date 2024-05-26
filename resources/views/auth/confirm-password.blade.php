<x-guest-layout>
    <x-auth-card>
        <x-slot name="logo">
            <!-- You can place your logo here -->
        </x-slot>

        <link rel="stylesheet" type="text/css" href="{{ asset('css/app.css') }}">

        <div class="container mx-auto p-4">
            <h1 class="text-2xl font-semibold mb-4">Confirm Password</h1>

            <div class="mb-4 text-sm text-gray-600">
                {{ __('This is a secure area of the application. Please confirm your password before continuing.') }}
            </div>

            <!-- Validation Errors -->
            <x-auth-validation-errors class="mb-4" :errors="$errors" />

            <form method="POST" action="{{ route('password.confirm') }}" class="form-container">
                @csrf

                <!-- Password -->
                <div class="mb-4">
                    <x-label for="password" :value="__('Password')" />
                    <x-input id="password" class="block mt-1 w-full" type="password" name="password" required autocomplete="current-password" />
                </div>

                <div class="flex justify-end mt-4">
                    <button type="submit" class="ml-3 inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                        {{ __('Confirm') }}
                    </button>
                </div>
            </form>
        </div>
    </x-auth-card>
</x-guest-layout>
