<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\EmployeSalarySheet;
use App\Models\EmployeInformation;
use App\Models\EmployeSection;
use App\Models\EmployeSalaryAllowance;
use App\Models\EmployeSalarySheetExtraAllowance;
use App\Models\AccountSetting;
use App\Models\PaymentMethod;
use App\Models\InventoryBranch;
use Validator;
use Auth;
class EmployeSalaryController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        for ($i=1; $i < 13; $i++) { 
            $month[$i]=date('F',strtotime(date('Y')."-$i-01"));
        }
        $section=EmployeSection::where('status',1)->pluck('section_name','id');
        $branch=InventoryBranch::where('status',1)->pluck('branch_name','id');

        $query=EmployeSalarySheet::leftJoin('employe_information','employe_salary_sheet.fk_employe_id','employe_information.id')->leftJoin('employe_section','employe_information.fk_section_id','employe_section.id')->select('employe_salary_sheet.*','employe_name','employe_id','designation','section_name');
        if(isset($request->section)){
            $query = $query->where('employe_information.fk_section_id',$request->section);
        }
        if(isset($request->branch) and $request->branch!=null){
            $query = $query->where('employe_information.fk_branch_id',$request->branch);
        }

        if(isset($request->year) and isset($request->month)){
            $query = $query->where(['year'=>$request->year,'month'=>$request->month]);
        }else{
            $query = $query->where(['year'=>date('Y'),'month'=>date('n')]);
            
        }
        if(!Auth::user()->isRole('administrator')){
            $branchId = Auth::user()->fk_branch_id;
            $query = $query->where('employe_information.fk_branch_id',$branchId);
        }
        $salary = $query ->get();
        return view('employe.salary.index',compact('section','month','salary','branch'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        for ($i=1; $i < 13; $i++) { 
            $month[$i]=date('F',strtotime(date('Y')."-$i-01"));
        }
        $branch=InventoryBranch::where('status',1)->pluck('branch_name','id');
        $section=EmployeSection::where('status',1)->pluck('section_name','id');
        return view('employe.salary.create',compact('section','month','branch'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $input = $request->except('_token');
        $validator = Validator::make($request->all(),[
                'fk_employe_id'  => 'required',
                'year'  => 'required',
                'month'  => 'required',
                'basic_pay'  => 'required',

        ]);
        if($validator->fails()){
            return redirect()->back()->with('error','Empty field found!');
        }
        
        try {
            $salary=EmployeSalarySheet::create([
                'fk_employe_id'=>$input['fk_employe_id'],
                'basic_pay'=>$input['basic_pay'],
                'house_rent'=>$input['house_rent'],
                'medical_allowance'=>$input['medical_allowance'],
                'year'=>$input['year'],
                'month'=>$input['month'],
                'total_amount'=>$input['total_amount'],
                'deduction'=>$input['deduction'],
                'paid_amount'=>$input['paid_amount'],
                'fk_account_id'=>$input['fk_account_id'],
                'fk_method_id'=>$input['fk_method_id'],
                'ref_id'=>$input['ref_id'],
                'date'=>$input['date'],
                'created_by'=>Auth::user()->id
                ]);
            for ($i=0; $i <sizeof($input['allowance_id']) ; $i++) { 
                EmployeSalarySheetExtraAllowance::create([
                    'fk_salary_sheet_id'=>$salary->id,
                    'fk_salary_allowance_id'=>$input['allowance_id'][$i],
                    'value'=>$input['allowance'][$i]
                    ]);
            }
            $bug = 0;
            
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect('employe-salary')->with('success','Created Successfully.');
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
        $data=EmployeSalarySheet::leftJoin('employe_information','employe_salary_sheet.fk_employe_id','employe_information.id')->leftJoin('employe_section','employe_information.fk_section_id','employe_section.id')->select('employe_salary_sheet.*','employe_name','employe_id','designation','section_name')->where('employe_salary_sheet.id',$id)->first();
        $allowance=EmployeSalarySheetExtraAllowance::leftJoin('employe_salary_allowance','employe_salary_sheet_extra_allowance.fk_salary_allowance_id','employe_salary_allowance.id')
            ->select('employe_salary_sheet_extra_allowance.*','title')
            ->where('fk_salary_sheet_id',$id)->where('type','1')->get();
        $deduction=EmployeSalarySheetExtraAllowance::leftJoin('employe_salary_allowance','employe_salary_sheet_extra_allowance.fk_salary_allowance_id','employe_salary_allowance.id')
            ->select('employe_salary_sheet_extra_allowance.*','title')
            ->where('fk_salary_sheet_id',$id)->where('type','2')->get();
        return view('employe.salary.show',compact('data','allowance','deduction'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $data=EmployeSalarySheet::leftJoin('employe_information','employe_salary_sheet.fk_employe_id','employe_information.id')->leftJoin('employe_section','employe_information.fk_section_id','employe_section.id')->select('employe_salary_sheet.*','employe_name','employe_id','designation','section_name')->where('employe_salary_sheet.id',$id)->first();
        $allowance=EmployeSalarySheetExtraAllowance::leftJoin('employe_salary_allowance','employe_salary_sheet_extra_allowance.fk_salary_allowance_id','employe_salary_allowance.id')
            ->select('employe_salary_sheet_extra_allowance.*','title')
            ->where('fk_salary_sheet_id',$id)->where('type','1')->get();
        $deduction=EmployeSalarySheetExtraAllowance::leftJoin('employe_salary_allowance','employe_salary_sheet_extra_allowance.fk_salary_allowance_id','employe_salary_allowance.id')
            ->select('employe_salary_sheet_extra_allowance.*','title')
            ->where('fk_salary_sheet_id',$id)->where('type','2')->get();
        $account=AccountSetting::where('account_status',1)->pluck('account_name','id');
        $method=PaymentMethod::where('method_status',1)->pluck('method_name','id');
        return view('employe.salary.edit',compact('data','allowance','deduction','account','method'));
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
        $input=$request->except('_token','_method');
        $validator = Validator::make($request->all(),[
                'basic_pay'  => 'required',

        ]);
        if($validator->fails()){
            return redirect()->back()->with('error','Empty field found!');
        }
        try {
            $salary=EmployeSalarySheet::where('id',$id)->update([
                'basic_pay'=>$input['basic_pay'],
                'house_rent'=>$input['house_rent'],
                'medical_allowance'=>$input['medical_allowance'],
                'total_amount'=>$input['total_amount'],
                'deduction'=>$input['deduction'],
                'paid_amount'=>$input['paid_amount'],
                'fk_account_id'=>$input['fk_account_id'],
                'fk_method_id'=>$input['fk_method_id'],
                'ref_id'=>$input['ref_id'],
                'date'=>$input['date'],
                'updated_by'=>Auth::user()->id
                ]);
            for ($i=0; $i <sizeof($input['allowance_id']) ; $i++) {
            $allowanceId= $input['allowance_id'][$i];
                EmployeSalarySheetExtraAllowance::where('id',$allowanceId)->update([
                    'value'=>$input['allowance'][$i]
                    ]);
            }
            EmployeInformation::where('id',$request->fk_employe_id)->update([
                'basic_pay'=>$input['basic_pay'],
                'house_rent'=>$input['house_rent'],
                'medical_allowance'=>$input['medical_allowance']
                ]);
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
        $data = EmployeSalarySheet::findOrFail($id);
        
        try {
            EmployeSalarySheetExtraAllowance::where('fk_salary_sheet_id',$id)->delete();
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

    public function loadEmploye($id)
    {
        $branch=Auth::user()->fk_branch_id;
        $employe=EmployeInformation::where('status',1)->where('fk_section_id',$id)->where('fk_branch_id',$branch)->pluck('employe_name','id');
        return view('employe.salary.loadEmploye',compact('employe'));
    }


    public function loadSalarySheet(Request $request)
    {
        $id=$request->id;

        $employe=EmployeInformation::leftJoin('employe_section','employe_information.fk_section_id','employe_section.id')->select('employe_information.*','employe_section.section_name')->where('employe_information.id',$request->id)->first();
        $salary=EmployeSalarySheet::where(['year'=>$request->year,'month'=>$request->month])
                ->where('fk_employe_id',$request->id)->first();
        if($salary!=null){
            return '<div class="col-md-12"><h1 class="text-danger">This employee salary is already prepared!</h1></div>';

        }
        $allowance=EmployeSalaryAllowance::where('status',1)->where('type','1')->get();
        $deduction=EmployeSalaryAllowance::where('status',1)->where('type','2')->get();
        $account=AccountSetting::where('account_status',1)->pluck('account_name','id');
        $method=PaymentMethod::where('method_status',1)->pluck('method_name','id');
        return view('employe.salary.loadSalarySheet',compact('employe','allowance','deduction','account','method'));
    }

    public function loadSectionSalary(Request $request){
        $input=$request->except('_token');
        $query=EmployeSalarySheet::leftJoin('employe_information','employe_salary_sheet.fk_employe_id','employe_information.id')->leftJoin('employe_section','employe_information.fk_section_id','employe_section.id')->select('employe_salary_sheet.*','employe_name','employe_id','designation','section_name')->where(['year'=>$request->year,'month'=>$request->month]);
        if($request->section!=null){
            $query=$query->where('employe_information.fk_section_id',$request->section);
            $input['section']=EmployeSection::where('id',$request->section)->value('section_name');
        }
        $salary=$query->get();
        return view('employe.salary.loadSectionSalary',compact('salary','input'));
    }






}
