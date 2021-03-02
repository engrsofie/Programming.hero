
	@extends('layout.app')
		@section('content')
		<!-- begin #content -->
		<div id="content" class="content">
			 {!! Form::open(array('route' => 'inventory-sales-price.store','class'=>'form-horizontal author_form','method'=>'POST','id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <h4 class="panel-title">Client wise salse price</h4>
                        </div>
                        <div class="panel-body">
                            <div class="col-md-4 col-md-offset-4">
                                <div class="form-group">
                                    <label class="col-md-4" for="client">Select Client * :</label>
                                    <div class="col-md-8">
                                        {{Form::select('fk_client_id',$clients,$id,['class'=>'form-control select','placeholder'=>'Select Client','required','id'=>'client','onchange'=>"loadProduct(this.value)"])}}
                                        <span class="help-text" id="section_error"></span>
                                    </div>
                                </div>
                            </div>
                        	    
                            <div id="all-products">
                                <table class="table table-bordered">
									<thead>
										<tr>
											<th>SL</th>
											<th>Product ID</th>
											<th>Product Name</th>
											<th>Cost Per unit</th>
											<th>Sales Price</th>
										</tr>
									</thead>
									<tbody>
									<? $i=0 ?>
									@foreach($products as $data)
									<? $i++ ?>
										<tr>
											<td>{{$i}}</td>
											<td>{{$data->product_id}}</td>
											<td>{{$data->product_name}}
											</td>
											<td>{{round($data->sales_per_unit,2)}}</td>
											<td>
											@if(isset($data->sale_price))
											<input type="number" min="0" step="any" name="old_sales_price[]" class="form-control" value="{{$data->sale_price}}">
											<input type="hidden" name="fk_product_id[]" value="{{$data->id}}">
											<input type="hidden" name="sale_price_id[]" value="{{$data->sale_price_id}}">
											@else
											<input type="hidden" name="product_id[]" value="{{$data->id}}">
											<input type="number" min="0" step="any" name="sales_price[]" class="form-control">
											@endif
											</td>
										</tr>
									@endforeach
									</tbody>
								</table>
                            </div>
                            <div class="col-md-12">
                            	<button class="btn btn-success pull-right">Submit</button>
                            </div>
                        </div>
                    </div>
			    </div>
			</div>
			{{Form::close()}}
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