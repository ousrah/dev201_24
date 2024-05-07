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


<script>

$("#btn").on("click",function(){
    alert("ok");
})

</script>
    </body>
</html>
