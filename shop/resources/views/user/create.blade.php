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
                    <h4 class="panel-title"><i class="fa fa-pencil" aria-hidden="true"></i> User Registration</h4>
                </div>
                <div class="panel-body">
                    {!! Form::open(array('route' => 'users.store','class'=>'form-horizontal')) !!}
                                    
                    <div class="form-group {{ $errors->has('name') ? 'has-error' : '' }}">
                        <label for="fullName" class="col-sm-3 control-label">Full Name* : </label>
                        <div class="col-sm-7">
                            <input type="text" name="name" parsley-trigger="change" required
                               placeholder="Enter Full Name" class="form-control" id="fullName" value="{{ old('name') }}">
                               @if ($errors->has('name'))
                                    <span class="help-block">
                                        <strong>{{ $errors->first('name') }}</strong>
                                    </span>
                                @endif
                        </div>
                    </div>
                    <div class="form-group {{ $errors->has('email') ? 'has-error' : '' }}">
                        <label for="inputEmail3" class="col-sm-3 control-label">Email* :</label>
                        <div class="col-sm-7">
                            <input type="email" name="email" required parsley-type="email" class="form-control" id="inputEmail3" placeholder="Email" value="{{ old('email') }}">
                                   @if ($errors->has('email'))
                                        <span class="help-block">
                                            <strong>{{ $errors->first('email') }}</strong>
                                        </span>
                                    @endif
                        </div>
                    </div>
                    <div class="form-group  {{ $errors->has('password') ? 'has-error' : '' }}">
                        <label for="pass1" class="col-sm-3 control-label">Password* :</label>
                        <div class="col-sm-7">
                            <input name="password" id="pass1" type="password" placeholder="Password" required class="form-control">
                            @if ($errors->has('password'))
                                <span class="help-block">
                                    <strong>{{ $errors->first('password') }}</strong>
                                </span>
                            @endif
                        </div>
                    </div>
                    <div class="form-group {{ $errors->has('password_confirmation') ? 'has-error' : '' }}">
                        <label for="passWord2" class="col-sm-3 control-label">Confirm Password* :</label>
                        <div class="col-sm-7">
                            <input data-parsley-equalto="#pass1" type="password" required placeholder="Password" class="form-control" id="passWord2" name="password_confirmation">
                            @if ($errors->has('password_confirmation'))
                                    <span class="help-block">
                                        <strong>{{ $errors->first('password_confirmation') }}</strong>
                                    </span>
                            @endif
                        </div>
                    </div>
                    <div class="form-group {{ $errors->has('phone_number') ? 'has-error' : '' }}">
                        <label for="phone_number" class="col-sm-3 control-label">Mobile Number* : </label>
                        <div class="col-sm-7">
                            <input type="text" name="phone_number" parsley-trigger="change" required
                               placeholder="Mobile number" class="form-control" id="phone_number" value="{{ old('phone_number') }}">
                               @if ($errors->has('phone_number'))
                                    <span class="help-block">
                                        <strong>{{ $errors->first('phone_number') }}</strong>
                                    </span>
                                @endif
                        </div>
                    </div>
                    <div class="form-group {{ $errors->has('address') ? 'has-error' : '' }}">
                        {{Form::label('address','Address :',['class'=>'col-sm-3 control-label'])}}
                        <div class="col-md-7">
                            {{Form::textArea('address','',['class'=>'form-control','placeholder'=>'Address','rows'=>'2','required'])}}
                             @if ($errors->has('address'))
                                    <span class="help-block">
                                        <strong>{{ $errors->first('address') }}</strong>
                                    </span>
                            @endif
                        </div>
                    </div>
                    <div class="form-group {{ $errors->has('fk_branch_id') ? 'has-error' : '' }}">
                        {{Form::label('fk_branch_id','Branch * :',['class'=>'col-sm-3 control-label'])}}
                        <div class="col-md-3">
                            {{Form::select('fk_branch_id',$branch,'',['class'=>'form-control','placeholder'=>'Select branch','required'])}}
                             @if ($errors->has('fk_branch_id'))
                                    <span class="help-block">
                                        <strong>{{ $errors->first('fk_branch_id') }}</strong>
                                    </span>
                            @endif
                        </div>
                    </div>
                    <div class="form-group {{ $errors->has('type') ? 'has-error' : '' }}">
                        {{Form::label('type','User Roles * :',['class'=>'col-sm-3 control-label'])}}
                        <div class="col-md-3">
                            {{Form::select('type',$roles,'',['class'=>'form-control','placeholder'=>'Select type','required'])}}
                             @if ($errors->has('type'))
                                    <span class="help-block">
                                        <strong>{{ $errors->first('type') }}</strong>
                                    </span>
                            @endif
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-7">
                            <button type="submit" class="btn btn-success btn-trans waves-effect w-md waves-success m-b-5">
                                Register
                            </button>
                        </div>
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