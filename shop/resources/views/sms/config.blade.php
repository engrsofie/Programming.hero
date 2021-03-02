
	@extends('layout.app')
		@section('content')
		<!-- begin #content -->
		<div id="content" class="content">
			
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                                 <a class="btn btn-info btn-xs" href="{{URL::to('sms/create')}}"> Branch wise sms send</a>
                            </div>
                            <h4 class="panel-title">SMS Configuration</h4>
                        </div>
                        <div class="panel-body">
                        	{!! Form::open(array('route' => ['sms.update',1],'class'=>'form-horizontal author_form','method'=>'PUT', 'id'=>'commentForm','role'=>'form','data-toggle'=>'validator')) !!}
                            	<div class="col-md-8 col-md-offset-2">
                            		<div class="form-group">
									<label class="control-label col-md-3" for="sms_quantity">SMS QTY :</label>
									<div class="col-md-9">
										<input class="form-control" value="{{$config['sms_quantity']}}" type="text" id="sms_quantity" name="sms_quantity" placeholder="QTY" required />
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-md-3" for="from">From :</label>
									<div class="col-md-9">
										<input class="form-control"  value="{{$config['from']}}" type="text" id="from" name="from" placeholder="From" required />
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-md-3" for="user_name">User Name :</label>
									<div class="col-md-9">
										<input class="form-control" value="{{$config['user_name']}}" type="text" id="user_name" name="user_name" placeholder="User Name" required />
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-md-3" for="password">Password :</label>
									<div class="col-md-9">
										<input class="form-control" value="{{$config['password']}}" type="password" id="password" name="password" placeholder="Password" required />
									</div>
								</div>
								<!-- <div class="form-group">
									<label class="control-label col-md-3" for="password">Confirm Password :</label>
									<div class="col-md-9">
										<input class="form-control" type="password" id="password" name="confirm-password" placeholder="Confirm Password" required />
									</div>
								</div> -->
								
								<div class="form-group">
									<label class="control-label col-md-3"></label>
									<div class="col-md-9">
										<button type="submit" class="btn btn-primary">Send</button>
									</div>
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
