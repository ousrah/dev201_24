<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;

class ProductController extends Controller
{
   public function index()
   {
    $products = Product::all();
    return view('products.index', compact('products'));
   }


   public function test()
   {

    return "ok";
   }


   public function search()
   {
        $word = request()->input('search');

        $products = Product::where('name','like','%'. $word .'%')
        ->orWhere ('description','like','%'. $word .'%')//;
     //   dd($products->toSql(),$products->getBindings());
        ->get();
        return view('products.index', compact('products'));

   }
}
