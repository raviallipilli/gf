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
        <div>
            <label for="user_id">User ID</label>
            <input type="text" id="user_id" required>
        </div>
        <div>
            <label for="charity_id">Charity ID</label>
            <input type="text" id="charity_id" required>
        </div>
        <div><button onclick="createApplication()">Create Application</button></div>
    </div>

    <script src="app.js"></script>
</body>
</html>
