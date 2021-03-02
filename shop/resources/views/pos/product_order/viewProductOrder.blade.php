	@extends('layout.app')
		@section('content')
        <style type="text/css">
            form{display: inline;}
            .form-group{width: 100%;height: auto; overflow: hidden; display: block !important; margin: 5px;}
            .form-control{width: 100% !important;}
        </style>
		<!-- begin #content -->
		<div id="content" class="content">
			
			
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                                <a class="btn btn-info btn-xs" href="{{URL::to('/inventory-product-order/create')}}">Add New Product Order</a>
                                
                            </div>
                            <h4 class="panel-title">Product Order Page </h4>
                        </div>
                        <div class="panel-body">
                            <table class="table table-striped table-bordered nowrap" width="100%">
                                <thead>
                                    <tr>
                                        <th>Order Id</th>
                                        <th>L/C No.</th>
                                        <th>L/C Opening</th>
                                        <th>Comapny Name</th>
                                        <th>Order Date</th>
                                        <th>Total Amount</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                @foreach($getProductOrder as $product)
                                    <tr class="odd gradeX">
                                        <td><a target="_blank" href='{{URL::to("inventory-order-browser/$product->inventory_order_id")}}'>{{$product->inventory_order_id}}</a></td>
                                        
                                        <td>{{$product->lc_no}} </td>
                                        <td>{{date('d-m-Y',strtotime($product->opening_date))}} </td>
                                        <td>{{$product->company_name}} </td>
                                        <td>{{date('d-m-Y',strtotime($product->order_date))}}</td>
                                        
                                        <td>{{round($product->total_amount,2)}} </td>
                                        <td>
                                            @if($product->status!=1)
                                            <b class="text-success">Added</b>
                                            @else
                                            <b class="text-warning">Pending</b>
                                        @endif
                                        </td>
                                        <td>
                                            <!-- view single order -->
                                            <a href='{{URL::to("inventory-product-order/$product->id")}}' class="btn btn-xs btn-info" title="view description"><i class="fa fa-eye"></i></a>
                                            <a href='{{URL::to("inventory-product-order/$product->id/edit")}}' class="btn btn-xs btn-primary" title="view description"><i class="fa fa-pencil-square" aria-hidden="true"></i></a>
                                            <!-- delete section -->
                                                {!! Form::open(array('route'=> ['inventory-product-order.destroy',$product->id],'method'=>'DELETE')) !!}
                                                    {{ Form::hidden('id',$product->id)}}
                                                    <button type="submit" onclick="return confirmDelete();" class="btn btn-xs btn-danger">
                                                      <i class="fa fa-trash-o" aria-hidden="true"></i>
                                                    </button>
                                                {!! Form::close() !!}
                                                <!-- delete section end -->
                                        </td>
                                    </tr>
                                @endforeach
                                </tbody>
                            </table>
                            <div class="pull-right">
                                {{$getProductOrder->render()}}
                            </div>
                        </div>
                    </div>
			    </div>
			</div>
		</div>
		<!-- end #content -->
		
    <script src="{{asset('public/plugins/jquery/jquery-1.9.1.min.js')}}"></script>
    <script type="text/javascript">
        
        function confirmStore(){
            return confirm("Do You Sure Want To Store to Inventory This Data ?");
        }
    </script>
    @endsection
