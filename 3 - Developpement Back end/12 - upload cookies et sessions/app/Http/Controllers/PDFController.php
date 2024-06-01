<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use PDF;
use App\Models\Product;
class PDFController extends Controller
{
    public function generatePDF()
    {
        $logo = 'storage/logos/logo.png';

        $products = Product::all();
        $data = [
            'title' => 'impression avec DOMPDF',
            'products' => $products,
            'logo' => $logo,
        ];

        $pdf = PDF::loadView('pdf.document', $data)->setPaper('a4', 'landscape');
        return $pdf->download('document.pdf');
    }
}
