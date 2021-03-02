<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\CompanyInfo;

use Validator;

class CompanyInfoController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $getCompanyData = CompanyInfo::first();
        return view('settings.company_info', compact('getCompanyData'));
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
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $getCompanyData = CompanyInfo::findOrFail($id);
        $validator = Validator::make($request->all(),[
            'company_name' => 'required'
        ]);

        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }

        $input = $request->all();

        if($request->hasFile('company_logo')){
            $photo = $request->file('company_logo');
            $fileType = substr($_FILES['company_logo']['type'], 6);
            $fileName = rand(1,1000).date('dmyhis').'.'.$fileType;
            $upload = $photo->move("images/company/logo/",$fileName);
            $input['company_logo'] = $fileName;
            $img_path = "images/company/logo/".$getCompanyData['company_logo'];
            if($getCompanyData['company_logo'] !=null and file_exists($img_path)){
                unlink($img_path);
            }

        }

        /*== ico image inserted   ==*/

        if($request->hasFile('company_icon')){
            $photo = $request->file('company_icon');
            $fileType = substr($_FILES['company_icon']['type'], 6);
            $fileName = rand(1,1000).date('dmyhis').'.'.$fileType;
            $upload = $photo->move("images/company/ico",$fileName);
            $input['company_icon'] = $fileName;
            $img_path_ico = "images/company/ico".$getCompanyData['company_icon'];
            if($getCompanyData['company_icon'] !=null and file_exists($img_path_ico)){
                unlink($img_path_ico);
            }
        }
        
        try {
            $getCompanyData->update($input);
            $bug = 0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
       
        if($bug == 0){
            return redirect()->back()->with('success','Updated Successfully.');
        }else{
            return redirect()->back()->with('error','Something Error Found !, Please try again.'.$bug1);
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
