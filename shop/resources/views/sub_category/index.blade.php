
	@extends('layout.app')
		@section('content')
		<!-- begin #content -->
		<div id="content" class="content">
			<!-- end page-header -->
			
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                                <a class="btn btn-xs btn-info" href="{{URL::to('/sub-category')}}">View All Sector</a>
                            </div>
                            <h4 class="panel-title">Add New Sector</h4>
                        </div>
                        <div class="panel-body">
                            {!! Form::open(array('route' => 'sub-category.store','class'=>'form-horizontal author_form','method'=>'POST','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                            	<div class="form-group">
									<label class="control-label col-md-4 col-sm-4" for="company_name"></label>
									<div class="col-md-6 col-sm-6">
										<input class="form-control" type="hidden" id="company_name" name="company_name" placeholder="Company Name" data-parsley-required="true" />
									</div>
								</div>
                                <div class="form-group">
									<label class="control-label col-md-4 col-sm-4" for="sub_category_name">Sector Name * :</label>
									<div class="col-md-6 col-sm-6">
										<input class="form-control" type="text" id="sub_category_name" name="sub_category_name" placeholder="Sub Category Name" data-parsley-required="true" />
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-md-4 col-sm-4">Sector Status :</label>
									<div class="col-md-1 col-sm-1">
										<div class="radio">
											<label>
												<input type="radio" name="sub_category_status" value="1" id="radio-required" data-parsley-required="true" checked /> Active
											</label>
										</div>
									</div>
									<div class="col-md-4 col-sm-4">
										<div class="radio">
											<label>
												<input type="radio" name="sub_category_status" id="radio-required2" value="0" /> Inactive
											</label>
										</div>
									</div> 
								</div>
								
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
		
    <script src="{{asset('public/plugins/jquery/jquery-1.9.1.min.js')}}"></script>        
    <script type="text/javascript">
    	$(document).ready(function() {
	        App.init();
	        DashboardV2.init();
	        //
	    });
    </script>
    @endsection
