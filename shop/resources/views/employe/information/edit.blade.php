
	@extends('layout.app')
		@section('content')
		<!-- begin #content -->
		<div id="content" class="content">
			
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                            	<a class="btn btn-info btn-xs" href="{{URL::to('/employe-information')}}">All Employee</a>
                                
                            </div>
                            <h4 class="panel-title">Edit Employee Information</h4>
                        </div>
                        <div class="panel-body">
                            {!! Form::open(array('route' => ['employe-information.update',$data->id],'class'=>'form-horizontal author_form','method'=>'PUT','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                                <div class="form-group {{ $errors->has('employe_name') ? 'has-error' : '' }}">
                                    <label class="control-label col-md-4 col-sm-4" for="employe_name">Employe Name * :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <input value="{{$data->employe_name}}" class="form-control" type="text" id="employe_name" name="employe_name" placeholder="Employe Name" data-parsley-required="true" />
                                        @if ($errors->has('employe_name'))
                                            <span class="help-block" style="display:block">
                                                <strong>{{ $errors->first('employe_name') }}</strong>
                                            </span>
                                        @endif
                                    </div>
                                </div>
                                <div class="form-group {{ $errors->has('employe_id') ? 'has-error' : '' }}">
                                    <label class="control-label col-md-4 col-sm-4" for="employe_id">Employe ID * :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <input value="{{$data->employe_id}}" class="form-control" type="text" id="employe_id" name="employe_id" placeholder="Employe ID" data-parsley-required="true" />
                                        @if ($errors->has('employe_id'))
                                            <span class="help-block" style="display:block">
                                                <strong>{{ $errors->first('employe_id') }}</strong>
                                            </span>
                                        @endif
                                    </div>
                                </div>
                                <div class="form-group {{ $errors->has('designation') ? 'has-error' : '' }}">
                                    <label class="control-label col-md-4 col-sm-4" for="designation">Designation * :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <input value="{{$data->designation}}"  class="form-control" type="text" id="designation" name="designation" placeholder="Employe Designation" data-parsley-required="true" />
                                        @if ($errors->has('designation'))
                                            <span class="help-block" style="display:block">
                                                <strong>{{ $errors->first('designation') }}</strong>
                                            </span>
                                        @endif
                                    </div>
                                </div>
                                <div class="form-group {{ $errors->has('fk_section_id') ? 'has-error' : '' }}">
									<label class="control-label col-md-4 col-sm-4">Section * :</label>
									<div class="col-md-6 col-sm-6">
										{{Form::select('fk_section_id',$section,$data->fk_section_id,['class'=>'form-control','placeholder'=>'Select Section','required'])}}
                                        @if ($errors->has('fk_section_id'))
                                            <span class="help-block" style="display:block">
                                                <strong>{{ $errors->first('fk_section_id') }}</strong>
                                            </span>
                                        @endif
									</div>
								</div>
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4" for="email">Email :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <input value="{{$data->employe_email}}" class="form-control" type="email" id="email" name="employe_email" data-parsley-type="email" placeholder="Email" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4" for="address">Address  :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <textarea class="form-control" id="address" name="address" rows="2"  placeholder="Address">{{$data->address}}</textarea>
                                    </div>
                                </div>
                                <div class="form-group">
									<label class="control-label col-md-4 col-sm-4" for="number">Moblie No.  :</label>
									<div class="col-md-6 col-sm-6">
										<input value="{{$data->mobile_number}}" class="form-control" type="number" min="0" id="number" name="mobile_number" data-parsley-type="number" placeholder="Mobile Number" />
									</div>
								</div>
								<div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4" for="basic_pay">Basic Pay :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <input value="{{$data->basic_pay}}" class="form-control" type="text" id="basic_pay" name="basic_pay" placeholder="Basic Pay" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4" for="house_rent">House Rent :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <input value="{{$data->house_rent}}" class="form-control" type="text" id="house_rent" name="house_rent" placeholder="House Rent" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4" for="medical_allowance">Medical Allowance :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <input value="{{$data->medical_allowance}}" class="form-control" type="text" id="medical_allowance" name="medical_allowance" placeholder="Medical Allowance" />
                                    </div>
                                </div>
                                <div class="form-group col-md-12 {{ $errors->has('photo') ? 'has-error' : ''}} ">
                                    <label class="control-label col-sm-4">Photo </label>
                                    <div class="col-md-5">
                                      <label class="slide_upload profile" for="file">
                                        @if($data->photo!=null)
                                          <img id="image_load" src='{{asset("images/employee/$data->photo")}}'>
                                        @else

                                          <img id="image_load">
                                        @endif
                                      </label>
                                      <input type="file" id="file" name="photo" onchange="readURL(this,this.id)" style="display:none">
                                       @if ($errors->has('photo'))
                                          <span class="help-block" style="display:block">
                                              <strong>{{ $errors->first('photo') }}</strong>
                                          </span>
                                        @endif
                                    </div>
                                </div>
								<div class="form-group">
									<label class="control-label col-md-4 col-sm-4">Status :</label>
									<div class="col-md-1 col-sm-1">
										<div class="radio">
											<label>
												<input type="radio" name="status" value="1" id="radio-required" data-parsley-required="true" {{($data->status==1)?'checked':''}} /> Active
											</label>
										</div>
									</div>
									<div class="col-md-4 col-sm-4">
										<div class="radio">
											<label>
												<input type="radio" name="status" id="radio-required2" value="0" {{($data->status==0)?'checked':''}} /> Inactive
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
    @endsection
    @section('script')
<script type="text/javascript">

 /*end chosen select option */
    function readURL(input,image_load) {
      var target_image='#'+$('#'+image_load).prev().children().attr('id');

        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $(target_image).attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
    

</script>
@endsection
