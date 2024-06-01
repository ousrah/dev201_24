<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\PDFController;
use App\Http\Controllers\Auth\AuthController;


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

    $pic = Auth()->user()->avatar;
    return view('welcome', compact('pic'));
});


Route::middleware(['auth'])->group(function(){
    Route::get('/products', [ProductController::class, 'index'])->name('products.index');
    Route::post('/products/search', [ProductController::class, 'search'])->name('products.search');
    Route::post('/products/show', [ProductController::class, 'show'])->name('products.show');
    Route::post('/products/delete', [ProductController::class, 'delete'])->name('products.delete');
    Route::get('/generate-pdf', [PDFController::class, 'generatePDF'])->name('generate-pdf');
    Route::get('dashboard', [AuthController::class, 'dashboard']);
});

Route::post("/saveAvatar", [HomeController::class, 'saveAvatar'])->name("saveAvatar");
Route::post("/saveCookie", [HomeController::class, 'saveCookie'])->name("saveCookie");
Route::post("/saveSession", [HomeController::class, 'saveSession'])->name("saveSession");





Route::get('/changeLocale/{locale}',function($locale){
    session()->put('locale',$locale);
    return redirect()->back();
})->name('products.changeLocale');



Route::get('login', [AuthController::class, 'index'])->name('login');
Route::post('post-login', [AuthController::class, 'postLogin'])->name('login.post');
Route::get('registration', [AuthController::class, 'registration'])->name('register');
Route::post('post-registration', [AuthController::class, 'postRegistration'])->name('register.post');
Route::get('logout', [AuthController::class, 'logout'])->name('logout');
