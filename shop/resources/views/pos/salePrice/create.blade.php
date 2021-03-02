
	@extends('layout.app')
		@section('content')
		<!-- begin #content -->
		<div id="content" class="content">
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <h4 class="panel-title">Client wise sale price</h4>
                        </div>
                        <div class="panel-body">
                            <div class="col-md-5 col-md-offset-4">
                                <div class="form-group">
                                    <label class="col-md-4" for="client">Select Client * :</label>
                                    <div class="col-md-8">
                                        {{Form::select('fk_client_id',$clients,'',['class'=>'form-control select','placeholder'=>'Select Client','required','id'=>'client','onchange'=>"loadProduct(this.value)"])}}
                                        <span class="help-text" id="section_error"></span>
                                    </div>
                                </div>
                            </div>
                        	    
                            <div id="all-products">
                                
                            </div>

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
	        FormPlugins.init();
	        //
	    });
    </script>
    @endsection
@section('script')
<script type="text/javascript">
    function loadProduct(id){
        var url='{{URL::to("inventory-sales-price")}}/'+id;
        window.location = url;
        $('#all-products').load(url);
    }
    
</script>
@endsection