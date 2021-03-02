@extends('layout.app')
    @section('content')
<div id="content" class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-inverse">
                <div class="panel-heading">
                    <div class="panel-heading-btn">
                       
                       <a href="{{route('users.index')}}" class="btn btn-default btn-xs pull-right"> <i class="ion ion-navicon-round"></i> View all user</a>
                    </div>
                    <h4 class="panel-title"><i class="fa fa-pencil" aria-hidden="true"></i> Change Password</h4>
                </div>
                <div class="panel-body">

					 {!! Form::open(array('route' => 'password','class'=>'form-horizontal','method'=>'POST')) !!}
				    <div class="modal-body">
				        <!-- <div class="form-group {{ Session::has('errorPass') ? 'has-error' : '' }}">
				            {{Form::label('old_password', 'Old Password', array('class' => 'col-md-4 control-label'))}}
				            <div class="col-md-8">
				                {{Form::password('old_password',array('class'=>'form-control','placeholder'=>'Old Password','required'))}}
			 					@if(Session::has('errorPass'))
				                    <span class="help-block">
				                        <strong>{{ Session::get('errorPass') }}</strong>
				                    </span>
				                @endif
				            </div>
				        </div> -->
				        <div class="form-group {{ $errors->has('password') ? 'has-error' : '' }}">
				            {{Form::label('password', 'Password', array('class' => 'col-md-4 control-label'))}}
				            <div class="col-md-8">
				                {{Form::password('password',array('class'=>'form-control','placeholder'=>'Password','required'))}}
				                 @if ($errors->has('password'))
				                    <span class="help-block">
				                        <strong>{{ $errors->first('password') }}</strong>
				                    </span>
				                @endif
				            </div>
				        </div>
				        <div class="form-group {{ $errors->has('password_confirmation') ? 'has-error' : '' }}">
				            {{Form::label('password_confirmation', 'Password Confirmation', array('class' => 'col-md-4 control-label'))}}
				            <div class="col-md-8">
				                {{Form::password('password_confirmation',array('class'=>'form-control','placeholder'=>'Password Confirmation','required'))}}
				                 @if ($errors->has('password_confirmation'))
				                    <span class="help-block">
				                        <strong>{{ $errors->first('password_confirmation') }}</strong>
				                    </span>
				                @endif
				            </div>
				        </div>
				        {{Form::hidden('id',$data->id)}}
				    </div>
				      <div class="modal-footer">
				      <button type="submit" class="btn btn-info"><i class="fa fa-floppy-o" aria-hidden="true"> Save Password</i></button>
				    </div>
				        {!! Form::close() !!}

				</div>
			</div>
		</div>
	</div>
</div>
	

<script src="{{asset('public/plugins/jquery/jquery-1.9.1.min.js')}}"></script>
<script type="text/javascript">
      $(document).ready(function() {
          App.init();
          DashboardV2.init();
          //
      });
</script>





@endsection