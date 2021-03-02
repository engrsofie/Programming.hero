
	@extends('layout.app')
		@section('content')
		<!-- begin #content -->
		<div id="content" class="content">
			
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                                
                            </div>
                            <h4 class="panel-title">Categories Page </h4>
                        </div>
                        <div class="panel-body">
                        	<div class="create_button">
                        		<a href="ui_modal_notification.html#modal-dialog" class="btn btn-sm btn-success" data-toggle="modal">Add New Category</a>
                        	</div>
                            <!-- #modal-dialog -->
                            <div class="modal fade" id="modal-dialog">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                    {!! Form::open(array('route' => 'inventory-categories.store','class'=>'form-horizontal author_form','method'=>'POST','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                            <h4 class="modal-title">category set</h4>
                                        </div>
                                        <div class="modal-body">
                                        	<div class="form-group">
												<label class="control-label col-md-4 col-sm-4">Category status :</label>
												<div class="col-md-2 col-sm-2">
													<div class="radio">
														<label>
															<input type="radio" name="status" value="1" id="radio-required" data-parsley-required="true" checked /> Active
														</label>
													</div>
												</div>
												<div class="col-md-4 col-sm-4">
													<div class="radio">
														<label>
															<input type="radio" name="status" id="radio-required2" value="0" /> Inactive
														</label>
													</div>
												</div> 
											</div>
                                            <div class="form-group">
			                                    <label class="control-label col-md-4 col-sm-4">Category Name *:</label>
			                                    <div class="col-md-8 col-sm-8">
			                                     	<input type="text" class="form-control" name="category_name" value="" placeholder="Enter category Name">
			                                    </div>
			                                </div>
			                                   
                                        </div>
                                        <div class="modal-footer">
                                            <a href="javascript:;" class="btn btn-sm btn-white" data-dismiss="modal">Close</a>
                                            <button type="submit" class="btn btn-sm btn-success">Confirm</button>
                                        </div>
                                    {!! Form::close(); !!}
                                    </div>
                                </div>
                            </div>    
                        </div>
                        <!--  -->
                        <div class="view_category_set">
                        	<div class="panel-body">
	                            <table id="data-table" class="table table-striped table-bordered nowrap" width="100%">
	                                <thead>
	                                    <tr>
	                                        <th width="10%">Sl</th>
	                                        <th width="65%">Category Name</th>
	                                        <th width="10%">status</th>
	                                        <th width="15%">Action</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <?php $i=0; ?>
	                                @foreach($getCategoryData as $category)
	                                <?php $i++; ?>
	                                    <tr class="odd gradeX">
	                                        <td>{{$i}}</td>
	                                        <td>{{$category->category_name}}</td>
	                                        <td>
	                                        	@if($category->status=="1")
	                                        		{{"Active"}}
	                                        	@else
	                                        		{{"Inactive"}}
	                                        	@endif
	                                        </td>
	                                        <td>
	                                        <!-- edit section -->
	                                            <a href="ui_modal_notification.html#modal-dialog<?php echo $category->id;?>" class="btn btn-sm btn-success" data-toggle="modal"><i class="fa fa-pencil-square-o" aria-hidden="true" style="font-size: 18px;"></i></a>
	                                            <!-- #modal-dialog -->
	                                            <div class="modal fade" id="modal-dialog<?php echo $category->id;?>">
	                                                <div class="modal-dialog">
	                                                    <div class="modal-content">
	                                                    {!! Form::open(array('route' => ['inventory-categories.update',$category->id],'class'=>'form-horizontal author_form','method'=>'PUT','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
	                                                        <div class="modal-header">
	                                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                                                            <h4 class="modal-title">Modal Dialog</h4>
	                                                        </div>
	                                                        <div class="modal-body">
	                                                            
	                                                            <div class="form-group">
	                                                                <label class="control-label col-md-4 col-sm-4" for="category_name">category Name * :</label>
	                                                                <div class="col-md-8 col-sm-8">
	                                                                    <input class="form-control" type="text" id="category_name" name="category_name" value="<?php echo $category->category_name; ?>" data-parsley-required="true" />
	                                                                </div>
	                                                            </div>
	                                                            
	                                                            <div class="form-group">
	                                                                <label class="control-label col-md-4 col-sm-4">category status :</label>
	                                                                <div class="col-md-3 col-sm-3">
	                                                                    <div class="radio">
	                                                                        <label>
	                                                                            <input type="radio" name="status" value="1" id="radio-required" data-parsley-required="true" @if($category->status=="1"){{"checked"}}@endif> Active
	                                                                        </label>
	                                                                    </div>
	                                                                </div>
	                                                                <div class="col-md-4 col-sm-4">
	                                                                    <div class="radio">
	                                                                        <label>
	                                                                            <input type="radio" name="status" id="radio-required2" value="0" @if($category->status=="0"){{"checked"}}@endif> Inactive
	                                                                        </label>
	                                                                    </div>
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
	                                            <!-- end edit section -->

	                                            <!-- delete section -->
	                                            {!! Form::open(array('route'=> ['inventory-categories.destroy',$category->id],'method'=>'DELETE')) !!}
	                                                {{ Form::hidden('id',$category->id)}}
	                                                <button type="submit" onclick="return confirmDelete();" class="btn btn-danger">
	                                                  <i class="fa fa-trash-o" aria-hidden="true"></i>
	                                                </button>
	                                            {!! Form::close() !!}
	                                            <!-- delete section end -->
	                                        </td>
	                                    </tr>
	                                @endforeach
	                                </tbody>
	                            </table>
	                        </div>	
                        </div>
                    </div>
			    </div>
			</div>
		</div>
		<!-- end #content -->
    @endsection
