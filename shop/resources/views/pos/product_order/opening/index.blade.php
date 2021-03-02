@extends('layout.app')
@section('content')
<div class="row">
    <div class="col-md-12">
        <div class="panel panel-inverse">
            <div class="panel-heading"> 
                <div class="panel-heading-btn">
                        <a class="btn btn-info btn-xs" href="{{URL::to('/inventory-product-opening/create')}}">Add new Opening Product</a>
                        
                    </div>
                <h4 class="panel-title">Opening Products</h4>
            </div>
            <div class="panel-body">
	            <table class="table table-hover table-bordered">
	            	<thead>
	            		<tr class="active">
	            			<th width="5%">SL</th>
	            			<th>Product ID</th>
	            			<th>Product Name</th>
                            <th>Cost Per unit</th>
	            			<th>Sales Per unit</th>
                            <th>Quantity</th>
	            			<th>Date</th>
	            			<th width="10%">Action</th>
	            		</tr>
	            	</thead>
	            	<tbody>
	            		
	            		<? $i=0; ?>
	            		@foreach($allData as $data)
	            		<? $i++; ?>
	            		<tr>
	            			<td>{{$i}}</td>
	            			<td>{{$data->product_id}}</td>
	            			<td>{{$data->product_name}}</td>
                            <td>{{$data->cost_per_unit}}</td>
                            <td>{{$data->sales_per_unit}}</td>
                            <td>{{$data->qty}}</td>
	            			<td>{{date('jS M, Y',strtotime($data->created_at))}}</td>
	            			<td>
	            			
	            			<a href="ui_modal_notification.html#modal-dialog<?php echo $data->id;?>" class="btn btn-xs btn-success" data-toggle="modal"><i class="fa fa-pencil-square-o" aria-hidden="true" style="font-size: 18px;"></i></a>
                                            <!-- #modal-dialog -->
                                            <div class="modal fade" id="modal-dialog<?php echo $data->id;?>">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                    {!! Form::open(array('route' => ['inventory-product-opening.update',$data->id],'class'=>'form-horizontal author_form','method'=>'PUT','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                                                        <div class="modal-header">
                                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                            <h4 class="modal-title">{{$data->product_name}}</h4>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-4 col-sm-4" for="cost_per_unit">Cost per Unit</label>
                                                                <div class="col-md-8 col-sm-8">
                                                                    <input class="form-control" type="number" step="any" min="0" id="cost_per_unit" name="cost_per_unit" value="{{$data->cost_per_unit}}" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label col-md-4 col-sm-4" for="sales_per_unit">Sales per Unit</label>
                                                                <div class="col-md-8 col-sm-8">
                                                                    <input class="form-control" type="number" step="any" min="0" id="sales_per_unit" name="sales_per_unit" value="{{$data->sales_per_unit}}" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label col-md-4 col-sm-4" for="qty">Quantity</label>
                                                                <div class="col-md-8 col-sm-8">
                                                                    <input class="form-control" type="number" step="any" min="0" id="qty" name="qty" value="{{$data->qty}}" />
                                                                </div>
                                                            </div>
                                                             
                                                        </div>
                                                        <div class="modal-footer">
                                                            <a href="javascript:;" class="btn btn-sm btn-white" data-dismiss="modal">Close</a>
                                                            <button type="submit" class="btn btn-sm btn-success">Update</button>
                                                        </div>
                                                    {!! Form::close(); !!}
                                                    </div>
                                                </div>
                                            </div>
	            			{!! Form::open(array('route'=> ['inventory-product-opening.destroy',$data->id],'method'=>'DELETE')) !!}
                                {{ Form::hidden('id',$data->id)}}
                                <button type="submit" onclick="return confirmDelete();" class="btn btn-xs btn-danger">
                                  <i class="fa fa-trash-o" aria-hidden="true"></i>
                                </button>
                            {!! Form::close() !!}
	            			</td>
	            		</tr>
	            		@endforeach
	            	</tbody>
	            </table>
            </div>
        </div>
    </div>
</div>

@stop