<!DOCTYPE html>
<html>
<head>
    <title>{{ $title }}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.16/tailwind.min.css" integrity="sha512-h+jxHd1kXOv1UbYfS8+kZXRwACrzoi2Lvc4hHa4Jbb4xGd7yXHlGgYzq3KjMkVt+ZABsTynT7iC2Q1yV7skacQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
    <img src = "{{ public_path($logo) }}" class="w-24" />
     <h1>{{ $title }}</h1>
    <p>This PDF document is generated using domPDF in Laravel.</p>

<table class="border border-lg">
<tr class="border border-lg">
    <th class="border border-lg">#</th>
    <th class="border border-lg">@lang('name')</th>
    <th class="border border-lg">@lang('description')</th>
</tr>
@foreach ($products as $product)
    <tr class="border border-lg">
        <td class="border border-lg p-2">{{$product->id}}</td>
        <td class="border border-lg p-2">{{$product->name}}</td>
        <td class="border border-lg p-2">{!! $product->description  !!}</td>
    </tr>
@endforeach
</table>

</body>
</html>
