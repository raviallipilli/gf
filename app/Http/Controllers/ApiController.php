<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Models\Application;
use App\Models\User;
use App\Models\Charity;
use Illuminate\Support\Carbon;

class ApiController extends Controller
{
    /**
     * Create a new application.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function createApplication(Request $request)
    {        
        // Find the user by ID from the request
        $user = User::find($request->user_id);
        
        // If the user is not found, return a 401 Unauthorized response
        if (!$user) {
            return response()->json([
                'status' => Response::$statusTexts[Response::HTTP_UNAUTHORIZED],
                'message' => 'Unauthorized! User Not Found',
            ], Response::HTTP_UNAUTHORIZED);
        }

        // Find the charity by ID from the request
        $charity = Charity::find($request->charity_id);

        // Check if user and charity both exists
        if (!$charity) {
            return response()->json([
                'status' => Response::$statusTexts[Response::HTTP_BAD_REQUEST],
                'message' => 'Bad Request! Charity does not exist',
            ], Response::HTTP_BAD_REQUEST);
        }

        // Check if the user can create an application (must have 'employee' role)
        if (!$user->canCreateApplication()) {
            return response()->json([
                'status' => Response::$statusTexts[Response::HTTP_FORBIDDEN],
                'message' => 'Forbidden! Only Employees are allowed to create applications',
                'user' => $user,
            ], Response::HTTP_FORBIDDEN);
        }

        // Check for duplicate applications (same user and charity)
        $existingApplication = Application::where('user_id', $request->user_id)
            ->where('charity_id', $request->charity_id)
            ->first();

        // If a duplicate application is found, return a 409 Bad Request response
        if ($existingApplication) {
            return response()->json([
                'status' => Response::$statusTexts[Response::HTTP_CONFLICT],
                'message' => 'Application with User already exists for this charity',
            ], Response::HTTP_CONFLICT);
        }

        // Determine the stage of the application based on whether the charity is approved or not
        $stage = $charity->is_approved ? 'Allow to Proceed' : 'Organisation Approval';

        // Create a new application with the provided data
        $application = Application::create([
            'user_id' => $request->user_id,
            'charity_id' => $request->charity_id,
            'date_created' => Carbon::now(),
            'stage' => $stage,
        ]);

        // Return a 201 Created response with the application details if successfully created
        return response()->json([
            'status' => Response::$statusTexts[Response::HTTP_CREATED],
            'success' => true,
            'message' => 'Application Created Successfully',
            'endpoint' => $request->url(),
        ], Response::HTTP_CREATED);
    }

    /**
     * Move an application forward.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function forwardApplication(Request $request)
    {
        // Get the authenticated user
        $user = $request->user();

        // Check if the user has permission to move applications
        if (!$user->canMoveApplication()) {
            return response()->json([
                'status' => Response::$statusTexts[Response::HTTP_FORBIDDEN],
                'message' => 'Forbidden! Only Admins are allowed to move applications',
                'user' => $user,
            ], Response::HTTP_FORBIDDEN);
        }

        // Find the application by  ID
        $application = Application::where('id', $request->id)->firstOrFail();

        // Check if the application can be moved forward
        if ($application->stage === 'Allow to Proceed' && $application->canBeMovedForward()) {
            // Update the stage to 'Paid' and save
            $application->stage = 'Paid';
            $application->updated_at = Carbon::now();
            $application->save();

            return response()->json([
                'status' => Response::$statusTexts[Response::HTTP_OK],
                'success' => true,
                'message' => 'Application moved to Paid stage',
                'endpoint' => $request->url(),
            ], Response::HTTP_OK);
        }

        // Return a response if the application cannot be moved forward
        return response()->json([
            'status' => Response::$statusTexts[Response::HTTP_ACCEPTED],
            'current_application_stage' => $application->stage,
            'current_user_country' => $application->charity->country->country_name,
            'is_charity_approved' => $application->charity->is_approved ? true : false,
            'description' => 'Cannot move application, only users who are in "UK" are allowed to move with "Allow to Proceed Stage"',
            'message' => 'Application is either not in Allow to Proceed state , charity is approved and user must be in UK, please check the criteria in the description',
            'endpoint' => $request->url(),
            'user' => $user,
            'application_details' => $application,
        ], Response::HTTP_ACCEPTED);
    }

    /**
     * Move an application backward.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function backwardApplication(Request $request)
    {
        // Get the authenticated user
        $user = $request->user();

        // Check if the user has permission to move applications
        if (!$user->canMoveApplication()) {
            return response()->json([
                'status' => Response::$statusTexts[Response::HTTP_FORBIDDEN],
                'message' => 'Forbidden! Only Admin applications users are allowed to move the applications',
                'user' => $user,
            ], Response::HTTP_FORBIDDEN);
        }

        // Find the application by  ID
        $application = Application::where('id', $request->id)->firstOrFail();

        // Check if the application can be moved backward
        if ($application->canBeMovedBackward()) {
            if ($application->stage === 'Paid') {
                $application->stage = 'Allow to Proceed';
            } elseif ($application->stage === 'Allow to Proceed') {
                $application->stage = 'Organisation Approval';
            } else {
                return response()->json([
                    'status' => Response::$statusTexts[Response::HTTP_ACCEPTED],
                    'current_application_stage' => $application->stage,
                    'message' => 'Cannot move application backward any further',
                    'endpoint' => $request->url(),
                    'user' => $user,
                    'application_details' => $application,
                ], Response::HTTP_ACCEPTED);
            }

            $application->updated_at = Carbon::now();
            $application->save();

            return response()->json([
                'status' => Response::$statusTexts[Response::HTTP_OK],
                'success' => true,
                'message' => 'Application moved to the Backward stage',
                'endpoint' => $request->url(),
            ], Response::HTTP_OK);
        }

        // Return a response if the application cannot be moved backward
        return response()->json([
            'status' => Response::$statusTexts[Response::HTTP_BAD_REQUEST],
            'message' => 'Cannot move Application to the Backward stage',
        ], Response::HTTP_BAD_REQUEST);
    }

    /**
     * Approve a charity associated with a user's application.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function approveApplication(Request $request)
    {
        // Get the authenticated user
        $user = $request->user();

        // Check if the user has permission to move applications
        if (!$user->canApproveCharity()) {
            return response()->json([
                'status' => Response::$statusTexts[Response::HTTP_FORBIDDEN],
                'message' => 'Forbidden! Only Admin users are allowed to move the applications',
                'user' => $user,
            ], Response::HTTP_FORBIDDEN);
        }

        // Find the application by user ID
        $application = Application::where('id', $request->id)->first();
        if (!$application) {
            return response()->json([
                'status' => Response::$statusTexts[Response::HTTP_NOT_FOUND],
                'message' => 'Not Found! User does not have an associated application & charity',
                'user' => $user,
            ], Response::HTTP_NOT_FOUND);
        }

        // Find the charity associated with the application
        $charity = Charity::where('id', $application->charity_id)->firstOrFail();
        $charity->is_approved = true;
        $charity->save();

        // Check if the user can approve the charity (must have 'admin' role)
        if ($charity->is_approved) {
            return response()->json([
                'status' => Response::$statusTexts[Response::HTTP_OK],
                'success' => true,
                'message' => 'Charity is Approved',
                'endpoint' => $request->url(),
            ], Response::HTTP_OK);
        }

        // // Return a response if the user does not have permission to approve the charity
        return response()->json([
            'status' => Response::$statusTexts[Response::HTTP_UNAUTHORIZED],
            'message' => 'Only Admins are allowed to approve a Charity',
            'endpoint' => $request->url(),
        ], Response::HTTP_UNAUTHORIZED);
    }

    /**
     * View reports of all applications.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function seeReports(Request $request)
    {
        // Find the user by ID from the request
        $user = User::find($request->id);

        // If the user is not found, return a 401 Unauthorized response
        if (!$user) {
            return response()->json([
                'status' => Response::$statusTexts[Response::HTTP_UNAUTHORIZED],
                'message' => 'Unauthorized! User does not exist',
                'user' => $user,
            ], Response::HTTP_UNAUTHORIZED);
        }

        // Fetch all reports for the user with admin_applications rights
        $reports = Application::with(['user', 'charity'])->get();

        // Check if the user can see the reports (must have 'admin' role)
        if ($user->canSeeReports()) {
            return response()->json([
                'status' => Response::$statusTexts[Response::HTTP_OK],
                'success' => true,
                'message' => 'User is allowed to see the Reports',
                'endpoint' => $request->url(),
                'reports' => $reports,
            ], Response::HTTP_OK);
        }

        // Return a response if the user does not have permission to see the reports
        return response()->json([
            'status' => Response::$statusTexts[Response::HTTP_FORBIDDEN],
            'message' => 'Forbidden! Only user permissions with Admin Applications can access reports',
        ], Response::HTTP_FORBIDDEN);
    }
}
