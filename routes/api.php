<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ApiController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->group(function () {
    Route::put('/{id}/forward-application', [ApiController::class, 'forwardApplication']);
    Route::put('/{id}/backward-application', [ApiController::class, 'backwardApplication']);
    Route::put('/{id}/approve-application', [ApiController::class, 'approveApplication']);
});
// if we need testing these endpoints with token then they need to go inside sanctum call orthwise we can use the id from the url
Route::post('/create-application', [ApiController::class, 'createApplication']);
Route::get('/{id}/see-reports', [ApiController::class, 'seeReports']);
