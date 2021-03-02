
	@extends('layout.app')
		@section('content')
		<!-- begin #content -->
		<div id="content" class="content">
			
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                            	<a class="btn btn-info btn-xs" href="{{URL::to('/inventory-product')}}">View All product List</a>
                                
                            </div>
                            <h4 class="panel-title">Add new product</h4>
                        </div>
                        <div class="panel-body">
                            {!! Form::open(array('route' => 'inventory-product.store','class'=>'form-horizontal author_form','method'=>'POST','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                                
                            	
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4" for="product_name">Product Name * :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <input class="form-control" type="text" id="product_name" name="product_name" placeholder="Product Name" data-parsley-required="true" />
                                        <span id="product_name_status" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4" for="specification">Product Category *:</label>
                                    <div class="col-md-6 col-sm-6">
                                        <select class="form-control select" id="category" name="fk_category_id" data-parsley-required="true">
                                            <option value="">Please choose</option>
                                            @foreach($getCategories as $category)
                                                <option value="<?php echo $category->id; ?>"><?php echo $category->category_name; ?></option>
                                            @endforeach
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4" for="smallUnit">Product Unit:</label>
                                    <div class="col-md-6">
                                        <select class="form-control select" id="smallUnit" name="fk_small_unit_id">
                                            <option value="">Please choose</option>
                                            @foreach($smallUnit as $unit)
                                                <option value="<?php echo $unit->id; ?>"><?php echo $unit->small_unit_name; ?></option>
                                            @endforeach
                                        </select>
                                    </div>
                                  
                                </div>
                               <input type="hidden" name="stock_limitation" value="0">
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4">Product Status *:</label>
                                    <div class="col-md-4">
                                        {{Form::select('status',['1'=>'Active','0'=>'Inactive'],'1',['class'=>'form-control','id'=>'status'])}}
                                    </div>
                                </div>
								<div class="form-group">
									<label class="control-label col-md-4 col-sm-4"></label>
									<div class="col-md-6 col-sm-6">
										<button type="button" id="submit" class="btn btn-primary">Confirm</button>
                                        <p id="result"></p>
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
        $('#submit').on('click',function(){
            var _token='{{csrf_token()}}';
            var product_name=$('#product_name').val();
            var category=$('#category').val();
            var unit=$('#smallUnit').val();
            var status=$('#status').val();

            if(product_name.length==0 | category.length==0 | unit.length==0 ){
                alert('Empty Value Found!');
            }else{

                $.ajax({
                    type: "POST",
                    url: '../inventory-product',
                    data: {_token:_token,product_name: product_name,category: category,unit: unit,status: status},
                    success: function(result) {
                        console.log(result);
                        $('#result').html(result)
                        $('#product_name').val('');
                    }
                });

            }

        });



       
    </script>
    @endsection
