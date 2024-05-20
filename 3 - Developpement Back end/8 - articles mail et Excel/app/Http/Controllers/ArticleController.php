<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Article;
use App\Exports\ArticlesExport;
use App\Imports\ArticlesImport;
use Maatwebsite\Excel\Facades\Excel;


class ArticleController extends Controller
{
   public function mailing()
   {


    return view("mailing");
   }

public function index()
{
$articles = Article::all();
return view ('articles.index', compact('articles'));


}

   /**
    * @return \Illuminate\Support\Collection
    */
    public function export()
    {
        return Excel::download(new ArticlesExport, 'articles.xlsx');
    }

    /**
    * @return \Illuminate\Support\Collection
    */
    public function import()
    {
        Excel::import(new ArticlesImport,request()->file('file'));

        return back();
    }

}
