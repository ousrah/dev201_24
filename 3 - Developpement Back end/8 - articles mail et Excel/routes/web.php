<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ArticleController;
use App\Http\Controllers\MailController;
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

Route::get('/mailing', [ArticleController::class, 'mailing'])->name("mailing");
Route::get('send-mail', [MailController::class, 'index']);


Route::controller(ArticleController::class)->group(function(){
    Route::get('articles', 'index')->name('articles.index');
    Route::get('articles-export', 'export')->name('articles.export');
    Route::post('articles-import', 'import')->name('articles.import');
});
