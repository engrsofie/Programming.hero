<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\EmployeInformation;
use App\Models\EmployeSection;
use Yajra\DataTables\DataTables;
use Validator;
use Image;
use Auth;

class EmployeInformationController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {   
        
        
        return view('employe.information.index');
        
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {   $section=EmployeSection::where('status',1)->pluck('section_name','id');
        return view('employe.information.create',compact('section'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(),[
                'employe_name'  => 'required',
                'employe_id'    => 'required|unique:employe_information',
                'designation' => 'required',
                'fk_section_id' => 'required',
                'status' => 'required',
                'photo' => 'image'

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }
            $input = $request->all();
            $input['created_by']=\Auth::user()->id;
            $input['fk_branch_id']=\Auth::user()->fk_branch_id;
            if ($request->hasFile('photo')) {
                $photo=$request->file('photo');
                $fileType=$photo->getClientOriginalExtension();
                $fileName=rand(1,1000).date('dmyhis').".".$fileType;
                $path=base_path().'/images/employee/'.date('Y/m/d');
                if (!is_dir($path)) {
                    mkdir("$path",0777,true);
                    }
                /*$fileName=$photo->getClientOriginalName();*/
                $img = Image::make($photo);
                $img->resize(100, 120);
                $img->save('images/employee/'.date('Y/m/d/').$fileName);
                $input['photo']=date('Y/m/d/').$fileName;
            }
        
        try {
            EmployeInformation::create($input); 
            $bug = 0;
            
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect('employe-information')->with('success','Created Successfully.');
        }else{
            return redirect()->back()->with('error','Something Error Found !, Please try again.'.$bug1);
        }

    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
         
        $allData = EmployeInformation::leftJoin('employe_section','employe_information.fk_section_id','employe_section.id')->leftJoin('inventory_branch','employe_information.fk_branch_id','inventory_branch.id')->select('employe_information.*','employe_section.section_name','branch_name')->orderBy('employe_information.id','desc');
        if(!Auth::user()->isRole('administrator')){
            $branchId=Auth::user()->fk_branch_id;
            $allData = $allData->where('fk_branch_id',$branchId);
        }
        return Datatables::of($allData)
        ->editColumn('photo',function($data){
            if($data->photo!=null){
                $photo='<img class="img-responsive" style="height:40px;" src='.asset("images/employee/$data->photo").'>';
            }else{
                $photo='';
            }
            return $photo;
        })
        ->addColumn('action','
            <td> <a href=\'{{URL::to("employe-information/$id/edit")}}\' class="btn btn-xs btn-success"> <i class="fa fa-pencil-square-o"></i></a>
                {!! Form::open(array("route"=> ["employe-information.destroy",$id],"method"=>"DELETE")) !!}
                    {{ Form::hidden("id",$id)}}
                    <button type="submit" onclick="return confirmDelete();" class="btn btn-xs btn-danger">
                      <i class="fa fa-trash-o" aria-hidden="true"></i>
                    </button>
                {!! Form::close() !!}
            </td>
            ')
        ->rawColumns(['action','photo'])
        ->make(true);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $section=EmployeSection::where('status',1)->pluck('section_name','id');
        $data=EmployeInformation::findOrFail($id);
        if($data==null){
            return redirect()->back();
        }
        return view('employe.information.edit',compact('section','data'));
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
         $data = EmployeInformation::findOrFail($id);
         $validator = Validator::make($request->all(),[
                'employe_name'  => 'required',
                'employe_id'    => "required|unique:employe_information,employe_id,$id",
                'designation' => 'required',
                'fk_section_id' => 'required',
                'status' => 'required'

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }


        $input = $request->all();
        $input['updated_by']=\Auth::user()->id;
        if ($request->hasFile('photo')) {
                $photo=$request->file('photo');
                $fileType=$photo->getClientOriginalExtension();
                $fileName=rand(1,1000).date('dmyhis').".".$fileType;
                $path=base_path().'/images/employee/'.date('Y/m/d');
                if (!is_dir($path)) {
                    mkdir("$path",0777,true);
                    }
                /*$fileName=$photo->getClientOriginalName();*/
                $img = Image::make($photo);
                $img->resize(100, 120);
                $img->save('images/employee/'.date('Y/m/d/').$fileName);
                $input['photo']=date('Y/m/d/').$fileName;

                $img_path=base_path().'/images/employee/'.$data->photo;

                if($data->photo!=null){
                    if(file_exists($img_path)){
                        unlink($img_path);
                    }
                }
            }
           
        try {
            $data->update($input);
            $bug = 0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect()->back()->with('success','Updated successFully.');
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
        $data = EmployeInformation::findOrFail($id);
         $img_path=base_path().'/images/employee/'.$data->photo;

        if($data->photo!=null){
            if(file_exists($img_path)){
                unlink($img_path);
            }
        }

        
        try {
            
            $data->delete();
            $bug = 0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect()->back()->with('success', 'Deleted Successfully .');
        }elseif($bug == 1451){
                return redirect()->back()->with('error','This Data Used AnyWhere.');
            }else{
            return redirect()->back()->with('error','Something Error Found !, Please try again.'.$bug1);
        }


    }

}
