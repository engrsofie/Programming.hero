
	@extends('layout.app')
		@section('content')
		<!-- begin #content -->
		<div id="content" class="content">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a class="btn btn-info" href="{{URL::to('/role/create')}}">Add New Role</a></li>
				<li><a class="btn btn-info" href="{{URL::to('/role')}}">View All Role</a></li>
				<li><a class="btn btn-info" href="{{URL::to('/permission/create')}}">Add New Permission</a></li>
				<li><a class="btn btn-info" href="{{URL::to('/permission')}}">View All Permission</a></li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">Role Wise Permission Page </h1>
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
                            {!! Form::open(array('route' => 'role-wise-permission.store','class'=>'form-horizontal author_form','method'=>'POST','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                            	<div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4">Select Role :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <select name="fk_role_id" required="required" class="form-control" onchange="roleWisePermission(this.value)">
                                            <option value="-1">Please choose Role</option>
                                            @if(isset($getRoleData))
				                              @foreach($getRoleData as $role)
				                                <option value="<?php echo $role->id; ?>"><?php echo $role->role_type; ?></option>
				                              @endforeach
				                            @endif
                                        </select>
                                    </div>
                                </div>
								<div id="roleWisePermission"></div>
								<div class="form-group" style="margin-top: 150px;">
									<label class="control-label col-md-4 col-sm-4"></label>
									<div class="col-md-6 col-sm-6">
										<button type="submit" class="btn btn-primary">Confirm</button>
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
    <script src="{{ asset('public/js/chosen.jquery.js') }}" type="text/javascript"></script>      
    <script type="text/javascript">
    	$(document).ready(function() {
	        App.init();
	        DashboardV2.init();
	        //
	    });
    </script>
      
      <script type="text/javascript">
        function roleWisePermission(value){
          //alert(value);
          $("#roleWisePermission").load("{{ URL::to('role-wise-permission')}}"+'/'+value);
          if(value === -1){
            $("#roleWisePermission").hide();
          }
        }
      </script>
    @endsection
