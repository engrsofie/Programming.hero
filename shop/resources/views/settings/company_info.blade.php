
@extends('layout.app')
	@section('content')
	<!-- begin #content -->
	<div id="content" class="content">

		<!-- begin page-header -->
		<h1 class="page-header">Company Info Page </h1>
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
                        {!! Form::open(array('route' => ['company-info.update',$getCompanyData->id],'class'=>'form-horizontal author_form','method'=>'PUT','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                            <div class="company_info_section">
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4" for="company_name">Company Name * :</label>
                                    <div class="col-md-8 col-sm-8">
                                        <input class="form-control" type="text" id="company_name" name="company_name" value="<?php echo $getCompanyData->company_name; ?>" data-parsley-required="true" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4" for="client_name">Company Email * :</label>
                                    <div class="col-md-8 col-sm-8">
                                        <input class="form-control" type="text" id="email" name="company_email" data-parsley-type="email" value="<?php echo $getCompanyData->company_email; ?>" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4" for="client_name">Company Address * :</label>
                                    <div class="col-md-8 col-sm-8">
                                        <textarea class="form-control" id="address" name="company_address" rows="4"><?php echo $getCompanyData->company_address; ?></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4" for="client_name">Shipping Address * :</label>
                                    <div class="col-md-8 col-sm-8">
                                        <textarea class="form-control" id="address" name="shipping_address" rows="4"><?php echo $getCompanyData->shipping_address; ?></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4" for="client_name">Company Mobile No. * :</label>
                                    <div class="col-md-8 col-sm-8">
                                        <input class="form-control" type="text" id="number" name="company_phone" data-parsley-type="number" value="<?php echo $getCompanyData->company_phone; ?>" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4" for="web_address">Company Web Address * :</label>
                                    <div class="col-md-8 col-sm-8">
                                        <input class="form-control" type="text" id="web_address" name="web_address" value="<?php echo $getCompanyData->web_address; ?>"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4" for="fb_page_link">Company Fb Page Link * :</label>
                                    <div class="col-md-8 col-sm-8">
                                        <input class="form-control" type="text" id="fb_page_link" name="fb_page_link" value="<?php echo $getCompanyData->fb_page_link; ?>"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group col-md-12 {{ $errors->has('company_logo') ? 'has-error' : ''}} ">
                                            <label class="control-label col-sm-7">Company Logo * </label>
                                            <div class="col-md-5">
                                              <label class="slide_upload" for="file">
                                                  <!--  -->
                                                  <img id="image_load" src='{{asset("images/company/logo/$getCompanyData->company_logo")}}'>
                                              </label>
                                              <input type="file" id="file" name="company_logo" onchange="readURL(this,this.id)" style="display:none">
                                               @if ($errors->has('company_logo'))
                                                  <span class="help-block" style="display:block">
                                                      <strong>{{ $errors->first('company_logo') }}</strong>
                                                  </span>
                                                @endif
                                            </div>
                                          </div>   
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group col-md-12 {{ $errors->has('company_icon') ? 'has-error' : ''}} ">
                                            <label class="control-label col-sm-7">Company Ico * </label>
                                            <div class="col-md-5">
                                              <label class="slide_upload" for="file-ico">
                                                  <!--  -->
                                                  <img id="image_load_ico" src='{{asset("images/company/ico/$getCompanyData->company_icon")}}'>
                                              </label>
                                              <input type="file" id="file-ico" name="company_icon" onchange="readURL(this,this.id)" style="display:none">
                                               @if ($errors->has('company_icon'))
                                                  <span class="help-block" style="display:block">
                                                      <strong>{{ $errors->first('company_icon') }}</strong>
                                                  </span>
                                                @endif
                                            </div>
                                          </div>   
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4"></label>
                                    <div class="col-md-6 col-sm-6">
                                        <button type="submit" class="btn btn-primary">Comfirm</button>
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
	
<script src="{{asset('public/plugins/jquery/jquery-1.9.1.min.js')}}"></script>  
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
<script type="text/javascript">
	$(document).ready(function() {
        App.init();
        DashboardV2.init();
        //
    });
</script>
@endsection
