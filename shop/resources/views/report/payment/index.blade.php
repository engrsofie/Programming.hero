
@extends('layout.app')
	@section('content')
    <style type="text/css">
        .transition_cul_section{margin-left: 0 !important; margin-right: 0 !important;}
    </style>
	<!-- begin #content -->
	<div id="content" class="content">
		
		<div class="row">
		    <div class="col-md-12">
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a class="btn btn-info btn-xs" href="{{URL::to('/payment')}}">View All Payment List</a>
                        </div>
                        <h4 class="panel-title">Payment Report Page </h4>
                    </div>
                    <div class="panel-body">
                        <!-- <form method="post"> -->
                        	<div class="form-group">
								
								<input class="form-control" type="hidden" id="client" name="company_name" placeholder="Company Name" data-parsley-required="true" />
                                <input type="hidden" id="_token" name="_token" value="{{ csrf_token() }}">
                                
							</div>
							
                            <div class="row">
                                <!-- info -->
                                <div class="form-group col-md-6">
                                    <label class="control-label col-md-4 col-sm-4" for="form_date">Form Date * :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <input class="form-control" type="date" id="form_date" name="form_date" placeholder="form_date" data-parsley-required="true" />
                                    </div>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label col-md-4 col-sm-4" for="to_date">To Date * :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <input class="form-control" type="date" id="to_date" name="to_date" placeholder="to_date" data-parsley-required="true" />
                                    </div>
                                </div>
                                <!-- transition -->
                                
                            </div>

							<div class="form-group">
								<label class="control-label col-md-5 col-sm-5"></label>
								<div class="col-md-6 col-sm-6">
									<button type="submit" id="submit" class="btn btn-primary">Confirm</button>
								</div>
							</div>
                            <hr>
                        <!-- </form> -->
                            <div id="show-report"></div>
                        
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
    //
</script>
<script type="text/javascript">
    
    $("#submit").click(function(){
            var _token = $("#_token").val();
            var form_date = $("#form_date").val();
            var to_date = $("#to_date").val();
            //alert(_token);

            $.ajax({
                url: "{{URL::to('/')}}"+'/payment-report-generat',
                type: "POST",
                data: { _token : _token,
                        form_date:  form_date,
                        to_date:  to_date
                         },

                success: function(response){
                    //console.log(response);
                    $("#show-report").html(response);
                }
            });
        });
</script>

@endsection
