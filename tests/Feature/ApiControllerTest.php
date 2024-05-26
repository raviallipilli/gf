<?php

namespace Tests\Feature;

use App\Models\User;
use App\Models\Application;
use App\Models\Charity;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Illuminate\Http\Response;
use Tests\TestCase;
use Illuminate\Support\Carbon;
use Laravel\Sanctum\PersonalAccessToken;

class ApiControllerTest extends TestCase
{
    use DatabaseTransactions;

    public function testCreateApplication()
    {    
        // Test for missing fields
        $response = $this->postJson('/api/create-application', []);
        $response->assertJson([
            'status' => 'Unauthorized',
            'message' => 'Unauthorized! User Not Found'
        ])->assertStatus(Response::HTTP_UNAUTHORIZED);
    
        // Create an application
        $response = $this->postJson('/api/create-application', [
            'user_id' => 2,
            'charity_id' => 7
        ]);
    
        $response->assertJson([
            'status' => Response::$statusTexts[Response::HTTP_CREATED],
            'success' => true,
            'message' => 'Application Created Successfully',
            'endpoint' => 'http://localhost/api/create-application',
        ])->assertStatus(Response::HTTP_CREATED);
    
        // Verify that the application was created
        $application = Application::where('user_id', 2)
                                  ->where('charity_id', 7)
                                  ->firstOrFail();
    
        // Test for duplicate application
        $response = $this->postJson('/api/create-application', [
            'user_id' => $application->user_id,
            'charity_id' => $application->charity_id
        ]);
    
        $response->assertJson([
            'message' => 'Application with User already exists for this charity'
        ])->assertStatus(Response::HTTP_CONFLICT);
    
        // Clean up
        $application->delete($application->id);
    }

    public function testForwardApplication()
    {
        // Create user, charity, and application
        $user = User::factory()->withRole('admin_applications')->create();
        $charity = Charity::factory()->create(['is_approved' => true, 'country_id' => 223]);
        $application = Application::factory()->create([
            'user_id' => $user->id,
            'charity_id' => $charity->id,
            'stage' => 'Allow to Proceed',
            'date_created' => Carbon::now()->subDays(1),
        ]);

        // Create a token for admin user
        $adminUser = User::find(4); // admin_reports
        $token = $adminUser->createToken('test-token')->plainTextToken;

        // Send request to forward application
        $response = $this->withHeaders([
            'Authorization' => 'Bearer ' . $token,
            'Accept' => 'application/json',
        ])->put("/api/{$application->id}/forward-application");

        // Assert response
        $response->assertJson([
            'status' => Response::$statusTexts[Response::HTTP_OK],
            'success' => true,
            'message' => 'Application moved to Paid stage',
            'endpoint' => 'http://localhost/api/'.$application->id.'/forward-application',
        ])->assertStatus(Response::HTTP_OK);

        // Assert database state
        $this->assertDatabaseHas('applications', [
            'id' => $application->id,
            'stage' => 'Paid'
        ]);
    }

    public function testBackwardApplication()
    {
        // Create user, charity, and application
        $user = User::factory()->withRole('admin_applications')->create();
        $charity = Charity::factory()->create(['is_approved' => true, 'country_id' => 223]);
        $application = Application::factory()->create([
            'user_id' => $user->id,
            'charity_id' => $charity->id,
            'stage' => 'Paid',
        ]);

        // Create a token for admin user
        $adminUser = User::find(4); // admin_reports
        $token = $adminUser->createToken('test-token')->plainTextToken;

        // Send request to backward application
        $response = $this->withHeaders([
            'Authorization' => 'Bearer ' . $token,
            'Accept' => 'application/json',
        ])->put("/api/{$application->id}/backward-application");

        // Assert response
        $response->assertJson([
            'status' => Response::$statusTexts[Response::HTTP_OK],
            'success' => true,
            'message' => 'Application moved to the Backward stage',
            'endpoint' => 'http://localhost/api/'.$application->id.'/backward-application',
        ])->assertStatus(Response::HTTP_OK);

        // Assert database state
        $this->assertDatabaseHas('applications', [
            'id' => $application->id,
            'stage' => 'Allow to Proceed'
        ]);
    }

    public function testApproveApplication()
    {
        // Create user, charity, and application
        $user = User::factory()->withRole('admin')->create();
        $charity = Charity::factory()->create(['is_approved' => false]);
        $application = Application::factory()->create([
            'user_id' => $user->id,
            'charity_id' => $charity->id,
        ]);

        // Create a token for admin user
        $adminUser = User::find(4); // admin_reports
        $token = $adminUser->createToken('test-token')->plainTextToken;

        // Send request to approve application
        $response = $this->withHeaders([
            'Authorization' => 'Bearer ' . $token,
            'Accept' => 'application/json',
        ])->put("/api/{$application->id}/approve-application");

        // Assert response
        $response->assertJson([
            'status' => Response::$statusTexts[Response::HTTP_OK],
            'success' => true,
            'message' => 'Charity is Approved',
            'endpoint' => 'http://localhost/api/'.$application->id.'/approve-application',
        ])->assertStatus(Response::HTTP_OK);

        // Assert database state
        $this->assertDatabaseHas('charities', [
            'id' => $charity->id,
            'is_approved' => true,
        ]);
    }

    public function testSeeReports()
    {
        // Create user, charity, and application
        $user = User::factory()->withRole('admin_reports')->create();
        $charity = Charity::factory()->create();
        Application::factory()->create(['user_id' => $user->id, 'charity_id' => $charity->id]);

        // Send request to see reports
        $response = $this->actingAs($user)->get("/api/{$user->id}/see-reports");

        // Assert response
        $response->assertJson([
            'success' => true,
            'message' => 'User is allowed to see the Reports',
        ])->assertStatus(Response::HTTP_OK);

        // Send request with different user
        $userData = User::factory()->create();
        $response = $this->actingAs($user)->get("/api/{$userData->id}/see-reports");

        // Assert response
        $response->assertJson([
            'message' => 'Forbidden! Only user permissions with Admin Applications can access reports',
        ])->assertStatus(Response::HTTP_FORBIDDEN);
    }
}
