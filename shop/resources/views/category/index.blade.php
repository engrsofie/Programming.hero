
	@extends('layout.app')
		@section('content')
		<!-- begin #content -->
		<div id="content" class="content">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a class="btn btn-info" href="{{URL::to('/category')}}">View All Categories</a></li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">Category Page </h1>
			<!-- end page-header -->
			
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-success" data-click="panel-reload"><i class="fa fa-repeat"></i></a>
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
                            </div>
                            <h4 class="panel-title">Panel Title here</h4>
                        </div>
                        <div class="panel-body">
                            {!! Form::open(array('route' => 'category.store','class'=>'form-horizontal author_form','method'=>'POST','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                            	<div class="form-group">
									<label class="control-label col-md-4 col-sm-4" for="company_name"></label>
									<div class="col-md-6 col-sm-6">
										<input class="form-control" type="hidden" id="company_name" name="company_name" placeholder="Company Name" data-parsley-required="true" />
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-md-4 col-sm-4" for="category_name">Category Name * :</label>
									<div class="col-md-6 col-sm-6">
										<input class="form-control" type="text" id="category_name" name="category_name" placeholder="Category Name" data-parsley-required="true" />
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-md-4 col-sm-4">Category Status :</label>
									<div class="col-md-1 col-sm-1">
										<div class="radio">
											<label>
												<input type="radio" name="category_status" value="1" id="radio-required" data-parsley-required="true" checked /> Active
											</label>
										</div>
									</div>
									<div class="col-md-4 col-sm-4">
										<div class="radio">
											<label>
												<input type="radio" name="category_status" id="radio-required2" value="0" /> Inactive
											</label>
										</div>
									</div> 
								</div>
								<div class="form-group">
									<label class="control-label col-md-4 col-sm-4">Category Type :</label>
									<div class="col-md-6 col-sm-6">
										<select class="form-control" id="select-required" name="category_type" data-parsley-required="true">
											<option value="">Please choose</option>
											<option value="Payment">Payment</option>
											<option value="Deposit">Deposit</option>
										</select>
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
    @endsection
