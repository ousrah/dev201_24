<?php

namespace App\Imports;

use App\Models\Article;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;

class ArticlesImport implements ToModel, WithHeadingRow
{
    /**
    * @param array $row
    *
    * @return \Illuminate\Database\Eloquent\Model|null
    */
    public function model(array $row)
    {
        return new Article([
           'id' => $row['id'],
           'title' => $row['title'],
           'description' => $row['description'],
           'image' => $row['image'],
           'user_id' => $row['user_id'],
        ]);

    }
}
