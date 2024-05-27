<?php
       // Fetch all users and charities
       $users = App\Models\User::all();
       $charities = App\Models\Charity::all();
?>
<!DOCTYPE html>
<html>
<head>
    <title>Create Application</title>
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <link rel="stylesheet" type="text/css" href="app.css">
</head>
<body>
    <div class="container">
        <h1>Create Application</h1>
        <div id="alert" class="alert" style="display: none;"></div>
        
        <!-- User Dropdown -->
        <div>
            <label for="user_id">User</label>
            <select id="user_id" name="user_id" required>
                <option value="">Select a User</option>
                @foreach($users as $user)
                    <option value="{{ $user->id }}">{{ $user->name }}</option>
                @endforeach
            </select>
        </div>

        <!-- Charity Dropdown -->
        <div>
            <label for="charity_id">Charity</label>
            <select id="charity_id" name="charity_id" required>
                <option value="">Select a Charity</option>
                @foreach($charities as $charity)
                    <option value="{{ $charity->id }}">{{ $charity->charity_name }}</option>
                @endforeach
            </select>
        </div>
        <div><button onclick="createApplication()">Create Application</button></div>
    </div>

    <script src="app.js"></script>
</body>
</html>
