<html>
    <head>
        <title></title>
        @yield("styles")
    </head>
    <body>
        <table style="margin:auto;width:90%;border:1px solid black">
            <tr>
                <td>Menu</td>
            </tr>
            <tr style="height:500px">
                <td>  @yield('content')</td>
            </tr>
            <tr>
                <td>Footer</td>
            </tr>

        </table>

    @yield('scripts')

    </body>
</html>
