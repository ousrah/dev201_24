<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Cookie;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use App\Models\User;

class HomeController extends Controller
{
    public function saveAvatar()
    {
        request()->validate([
         'avatarFile'=>'required|image',
             ]);
        $ext = request()->avatarFile->getClientOriginalExtension();;
        $name = Str::random(30).time().".".$ext;
        request()->avatarFile->move(public_path('storage/avatars'),$name);
        $user = Auth()->user();
        $user->update(['avatar'=>$name]);
        return redirect()->back();
    }



    public function saveCookie()
    {
       $name = request()->input("txtCookie");
       Cookie::queue("CookieName",$name,6000000);
       return redirect()->back();
    }


    public function saveSession(Request $request)
    {
 $name = $request->input("txtSession");
 $request->session()->put('SessionName', $name);
 return redirect()->back();
    }

}
