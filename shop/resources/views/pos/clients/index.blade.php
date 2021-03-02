
	@extends('layout.app')
		@section('content')
		<!-- begin #content -->
		
		<div id="content" class="content">
			
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                            	<a class="btn btn-info btn-xs" href="{{URL::to('/inventory-client')}}">View All Client List</a>
                                
                            </div>
                            <h4 class="panel-title">Clients </h4>
                        </div>
                        <div class="panel-body">
                            {!! Form::open(array('route' => 'inventory-client.store','class'=>'form-horizontal author_form','method'=>'POST','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                            	<div class="form-group">
									<label class="control-label col-md-4 col-sm-4" for="company_name">Company Name :</label>
									<div class="col-md-6 col-sm-6">
										<input class="form-control" type="text" id="company_name" name="company_name" placeholder="Company Name" />
									</div>
								</div>
								
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4" for="sub_category_name">Client Name * :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <input class="form-control" type="text" id="sub_category_name" name="client_name" placeholder="Client Name" data-parsley-required="true" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4" for="sub_category_name">Client Email :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <input class="form-control" type="text" id="email" name="email_id" data-parsley-type="email" placeholder="Email" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4" for="sub_category_name">Client Address  :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <textarea class="form-control" id="address" name="address" rows="2"  placeholder="Address"></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4" for="shipping_address1">Shipping Address One :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <textarea class="form-control" id="address" name="shipping_address1" rows="2"  placeholder="Shipping Address One"></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4" for="shipping_address2">Shipping Address Two :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <textarea class="form-control" id="address" name="shipping_address2" rows="2"  placeholder="Shipping Address Two"></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
									<label class="control-label col-md-4 col-sm-4" for="sub_category_name">Client Moblie No.  :</label>
									<div class="col-md-6 col-sm-6">
										<input class="form-control" type="text" id="number" name="mobile_no" data-parsley-type="number" placeholder="Mobile Number" />
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-md-4 col-sm-4">Client Status :</label>
									<div class="col-md-1 col-sm-1">
										<div class="radio">
											<label>
												<input type="radio" name="client_status" value="1" id="radio-required" data-parsley-required="true" checked /> Active
											</label>
										</div>
									</div>
									<div class="col-md-4 col-sm-4">
										<div class="radio">
											<label>
												<input type="radio" name="client_status" id="radio-required2" value="0" /> Inactive
											</label>
										</div>
									</div> 
								</div>
								<input type="hidden" name="client_type" value="0">
								
								<div class="form-group">
									<label class="control-label col-md-4 col-sm-4"></label>
									<div class="col-md-6 col-sm-6">
										<button type="submit" class="btn btn-primary">Submit</button>
									</div>
								</div>
                            {!! Form::close(); !!}
                        </div>
                    </div>
			    </div>
			</div>
		</div>
		<!-- end #content -->
    @endsection
