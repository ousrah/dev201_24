@extends('layouts.app')

@section('styles')

<style>
    #lstProducts{
        width:80%;
    }



    </style>

@endsection
@section('content')


<div class='max-w-md mx-auto'>
    <div class="relative flex items-center w-full h-12 rounded-lg focus-within:shadow-lg bg-white overflow-hidden">
        <div class="grid place-items-center h-full w-12 text-gray-300">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
            </svg>
        </div>
    <form method="post"  id="searchForm" >
       @csrf
        <input
        class="peer h-full w-full outline-none text-sm text-gray-700 pr-2"
        type="text"
        id="search"
        name="search"
        placeholder="Search something.." />



    </form>  <button id="btnSearch" class="bg-blue-500 text-white py-2 px-4 ">
            Search
        </button>
    </div>
</div>

<div id="divResult">

    <table id="lstProducts">
    <tr>
        <th class="bg-black text-white font-bold w-8">#</th>
        <th class="bg-black text-white font-bold w-24">Name</th>
        <th class="bg-black text-white font-bold w-48">Description</th>
        <th class="bg-black text-white font-bold w-12">Action</th>
    </tr>
    @foreach ($products as $product)
        <tr>
            <td>{{ $product->id}}</td>
            <td>{{ $product->name}}</td>
            <td>{!! $product->description !!}</td>
            <td>
    <button class="btnShow bg-blue-500 hover:bg-blue-400 text-white font-bold py-2 px-4 border-b-4 border-blue-700 hover:border-blue-500 rounded" v="{{$product->id}}">Show</button>
    <button class="btnEdit bg-green-500 hover:bg-green-400 text-white font-bold py-2 px-4 border-b-4 border-green-700 hover:border-green-500 rounded" v="{{$product->id}}">Edit</button>
    <button class="btnDelete bg-red-500 hover:bg-red-400 text-white font-bold py-2 px-4 border-b-4 border-red-700 hover:border-red-500 rounded" v="{{$product->id}}">Delete</button>


            </td>
        </tr>
    @endforeach



    </table>


</div>


@endsection

@section('scripts')
    <script>
        $(document).ready(function() {
                $(".btnShow").on('click',function(){
                    var product_id = $(this).attr('v');
                    alert(product_id);
            })

$("#btnSearch").on('click',function(){

    $.ajax({
        url: "{{ route('products.test')}}",
        success: function(data) {
            $("#divResult").html(data);
        }
    });

})
        })
    </script>
@endsection
