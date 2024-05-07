<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title> {{ env('APP_NAME') }} </title>


        <link rel="preconnect" href="https://fonts.bunny.net">
        <link href="https://fonts.bunny.net/css?family=figtree:400,600&display=swap" rel="stylesheet" />
@vite(['resources/css/app.css', 'resources/js/app.js'])

        <!-- Styles -->

    </head>
    <body >
        <h1>ismo</h1>
        bonjour
        <p>welcome </p>
<a href="{{ route('listeDesProduits') }}">
        gestion des produits
    </a>
    </body>
</html>
