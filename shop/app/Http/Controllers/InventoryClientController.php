<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\InventoryClient;
use Yajra\DataTables\DataTables;
use Validator;
use Auth;
class InventoryClientController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {   
        $branchId=Auth::user()->fk_branch_id;
        $companyId=Auth::user()->fk_company_id;
        $query = InventoryClient::leftJoin('inventory_branch','inventory_clients.fk_branch_id','inventory_branch.id')->orderBy('inventory_clients.id','desc')->select('inventory_clients.*','branch_name');
         if(Auth::user()->isRole('administrator')){
            $getClientData=$query->paginate(50);
        }else{
            $getClientData=$query->where(['fk_branch_id'=>$branchId,'fk_company_id'=>$companyId])->paginate(50);
        }
        return view('pos.clients.viewClients', compact('getClientData'));
        
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('pos.clients.index');
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
                'client_name' => 'required'

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }

        $input = $request->all();
        $input['fk_branch_id']=Auth::user()->fk_branch_id;
        $input['fk_company_id']=Auth::user()->fk_company_id;
        $lastId=InventoryClient::max('id')+1;
        $input['client_id'] = "client-".$lastId;
        //print_r($input);exit;
        $input['created_by']=\Auth::user()->id;
        
        try {
            InventoryClient::create($input); 
            $bug = 0;
            
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect()->back()->with('success','Created Successfully.');
        }else{
            return redirect('inventory-client/create')->with('error','Something Error Found !, Please try again.'.$bug1);
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
        $query = InventoryClient::leftJoin('inventory_branch','inventory_clients.fk_branch_id','inventory_branch.id')->orderBy('inventory_clients.id','desc')->select('inventory_clients.*','branch_name');
         if(Auth::user()->isRole('administrator')){
            $getClientData=$query->get();
        }else{
            $getClientData=$query->where(['fk_branch_id'=>$branchId,'fk_company_id'=>$companyId])->get();
        }

        return Datatables::of($getClientData)
        ->addColumn('action','')
        ->editColumn('client_status',function($data){
            if($data->client_status==1){
                return "Active";
            }else{
                return "Inactive";
            }
        })
        ->addColumn('action','<a href="#modal-dialog<? echo $id ?>" class="btn btn-xs btn-success" data-toggle="modal"><i class="fa fa-pencil-square-o" aria-hidden="true" style="font-size: 18px;"></i></a>
                    <div class="modal fade" id="modal-dialog<? echo $id ?>">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                            {!! Form::open(array(\'route\' => [\'inventory-client.update\',$id],\'class\'=>\'form-horizontal author_form\',\'method\'=>\'PUT\',\'files\'=>\'true\', \'id\'=>\'commentForm\',\'role\'=>\'form\',\'data-parsley-validate novalidate\')) !!}
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                    <h4 class="modal-title"><?php echo $client_name; ?></h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label class="control-label col-md-4 col-sm-4" for="company_name">Company Name</label>
                                        <div class="col-md-8 col-sm-8">
                                            <input class="form-control" type="text" id="company_name" name="company_name" value="<?php echo $company_name; ?>" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-md-4 col-sm-4" for="client_name">Client Name * :</label>
                                        <div class="col-md-8 col-sm-8">
                                            <input class="form-control" type="text" id="client_name" name="client_name" value="<?php echo $client_name; ?>" data-parsley-required="true" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-md-4 col-sm-4" for="client_name">Client Email * :</label>
                                        <div class="col-md-8 col-sm-8">
                                            <input class="form-control" type="text" id="email" name="email_id" data-parsley-type="email" value="<?php echo $email_id ?>"  />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-md-4 col-sm-4" for="client_name">Client Address * :</label>
                                        <div class="col-md-8 col-sm-8">
                                            <textarea class="form-control" id="address" name="address" rows="2"><?php echo $address; ?></textarea>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-md-4 col-sm-4" for="shipping_address1">Shipping Address One :</label>
                                        <div class="col-md-8 col-sm-8">
                                            <textarea class="form-control" id="address" name="shipping_address1" rows="2"  placeholder="Shipping Address One">{{$shipping_address1}}</textarea>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-md-4 col-sm-4" for="shipping_address2">Shipping Address Two :</label>
                                        <div class="col-md-8 col-sm-8">
                                            <textarea class="form-control" id="address" name="shipping_address2" rows="2"  placeholder="Shipping Address Two">{{$shipping_address2}}</textarea>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-md-4 col-sm-4" for="client_name">Client Mobile No. * :</label>
                                        <div class="col-md-8 col-sm-8">
                                            <input class="form-control" type="text" id="number" name="mobile_no" data-parsley-type="number" value="<?php echo $mobile_no; ?>" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-md-4 col-sm-4">Client Status :</label>
                                        <div class="col-md-3 col-sm-3">
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="client_status" value="1" id="radio-required" data-parsley-required="true" @if($client_status=="1"){{"checked"}}@endif> Active
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="client_status" id="radio-required2" value="0" @if($client_status=="0"){{"checked"}}@endif> Inactive
                                                </label>
                                            </div>
                                        </div> 
                                    </div>
                                   
                                     
                                </div>
                                <input type="hidden" name="client_id" value="<?php echo $client_id; ?>">
                                <input type="hidden" name="type" value="0">
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
                    {!! Form::open(array(\'route\'=> [\'inventory-client.destroy\',$id],\'method\'=>\'DELETE\')) !!}
                        {{ Form::hidden(\'id\',$id)}}
                        <button type="submit" onclick="return confirmDelete();" class="btn btn-xs btn-danger">
                          <i class="fa fa-trash-o" aria-hidden="true"></i>
                        </button>
                    {!! Form::close() !!}')
        ->rawColumns(['action'])
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
         $clientData = InventoryClient::findOrFail($id);
         $validator = Validator::make($request->all(),[
                'client_name' => 'required'

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }


        $input = $request->all();
        $input['updated_by']=\Auth::user()->id;
           
        try {
            $clientData->update($input);
            $bug = 0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect("inventory-client")->with('success','Updated successFully.');
        }else{
            return redirect("inventory-client")->with('error','Something Error Found !, Please try again.'.$bug1);
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
        $clientData = InventoryClient::findOrFail($id);
        
        try {
            
            $clientData->delete();
            $bug = 0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect('inventory-client')->with('success', 'Deleted Successfully .');
        }elseif($bug == 1451){
                return redirect('inventory-client')->with('error','This Data Used AnyWhere.');
            }else{
            return redirect('inventory-client')->with('error','Something Error Found !, Please try again.'.$bug1);
        }


    }

}
