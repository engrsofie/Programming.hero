<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\InventorySupplier;
use Yajra\DataTables\DataTables;
use Validator;
use Auth;

class InventorySupplierController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('pos.supplier.index');
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $branchId=Auth::user()->fk_branch_id;
        $companyId=Auth::user()->fk_company_id;
         $allData = InventorySupplier::leftJoin('inventory_branch','inventory_supplier.fk_branch_id','inventory_branch.id')->select('inventory_supplier.*','branch_name')->orderBy('inventory_supplier.id','DESC');
         return Datatables::of($allData)
            ->addColumn('action', '
                <a href="ui_modal_notification.html#modal-dialog<?php echo $id;?>" class="btn btn-xs btn-success" data-toggle="modal"><i class="fa fa-pencil-square-o" aria-hidden="true" style="font-size: 18px;"></i></a>
                <!-- #modal-dialog -->
                <div class="modal fade" id="modal-dialog<?php echo $id;?>">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                        {!! Form::open(array(\'route\' => [\'inventory-supplier.update\',$id],\'class\'=>\'form-horizontal author_form\',\'method\'=>\'PUT\',\'files\'=>\'true\', \'id\'=>\'commentForm\',\'role\'=>\'form\',\'data-parsley-validate novalidate\')) !!}
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                <h4 class="modal-title">Edit Supplier</h4>
                            </div>
                            <div class="modal-body">
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4" for="company_name">Company Name</label>
                                <div class="col-md-8 col-sm-8">
                                    <input class="form-control" type="text" id="company_name" name="company_name" value="<?php echo $company_name; ?>" data-parsley-required="true" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4" for="representative">Representative Name * :</label>
                                <div class="col-md-8 col-sm-8">
                                    <input class="form-control" type="text" id="representative" name="representative" value="<?php echo $representative; ?>"  />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4" for="email"> Email * :</label>
                                <div class="col-md-8 col-sm-8">
                                    <input class="form-control" type="text" id="email" name="email_id" data-parsley-type="email" value="<?php echo $email_id ?>"  />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4" for="address"> Address * :</label>
                                <div class="col-md-8 col-sm-8">
                                    <textarea class="form-control" id="address" name="address" rows="4"><?php echo $address; ?></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4" for="number"> Mobile No. * :</label>
                                <div class="col-md-8 col-sm-8">
                                    <input class="form-control" type="number" min="0" id="number" name="mobile_no" data-parsley-type="number" value="<?php echo $mobile_no; ?>" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4"> Status :</label>
                                <div class="col-md-3 col-sm-3">
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="status" value="1" id="radio-required" data-parsley-required="true" @if($status=="1"){{"checked"}}@endif> Active
                                        </label>
                                    </div>
                                </div>
                                <div class="col-md-4 col-sm-4">
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="status" id="radio-required2" value="0" @if($status=="0"){{"checked"}}@endif> Inactive
                                        </label>
                                    </div>
                                </div> 
                            </div>
                             
                        </div>
                            
                            <div class="modal-footer">
                                <a href="javascript:;" class="btn btn-sm btn-white" data-dismiss="modal">Close</a>
                                <button type="submit" class="btn btn-sm btn-success">Update</button>
                            </div>
                        {!! Form::close(); !!}
                        </div>
                    </div>
                </div>
                <!-- end edit section -->

                <!-- delete section -->
                {!! Form::open(array(\'route\'=> [\'inventory-supplier.destroy\',$id],\'method\'=>\'DELETE\')) !!}
                    {{ Form::hidden(\'id\',$id)}}
                    <button type="submit" onclick="return confirmDelete();" class="btn btn-danger btn-xs">
                      <i class="fa fa-trash-o" aria-hidden="true"></i>
                    </button>
                {!! Form::close() !!}
                ')

            ->rawColumns(['action'])
            ->make(true);
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
                'company_name' => 'required'

        ]);
        if($validator->fails()){
            return redirect()->back()->with('error','Representative name is required!');
        }

        $input = $request->all();
        $lastId=InventorySupplier::max('id')+1;
        $input['supplier_id'] = "s".$lastId;
        $input['created_by']=\Auth::user()->id;
        $input['fk_branch_id']=Auth::user()->fk_branch_id;
        $input['fk_company_id']=Auth::user()->fk_company_id;
        
        try {
            InventorySupplier::create($input); 
            $bug = 0;
            
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect()->back()->with('success','Created Successfully.');
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
         $data = InventorySupplier::findOrFail($id);
         $validator = Validator::make($request->all(),[
                'company_name' => 'required'

        ]);
        if($validator->fails()){
            return redirect()->back()->with('error','Representative name is requird!');
        }


        $input = $request->all();
        $input['updated_by']=\Auth::user()->id;
           
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
        $data = InventorySupplier::findOrFail($id);
        
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
