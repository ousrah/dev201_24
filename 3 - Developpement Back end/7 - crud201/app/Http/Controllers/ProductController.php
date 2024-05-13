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


   public function show()
   {
    $product_id = request('product_id');
    $product = Product::find($product_id);
    return view ('products.show',compact('product'));
   }


   public function search()
   {
        $word = request('search');
        $products = Product::where('name','like','%'. $word .'%')
        ->orWhere ('description','like','%'. $word .'%')//;
     //   dd($products->toSql(),$products->getBindings());
        ->get();
        return view('products.search', compact('products'));

   }

   public function delete()
   {
        $product_id = request('txtId');
        $product = Product::find($product_id);
        try{
            $product->delete();
            return "ok";

        }
        catch(Exception $e) {
            return "error";
        }


   }

}
