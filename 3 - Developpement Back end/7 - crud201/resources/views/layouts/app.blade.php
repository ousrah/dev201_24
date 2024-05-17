<html
@if(app()->getLocale() == "ar") dir=rtl @endif
lang="{{ str_replace('_', '-', app()->getLocale()) }}"
>

<head>
    <title>Product Management</title>
        @vite(['resources/css/app.css','resources/js/app.js'])
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <!-- Fonts -->
        <link rel="preconnect" href="https://fonts.bunny.net">
        <link href="https://fonts.bunny.net/css?family=figtree:400,600&display=swap" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

                @yield('styles')
</head>
<body>

<table style='background-color:white;width:90%;margin:auto'>
    <tr>
        <td>
            <select name="lstLangues" id="lstLangues">
                <option @if(app()->getLocale() == "en") selected @endif value="en">Anglais</option>
                <option @if(app()->getLocale() == "fr") selected @endif value="fr">Français</option>
                <option @if(app()->getLocale() == "es") selected @endif value="es">Espagnole</option>
                <option @if(app()->getLocale() == "ar") selected @endif value="ar">Arabe</option>
            </select>

            @lang("Student") </td>
    </tr>
    <tr style="height: 150px; vertical-align:top;">
        <td>
            @yield('content')
        </td>
    </tr>
    <tr>
        <td>CopyRights &copy; 2024 Alla rights reserved ...</td>
    </tr>
</table>

<script>
    $("#lstLangues").on("change",function(){
        var locale = $(this).val();
        window.location.href = "/changeLocale/"+locale;
    })
</script>

    @yield('scripts')
</body>
</html>
