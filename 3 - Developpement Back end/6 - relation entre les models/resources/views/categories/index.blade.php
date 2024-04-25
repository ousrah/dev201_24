<table>
    <tr>
        <th>Id</th>
        <th>Title</th>
    </tr>
    @foreach ( $categories as $category )
        <tr>
            <td>{{ $category->id }}</td>
            <td>{{ $category->title }}</td>
            <td>
                <select>

                    @foreach ( $category->products as $product )
                        <option value="{{ $product->id }}">{{ $product->title }}</option>

                    @endforeach
                    </select>
            </td>


        </tr>

    @endforeach
</table>
