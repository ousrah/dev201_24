<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Laravel</title>
        @vite(["resources/js/app.js","resources/css/app.css"])
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <!-- Fonts -->
        <link rel="preconnect" href="https://fonts.bunny.net">
        <link href="https://fonts.bunny.net/css?family=figtree:400,600&display=swap" rel="stylesheet" />


    </head>
    <body class="antialiased">
<button id="btn">Test</button>


<form method="POST" action="{{route("saveAvatar")}}"  enctype="multipart/form-data" >
    @csrf
<label for="avatarFile">{{__('Choose your picture')}}</label>
<input type="file" id = "avatarFile"  name = "avatarFile" />
<button class="btn btn-primary bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
{{__('Save picture') }}
  </button>
<img style = "width:200px; border-radius:50%" src="{{"storage/avatars/".$pic}}" alt="">
</form>



<div>


    Hello
@if(Cookie::has("CookieName"))
        {{Cookie::get("CookieName")}}
@endif

<form method="POST" action="{{ route('saveCookie') }}" id="saveCookie">
@csrf
<label for="txtCookie">{{__('Type your name')}}</label>
<input type="text" id = "txtCookie" name = "txtCookie" />
<button class="btn btn-primary bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
{{__('Save Cookie') }}
</button>
</form>
</div>

<div>
Hello
@if(Session::has("SessionName"))
        {{Session("SessionName")}}
@endif
<form method="POST" action="{{route('saveSession')}}">
@csrf
<label for="txtSession">{{__('Type your name')}}</label>
<input type="text" id = "txSession" name = "txtSession" />
<button class="btn btn-primary bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
{{__('Save Session') }}
</button>
</form>

</div>




    </body>
</html>
