
@extends('layout.app')
	@section('content')
	<!-- begin #content -->
	<div id="content" class="content">

		<!-- begin page-header -->
		<h1 class="page-header">Email Config Page </h1>
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
                        {!! Form::open(array('route' => ['email-config.update',$getEmailData->id],'class'=>'form-horizontal author_form','method'=>'PUT','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                            <div class="company_info_section">
                                <div class="form-group">
                                    <label class="control-label col-md-3 col-sm-3" for="client_name">Default Email * :</label>
                                    <div class="col-md-9 col-sm-9">
                                        <input class="form-control" type="text" id="email" name="default_email" data-parsley-type="email" value="<?php echo $getEmailData->default_email; ?>" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3 col-sm-3" for="message_body">Email Message Body* :</label>
                                    <div class="col-md-9 col-sm-9">
                                        <textarea name="message_body" class="textarea form-control" id="wysihtml5" rows="5"><?php echo $getEmailData->message_body; ?></textarea>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="control-label col-md-3 col-sm-3"></label>
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


<!-- ================== BEGIN BASE JS ================== -->

    

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
