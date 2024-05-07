<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProductController;


/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('/products/index', [ProductController::class, 'index'])->name('products.index');
Route::post('/products/search', [ProductController::class, 'search'])->name('products.search');
Route::get('/products/test', [ProductController::class, 'test'])->name('products.test');
