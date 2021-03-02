@extends('admin.layout.app')
  @section('content')

<div class="content">
  <div class="container-fluid">
    <div class="row">
      <div class="col-md-12">
        <div class="card ">
          <div class="header">
            <h4 class="title">Update My Profile</h4>
            <hr>
          </div>
          <div class="container_content">
            <div>
                <!-- Nav tabs -->
                <ul class="nav nav-tabs" role="tablist">
                  <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">Edit Profile</a></li>
                  <li role="presentation"><a id="view-slider-info" href="#profile" aria-controls="profile" role="tab" data-toggle="tab">Change Password</a></li>              
                </ul>
                  <!-- Tab panes -->
                  @if(Session::has('errorMyPassword'))
                    <div class="col-md-12">
                      <div class="alert alert-danger alert-dismissable">
                          <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                         <b>{{ Session::get('errorMyPassword') }}</b> 
                         </div>
                    </div>
                  @endif

                <div class="tab-content">
                  <div role="tabpanel" class="tab-pane active" id="home">
                    <div class="row">
                      <div class="col-md-12">
                        <div class="form_insert_section">
                          <!-- start form -->
                          {!! Form::open(array('route' => ['userProfile.update', Auth::user()->id],'method'=>'PUT','class'=>'form-horizontal','files'=>true)) !!}

                          <div class="form-group">
                            {{ Form::hidden('user_type',Auth::user()->user_type,array('class'=>'form-control','required'))}}
                          </div>
                          
                          <div class="form-group {{ $errors->has('full_name') ? 'has-error' : ''}} ">
                            <label class="col-sm-3 control-label">Full Name : <star> *</star></label>
                            <div class="col-sm-9">
                              {{ Form::text('full_name',Auth::user()->full_name,array('class'=>'form-control','required'))}}

                              @if ($errors->has('full_name'))
                                <span class="help-block">
                                  <strong>{{ $errors->first('full_name') }}</strong>
                                </span>
                              @endif
                            </div>
                          </div>
                          <div class="form-group {{ $errors->has('user_name') ? 'has-error' : ''}} ">
                            <label class="col-sm-3 control-label">User Name : <star> *</star></label>
                            <div class="col-sm-9">
                              {{ Form::text('user_name',Auth::user()->user_name,array('class'=>'form-control','required'))}}

                              @if ($errors->has('user_name'))
                                <span class="help-block">
                                  <strong>{{ $errors->first('user_name') }}</strong>
                                </span>
                              @endif
                            </div>
                          </div>
                          <div class="form-group {{ $errors->has('email') ? 'has-error' : ''}} ">
                            <label class="col-sm-3 control-label">Email : <star> *</star></label>
                            <div class="col-sm-9">
                              {{ Form::email('email',Auth::user()->email,array('class'=>'form-control','required'))}}

                              @if ($errors->has('email'))
                                <span class="help-block">
                                  <strong>{{ $errors->first('email') }}</strong>
                                </span>
                              @endif
                            </div>
                          </div>
                          <div class="form-group {{ $errors->has('password') ? 'has-error' : ''}} ">
                            <!-- <label class="col-sm-3 control-label">  <star> </star></label> -->
                            <div class="col-sm-9">
                              {{ Form::hidden('password',Auth::user()->password, ['class' => 'form-control','required'])}}

                              @if ($errors->has('password'))
                                <span class="help-block">
                                  <strong>{{ $errors->first('password') }}</strong>
                                </span>
                              @endif
                            </div>
                          </div>
                          <div class="form-group {{ $errors->has('phone_number') ? 'has-error' : ''}} ">
                            <label class="col-sm-3 control-label">Phone Number : <star> *</star></label>
                            <div class="col-sm-9">
                              {{ Form::text('phone_number',Auth::user()->phone_number,array('class'=>'form-control','required'))}}

                              @if ($errors->has('phone_number'))
                                <span class="help-block">
                                  <strong>{{ $errors->first('phone_number') }}</strong>
                                </span>
                              @endif
                            </div>
                          </div>
                          <div class="form-group {{ $errors->has('gender') ? 'has-error' : ''}} ">
                            <label class="col-sm-3 control-label">Gender : <star> *</star></label>
                            <div class="col-sm-9">
                              {{ Form::select('gender', ['Male' => 'Male', 'Female' => 'Female'], Auth::user()->gender, ['class'=> 'selectpicker','data-title'=> 'Single Select','data-style'=> 'btn-default btn-block','data-menu-style'=>'dropdown-blue'])}}

                              @if ($errors->has('gender'))
                                <span class="help-block">
                                  <strong>{{ $errors->first('gender') }}</strong>
                                </span>
                              @endif
                            </div>
                          </div>
                          <div class="form-group {{ $errors->has('date_of_birth') ? 'has-error' : ''}} ">
                            <label class="col-sm-3 control-label">Date Of Birth : <star> *</star></label>
                            <div class="col-sm-9">
                              {{ Form::date('date_of_birth',Auth::user()->date_of_birth,array('class'=>'form-control','required'))}}

                              @if ($errors->has('date_of_birth'))
                                <span class="help-block">
                                  <strong>{{ $errors->first('date_of_birth') }}</strong>
                                </span>
                              @endif
                            </div>
                          </div>
                          <div class="form-group {{ $errors->has('image_path') ? 'has-error' : ''}} ">
                            <label class="col-sm-3 control-label">Profile Picture</label>
                            <div class="col-sm-5">
                              {{ Form::file('image_path',array('class'=>'form-control','id'=>'home-slider'))}}

                              @if ($errors->has('image_path'))
                                <span class="help-block">
                                  <strong>{{ $errors->first('image_path') }}</strong>
                                </span>
                              @endif
                            </div>
                            <div class="col-sm-4">
                              <img id="home-slider-update-show" class="img img-responsive live_img_view" src="images/user/{{ Auth::user()->image_path }}">
                            </div>
                          </div>
                          <div class="form-group">
                            {{ Form::hidden('created_by',Auth::user()->created_by,array('class'=>'form-control'))}}
                            {{ Form::hidden('updated_by',Auth::user()->email,array('class'=>'form-control'))}}
                          </div>
                          
                          <div class="form-group">
                            <div class="col-sm-offset-3 col-sm-9">
                              <div class="category"><star>*</star> Required fields</div>
                            </div>
                          </div>
                          <div class="form-group">
                            <div class="col-sm-offset-3 col-sm-9">
                              <!-- {{ Form::submit('Confirm') }} --> 
                              <button type="submit" class="btn btn-success">
                                <span class="btn-label">
                                    <i class="fa fa-check"></i>
                                </span>
                                Update
                              </button>
                            </div>
                          </div>
                        {!! Form::close() !!}
                        </div>
                      </div>
                    </div>
                  </div><!-- end tab pane add -->
                  <div role="tabpanel" class="tab-pane slider_view_section" id="profile">
                    <div class="row">
                        <!-- table start -->
                        
                      <div class="col-md-12">
                        <div class="form_insert_section">
                          <!-- start form -->
                          {!! Form::open(array('route' => 'myPassword','method'=>'POST','class'=>'form-horizontal')) !!}

                            <div class="form-group {{ $errors->has('password') ? 'has-error' : ''}} ">
                              <label class="col-sm-4 control-label">Old Password  <star> *</star></label>
                              <div class="col-sm-8">
                                {{ Form::password('old_password', ['class' => 'form-control','placeholder'=>'Old Password','required'])}}

                                @if ($errors->has('old_password'))
                                  <span class="help-block">
                                    <strong>{{ $errors->first('old_password') }}</strong>
                                  </span>
                                @endif
                                
                              </div>
                            </div>
                            <div class="form-group {{ $errors->has('password') ? 'has-error' : ''}} ">
                              <label class="col-sm-4 control-label">New Password  <star> *</star></label>
                              <div class="col-sm-8">
                                {{ Form::password('password', ['class' => 'form-control','placeholder'=>'New Password','required'])}}

                                @if ($errors->has('password'))
                                  <span class="help-block">
                                    <strong>{{ $errors->first('password') }}</strong>
                                  </span>
                                @endif
                              </div>
                            </div>
                            <div class="form-group {{ $errors->has('password_confirmation') ? 'has-error' : ''}} ">
                              <label class="col-sm-4 control-label">Confirm New Password : <star> *</star></label>
                              <div class="col-sm-8">
                                {{ Form::password('password_confirmation', ['class' => 'form-control','placeholder'=>'Confirm Password','required'])}}
                                
                                @if ($errors->has('password_confirmation'))
                                  <span class="help-block">
                                    <strong>{{ $errors->first('password_confirmation') }}</strong>
                                  </span>
                                @endif
                              </div>
                            </div>
                            {{Form::hidden('id',Auth::user()->id)}}
                            <div class="form-group">
                              <div class="col-sm-offset-4 col-sm-8">
                                <button type="submit" class="btn btn-warning">
                                  <span class="btn-label">
                                    <i class="fa fa-check"></i>
                                  </span>
                                  Update
                                </button>
                              </div>
                            </div>
                          {!! Form::close() !!}
                        </div>
                      </div>
                  </div>
                </div><!-- end tab pane view -->
              </div>
            </div>
          
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
  <script src="{{ asset('backend/assets/js/jquery.min.js') }}" type="text/javascript"></script>
  <script type="text/javascript">
    $(document).ready(function(){
        function readURL(input) {
            if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#home-slider-show').attr('src', e.target.result);
            }
                reader.readAsDataURL(input.files[0]);
            }
        }

        $("#home-slider").change(function(){
            readURL(this);
        });
    });
  </script>
  <script type="text/javascript">
    $(document).ready(function(){
        function readURL(input) {
            if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#home-slider-update-show').attr('src', e.target.result);
            }
                reader.readAsDataURL(input.files[0]);
            }
        }

        $("#home-slider-update").change(function(){
            readURL(this);
        });
    });
  </script>
  @endsection
    