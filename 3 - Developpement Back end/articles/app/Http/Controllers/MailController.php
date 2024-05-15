<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Mail;
use App\Mail\DemoMail;
class MailController extends Controller
{
    public function index()
    {
        $mailData = [
            'title' => 'hi freinds',
            'body' => 'This is for testing email using smtp.'
        ];

        Mail::to('ousrah@hotmail.com')->send(new DemoMail($mailData));

        dd("Email is sent successfully.");
    }
}
