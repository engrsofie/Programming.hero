<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;

use App\Models\Logo;

use Validator;

class LogoController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $logoData = Logo::first();
        return view('backend.logo.logo', compact('logoData'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage logo section.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
	$imagePath=rtrim(public_path(),'public');
        $logoId = Logo::findOrFail($id);
        /*validator logo field*/
        $validator = Validator::make($request->all(),[
                'logoHeadline' => 'required',
                'logoImagePath' => 'image',
                'logoIcoPath' => 'image'

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }

        /*logo field all request*/
        $input = $request->all();

        /*== logo image inserted   ==*/
        

        if($request->hasFile('logoImagePath')){
            $photo = $request->file('logoImagePath');
            $fileName = 'logo.png';
            $upload = $photo->move($imagePath."images/logo/",$fileName);
            $input['logoImagePath'] = $fileName;
            
        }

        /*== ico image inserted   ==*/

        if($request->hasFile('logoIcoPath')){
            $photo = $request->file('logoIcoPath');
            $fileName = 'favicon.png';
            $upload = $photo->move($imagePath."images/logo/ico",$fileName);
            $input['logoIcoPath'] = $fileName;
            $img_path_ico = "images/logo/ico".$logoId['logoIcoPath'];
            
        }

        
        
        try {
            $logoId->update($input);
            $bug = 0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect("logo")->with('success','Updated successFully.');
        }else{
            return redirect("logo")->with('error','Something Error Found !, Please try again.'.$bug1);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
