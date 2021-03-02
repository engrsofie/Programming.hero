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
                            <h4 class="panel-title">Receive Executive</h4>
                        </div>
                        <div class="panel-body">
                        	<div class="create_button">
                        		<a href="ui_modal_notification.html#modal-dialog" class="btn btn-sm btn-success" data-toggle="modal">Add New </a>
                        	</div>
                            <!-- #modal-dialog -->
                            <div class="modal fade" id="modal-dialog">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                    {!! Form::open(array('route' => 'inventory-receive-executive.store','class'=>'form-horizontal author_form','method'=>'POST','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                            <h4 class="modal-title">Receive Executive</h4>
                                        </div>
                                        <div class="modal-body">
                                        	<div class="form-group">
									<label class="control-label col-md-3 col-sm-3" for="executive_name">Executive Name :</label>
									<div class="col-md-8 col-sm-8">
										<input class="form-control" type="text" id="executive_name" name="executive_name" placeholder="Executive Name" data-parsley-required="true" required />
									</div>
								</div>
								
                                <div class="form-group">
                                    <label class="control-label col-md-3 col-sm-3" for="details">Details * :</label>
                                    <div class="col-md-8 col-sm-8">
                                    <textarea class="form-control" id="details" name="details" placeholder="Details"></textarea>
                                    </div>
                                </div>
								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3"> Status :</label>
									<div class="col-md-1 col-sm-1">
										<div class="radio">
											<label>
												<input type="radio" name="status" value="1" id="radio-required" data-parsley-required="true" checked /> Active
											</label>
										</div>
									</div>
									<div class="col-md-3 col-sm-3">
										<div class="radio">
											<label>
												<input type="radio" name="status" id="radio-required2" value="0" /> Inactive
											</label>
										</div>
									</div> 
								</div>
			                                   
                                        </div>
                                        <div class="modal-footer">
                                            <a href="javascript:;" class="btn btn-sm btn-white" data-dismiss="modal">Close</a>
                                            <button type="submit" class="btn btn-sm btn-success">Submit</button>
                                        </div>
                                    {!! Form::close(); !!}
                                    </div>
                                </div>
                            </div>    
                        </div>
                        <!--  -->
                        <div class="view_brand_set">
                        	<div class="panel-body">
	                            <table id="data-table" class="table table-striped table-bordered nowrap" width="100%">
	                                <thead>
	                                    <tr>
	                                        <th width="10%">Sl</th>
	                                        <th>Executive Name</th>
	                                        <th width="10%">status</th>
	                                        <th width="15%">Action</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <?php $i=0; ?>
	                                @foreach($allData as $data)
	                                <?php $i++; ?>
	                                    <tr class="odd gradeX">
	                                        <td>{{$i}}</td>
	                                        <td>{{$data->executive_name}}</td>
	                                        <td>
	                                        	@if($data->status=="1")
	                                        		{{"Active"}}
	                                        	@else
	                                        		{{"Inactive"}}
	                                        	@endif
	                                        </td>
	                                        <td>
	                                        <!-- edit section -->
	                                            <a href="ui_modal_notification.html#modal-dialog<?php echo $data->id;?>" class="btn btn-xs btn-success" data-toggle="modal"><i class="fa fa-pencil-square-o" aria-hidden="true" style="font-size: 18px;"></i></a>
	                                            <!-- #modal-dialog -->
	                                            <div class="modal fade" id="modal-dialog<?php echo $data->id;?>">
	                                                <div class="modal-dialog modal-lg">
	                                                    <div class="modal-content">
	                                                    {!! Form::open(array('route' => ['inventory-receive-executive.update',$data->id],'class'=>'form-horizontal author_form','method'=>'PUT','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
	                                                        <div class="modal-header">
	                                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                                                            <h4 class="modal-title">Edit Executive</h4>
	                                                        </div>
	                                                        <div class="modal-body">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-4 col-sm-4" for="executive_name">Executive Name</label>
                                                                <div class="col-md-8 col-sm-8">
                                                                    <input class="form-control" type="text" id="executive_name" name="executive_name" value="<?php echo $data->executive_name; ?>" data-parsley-required="true" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label col-md-4 col-sm-4" for="details">Details * :</label>
                                                                <div class="col-md-8 col-sm-8">
                                                                <textarea class="form-control" id="details" name="details" placeholder="Details"><?php echo $data->details; ?></textarea>
                                                                </div>
                                                            </div>
                                                           
                                                            <div class="form-group">
                                                                <label class="control-label col-md-4 col-sm-4"> Status :</label>
                                                                <div class="col-md-3 col-sm-3">
                                                                    <div class="radio">
                                                                        <label>
                                                                            <input type="radio" name="status" value="1" id="radio-required" data-parsley-required="true" @if($data->status=="1"){{"checked"}}@endif> Active
                                                                        </label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4 col-sm-4">
                                                                    <div class="radio">
                                                                        <label>
                                                                            <input type="radio" name="status" id="radio-required2" value="0" @if($data->status=="0"){{"checked"}}@endif> Inactive
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
	                                            {!! Form::open(array('route'=> ['inventory-receive-executive.destroy',$data->id],'method'=>'DELETE')) !!}
	                                                {{ Form::hidden('id',$data->id)}}
	                                                <button type="submit" onclick="return confirmDelete();" class="btn btn-danger btn-xs">
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
		
    <script src="{{asset('public/plugins/jquery/jquery-1.9.1.min.js')}}"></script>        
    <script type="text/javascript">
    	$(document).ready(function() {
	        App.init();
	        DashboardV2.init();
	        //
	    });
    </script>
    @endsection
