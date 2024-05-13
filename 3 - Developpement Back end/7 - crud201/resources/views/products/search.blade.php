<table id="lstProducts">
    <tr>
        <th class="bg-black text-white font-bold w-8">#</th>
        <th class="bg-black text-white font-bold w-24">@lang('Name')</th>
        <th class="bg-black text-white font-bold w-48">@lang('Description')</th>
        <th class="bg-black text-white font-bold w-12">@lang('Action')</th>
    </tr>
    @foreach ($products as $product)
        <tr id="row{{$product->id}}">
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
<script>
    $(document).on('click',".btnShow",function(){
        var product_id = $(this).attr('v');
        var myData = {'product_id': product_id};
        var url = '{{ route('products.show') }}';

        axios.post(url, myData)
        .then(response => {
                $("#showProduct").html(response.data);
                $("#myModalShowProduct").show();
        })
        .catch(error => {
            console.log(error);
        });
    })


    $(document).on("click",".btnDelete",function(){
        $("#txtId").val($(this).attr('v'));
        $("#myModalDeleteProduct").show();
    })
</script>
