@extends('layouts.app')
@section('styles')
<style>
   body{ background-color:#f3f3f3;
   font-size:22px;}
</style>
@endsection

@section('content')
<table>
    <th>ID</th>
    <th>Title</th>
    <th>Description</th>
    <th>Price</th>
    <th>Image</th>
    <th>Category</th>
    @foreach ($products as $product)
        <tr>
            <td>{{ $product->id }}</td>
            <td>{{ $product->title }}</td>
            <td>{{ $product->description }}</td>
            <td>{{ $product->price }}</td>
            <td><img src="{{ $product->image }}" width="100px" height="100px"></td>
            <td>{{ $product->category->title }}</td>
        </tr>
    @endforeach
</table>

@endsection
