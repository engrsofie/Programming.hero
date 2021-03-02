
	@extends('layout.app')
		@section('content')
		<!-- begin #content -->
		<div id="content" class="content">
			
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                                
                            </div>
                            <h4 class="panel-title">Supplier</h4>
                        </div>
                        <div class="panel-body">
                        	<div class="create_button">
                        		<a href="ui_modal_notification.html#modal-dialog" class="btn btn-sm btn-success" data-toggle="modal">Add New Supplier</a>
                        	</div>
                            <!-- #modal-dialog -->
                            <div class="modal fade" id="modal-dialog">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                    {!! Form::open(array('route' => 'inventory-supplier.store','class'=>'form-horizontal author_form','method'=>'POST','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                            <h4 class="modal-title">Supplier</h4>
                                        </div>
                                        <div class="modal-body">
                                        	<div class="form-group">
									<label class="control-label col-md-3 col-sm-3" for="company_name">Company Name :</label>
									<div class="col-md-8 col-sm-8">
										<input class="form-control" type="text" id="company_name" name="company_name" placeholder="Company Name" data-parsley-required="true" required />
									</div>
								</div>
								
                                <div class="form-group">
                                    <label class="control-label col-md-3 col-sm-3" for="sub_category_name">Representative Name * :</label>
                                    <div class="col-md-8 col-sm-8">
                                        <input class="form-control" type="text" id="sub_category_name" name="representative" placeholder="Representative Name"  />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3 col-sm-3" for="sub_category_name">Email :</label>
                                    <div class="col-md-8 col-sm-8">
                                        <input class="form-control" type="text" id="email" name="email_id" data-parsley-type="email" placeholder="Email" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3 col-sm-3" for="sub_category_name">Address  :</label>
                                    <div class="col-md-8 col-sm-8">
                                        <textarea class="form-control" id="address" name="address" rows="4"  placeholder="Address"></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
									<label class="control-label col-md-3 col-sm-3" for="sub_category_name">Moblie No.  :</label>
									<div class="col-md-8 col-sm-8">
										<input class="form-control" type="number" min="0" id="number" name="mobile_no" data-parsley-type="number" placeholder="Mobile Number" />
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3"> Status :</label>
									<div class="col-md-1 col-sm-1">
										<div class="radio">
											<label>
												<input type="radio" name="status" value="1" id="radio-required" data-parsley-required="true" checked /> Active
											</label>
										</div>
									</div>
									<div class="col-md-3 col-sm-3">
										<div class="radio">
											<label>
												<input type="radio" name="status" id="radio-required2" value="0" /> Inactive
											</label>
										</div>
									</div> 
								</div>
			                                   
                                        </div>
                                        <div class="modal-footer">
                                            <a href="javascript:;" class="btn btn-sm btn-white" data-dismiss="modal">Close</a>
                                            <button type="submit" class="btn btn-sm btn-success">Submit</button>
                                        </div>
                                    {!! Form::close(); !!}
                                    </div>
                                </div>
                            </div>    
                        </div>
                        <!--  -->
                        <div class="view_brand_set">
                        	<div class="panel-body">
	                            <table id="all_data" class="table table-striped table-bordered nowrap" width="100%">
	                                <thead>
	                                    <tr>
	                                        <th>Representative</th>
                                            <th>Company Name</th>
	                                        <th>Branch</th>
	                                        <th width="10%">status</th>
	                                        <th width="15%">Action</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                
	                                </tbody>
	                            </table>
	                        </div>	
                        </div>
                    </div>
			    </div>
			</div>
		</div>
		<!-- end #content -->
		
    <script src="{{asset('public/plugins/jquery/jquery-1.9.1.min.js')}}"></script>

    <script type="text/javascript">
        $(function() {
            $('#all_data').DataTable( {
                processing: true,
                serverSide: true,
                ajax: '{!! URL::asset("inventory-supplier/create") !!}',
                columns: [
                    { data: 'representative'},
                    { data: 'company_name'},
                    { data: 'branch_name',name:'inventory_branch.branch_name'},
                    { data: 'status'},
                    { data: 'action'}
                ]
            });
        });
    </script>
    @endsection
