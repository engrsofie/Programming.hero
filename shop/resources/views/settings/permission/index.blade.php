
	@extends('layout.app')
		@section('content')
		<!-- begin #content -->
		<div id="content" class="content">
			
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                                <a href="{{URL::to('acl-permission/roles')}}" class="btn btn-success btn-xs">Set Permission to Roles</a>
                            </div>
                            <h4 class="panel-title">ACL Permission</h4>
                        </div>
                        <div class="panel-body">
                        	{!! Form::open(array('route' => 'acl-permission.store','class'=>'form-horizontal','method'=>'POST','role'=>'form','data-parsley-validate novalidate')) !!}
                        	<div class="form-group">
                                <label class="control-label col-md-3">Permission Name *:</label>
                                <div class="col-md-7">
                                 	<input type="text" class="form-control" name="name" value="" placeholder="Permission Name">
                                </div>
                                <div class="col-md-2">
                                	<button type="submit" class="btn btn-success">Submit</button>
                                </div>
                            </div>

                             {!! Form::close(); !!}   
                        </div>
                        <!--  -->
                        <div class="view_uom_set">
                        	<div class="panel-body">
	                            <table id="data-table" class="table table-striped table-bordered nowrap" width="100%">
	                                <thead>
	                                    <tr>
	                                        <th width="10%">Sl</th>
	                                        <th width="65%">Permission Name</th>
	                                        <th width="10%">Status</th>
	                                        <th width="15%">Action</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <?php $i=0; ?>
	                                @foreach($allData as $data)
	                                <?php $i++; ?>
	                                    <tr class="odd gradeX">
	                                        <td>{{$i}}</td>
	                                        <td>{{$data->name}}</td>
	                                        <td>
	                                        	@if($data->system=="1")
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
                            <div class="modal-dialog">
                                <div class="modal-content">
                                {!! Form::open(array('route' => ['acl-permission.update',$data->id],'class'=>'form-horizontal author_form','method'=>'PUT','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                        <h4 class="modal-title">Permission Edit</h4>
                                    </div>
                                    <div class="modal-body">
                                        
                                        <div class="form-group">
                                            <label class="control-label col-md-4 col-sm-4" for="name">Permission Name * :</label>
                                            <div class="col-md-8 col-sm-8">
                                                <input class="form-control" type="text" id="name" name="name" value="<?php echo $data->name; ?>" data-parsley-required="true" />
                                            </div>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label class="control-label col-md-4 col-sm-4">status :</label>
                                            <div class="col-md-3 col-sm-3">
                                                <div class="radio">
                                                    <label>
                                                        <input type="radio" name="system" value="1" id="radio-required" data-parsley-required="true" @if($data->system=="1"){{"checked"}}@endif> Active
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="col-md-4 col-sm-4">
                                                <div class="radio">
                                                    <label>
                                                        <input type="radio" name="system" id="radio-required2" value="0" @if($data->system=="0"){{"checked"}}@endif> Inactive
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
	                                            {!! Form::open(array('route'=> ['acl-permission.destroy',$data->id],'method'=>'DELETE')) !!}
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
    @endsection
