@extends('layouts.app')

@section('styles')
    <style>
        #lstProducts{
        width:80%;
        }
    </style>
@endsection
@section('content')

<div id="showProduct">
    {{-- code de la fenetre modale --}}


</div>
<div class='max-w-md mx-auto'>
    <div class="relative flex items-center w-full h-12 rounded-lg focus-within:shadow-lg bg-white overflow-hidden">
        <div class="grid place-items-center h-full w-12 text-gray-300">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
            </svg>
        </div>
        <form id="searchForm" onsubmit="return submitForm(event)" >
            @csrf
            <input  class="peer h-full w-full outline-none text-sm text-gray-700 pr-2"
            type="text"  id="search" name="search" placeholder="Search something.." />
        </form>
    </div>
</div>

<div id="divResult">
    @include('products.search')
</div>

<div id="divDelete">
    @include('products.delete')
</div>


@endsection

@section('scripts')
    <script>
    function submitForm(event){
        event.preventDefault();
        var formData = $('#searchForm').serialize();
        var url = "{{ route('products.search')}}"   //  $("#searchForm").attr("action");

         //troisième methode de recherche sans actualisation de la page avec axios
        axios.post(url, formData)
        .then(response => {
                $("#divResult").html(response.data);
        })
        .catch(error => {
            console.log(error);
        });



 /*
 //deuxième methode de recherche sans actualisation de la page avec ajax
 $.ajax({
            type:'POST',
            url: url,
            data:formData,
            success: function(data) {
                $("#divResult").html(data);
            }
            error: function(error) {
                console.log(error);
            }
    });
*/




    }

/*
// soit vous traitez le clique ici avec $(document) ou avec $('.btnShow') dans la partial view products.search

    $(document).on('click',".btnShow",function(){
                    var product_id = $(this).attr('v');
                    alert(product_id);
            })
*/
        $(document).ready(function() {

/*

//première methode de recherche avec actualisation de la page sans ajax ou axios
            $("#btnSearch").on('click',function(){
                $.ajax({
                    url: "/products/test",
                    success: function(data) {
                        $("#divResult").html(data);
                    }
                });
            })
*/
        })
    </script>
@endsection
