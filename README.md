# GivingForce - Task

-----------------------------------------------------------------------------------------

## Author: Ravi Allipilli

-----------------------------------------------------------------------------------------

## Project Overview

GivingForce is a CRUD API designed to manage applications for GivingForce. It also includes front-end views for two tasks and provides full unit test coverage for all endpoints.

-----------------------------------------------------------------------------------------

### Project Requirements

The main requirements of the project are as follows:

1. Develop an application model:
   - Create an Application model representing user applications.
   - Each application should belong to a user with the employee role.
   - Applications should have an associated charity, a past creation date, and a stage property representing different stages.

2. Develop an endpoint to create an application:
   - Implement an endpoint to create applications based on the specified details.

3. Write methods for validating user actions:
   - Develop methods to validate user permissions for actions such as moving an application, approving a charity, seeing reports, and creating an application.

4. Write a method for validating application movement:
   - Implement a method to validate whether an application can be moved forward or backward based on certain conditions.

5. Develop an endpoint for progressing an application:
   - Create an endpoint allowing admin users with the appropriate permissions to move applications between stages.
   - Validate user permissions and application movement using the previously developed methods.

6. Bonus task: Use AJAX to access an endpoint:
   - Utilize JavaScript (Vanilla, React, or jQuery) to access one of the API endpoints for additional functionality.

-----------------------------------------------------------------------------------------

## Getting Started

### Prerequisites

- PHP version 8.1
- Laravel version 10.10
- XAMPP or WAMP server

-----------------------------------------------------------------------------------------

### Installation

1. Clone the project repository.
2. Run the migration command to set up the database.
3. Start your XAMPP or WAMP server.
4. Test the APIs using the provided endpoints.

-----------------------------------------------------------------------------------------

## Endpoints

### Public Endpoints (No Authentication Required)

1 - POST http://127.0.0.1:8000/api/create-application
  - Creates a new application.
  - Parameters:
    - user_id (int): User ID of the customer.
    - charity_id (int): Charity ID associated with the application.
  - Example: http://127.0.0.1:8000/api/create-application

-----------------------------------------------------------------------------------------

2 - GET http://127.0.0.1:8000/api/{id}/see-reports
  - Retrieves reports for a specific user.
  - Parameters:
    - id (int): User ID.
  - Example: http://127.0.0.1:8000/api/1/see-reports

-----------------------------------------------------------------------------------------

### Authenticated Endpoints (Require Sanctum Authentication)

All authenticated endpoints require authentication via Sanctum. Make sure to include the authentication token in the request headers.

3 - PUT http://127.0.0.1:8000/api/{id}/forward-application
  - Moves an application forward to the next stage.
  - Parameters:
    - id (int): Application ID.
  - Example: http://127.0.0.1:8000/api/1/forward-application

-----------------------------------------------------------------------------------------

4 - PUT http://127.0.0.1:8000/api/{id}/backward-application
  - Moves an application backward to the previous stage.
  - Parameters:
    - id (int): Application ID.
  - Example: http://127.0.0.1:8000/api/1/backward-application

-----------------------------------------------------------------------------------------

5 - PUT http://127.0.0.1:8000/api/{id}/approve-application
  - Approves an application.
  - Parameters:
    - id (int): Application ID.
  - Example: http://127.0.0.1:8000/api/1/approve-application

-----------------------------------------------------------------------------------------

## Setup token using sanctum

- composer require laravel/sanctum

-----------------------------------------------------------------------------------------

## Token Generation

1. On the terminal run `php artisan tinker`.
2. `$user = App\Models\User::find(5);` // Admin User ID    
3. `$token = $user->createToken('API Token')->plainTextToken;`  
       = "5|xoTeSaHnDp7GsNgobpabGg4fCvXpaEUEd0ghHPZN" 
4. Use the token to test it on Postman Authorization as Bearer Token.

-----------------------------------------------------------------------------------------

### Front-End Views

Front-end views are available for two endpoints:

- [Create Application](http://127.0.0.1:8000/api/create-application)
- [See Reports](http://127.0.0.1:8000/api/1/see-reports) 

Note: The front-end design is simple and focuses on AJAX calls, hence it may not be visually appealing.

-----------------------------------------------------------------------------------------

### Database Relationships

+-----------------+                +------------------+
|      User       |<------------->|     UserRole     |
|-----------------|  (One-to-Many)|------------------|
| id              |<------------->| id               |
| name            |                | user_id          |
| email           |                | role             |
| ...             |                | ...              |
+-----------------+                +------------------+
       |
       |
(One-to-Many)
       |
       v
+-----------------+                +-----------------+
|  Application    |<------------->|     Charity     |
|-----------------|  (Many-to-One)|-----------------|
| id              |<------------->| id              |
| user_id         |                | name            |
| charity_id      |                | country_id      |
| date_created    |                | is_approved     |
| stage           |                | ...             |
| ...             |                +-----------------+
+-----------------+
       |
       |
(Many-to-One)
       |
       v
+-----------------+
|    Country      |
|-----------------|
| id              |
| country_name    |
| ...             |
+-----------------+

-----------------------------------------------------------------------------------------

#### Note

Lavarel doesn't support custom id creation, hence I have modified the original schema which was provided to me with default laravel primay id coulmns to id()  for all tables and it should still give us the same return data. 
For reference use \database\migrations\ folders . I have also included the sql file in the project folder

-----------------------------------------------------------------------------------------

## Usage

1. Access the provided endpoints using the appropriate HTTP methods.
2. For authenticated endpoints, include the authentication token in the request headers (e.g., Bearer Token in Postman).

-----------------------------------------------------------------------------------------

## Testing

Run the Laravel test command to execute all unit tests and ensure code coverage.

- `php artisan test`

-----------------------------------------------------------------------------------------

### Unit Testing

For testing purpose factories are created for each model and a seperate test databse referenced on .env-testing

-----------------------------------------------------------------------------------------

----------------------------------------Happy Coding--------------------------------------
