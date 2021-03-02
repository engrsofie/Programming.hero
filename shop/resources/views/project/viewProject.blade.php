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
                                <a class="btn btn-xs btn-info" href="{{URL::to('/project/create')}}">Add New Project</a>
                            </div>
                            <h4 class="panel-title">View All Project</h4>
                        </div>
                        <div class="panel-body">
                            <table id="data-table" class="table table-striped table-bordered nowrap" width="100%">
                                <thead>
                                    <tr>
                                        <th width="2%">Sl</th>
                                        <th>Project Name</th>
                                        <th width="15%">Status</th>
                                        <th width="10%">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <?php $i=0; ?>
                                @foreach($getProjectData as $project)
                                <?php $i++; ?>
                                    <tr class="odd gradeX">
                                        <td>{{$i}}</td>
                                        <td>{{$project->project_name}}</td>
                                        <td>{{($project->project_status==1)?'Active':'Inactive'}}</td>
                                        <td>
                                        <!-- edit section -->
                                            <a href="ui_modal_notification.html#modal-dialog<?php echo $project->id;?>" class="btn btn-sm btn-success" data-toggle="modal"><i class="fa fa-pencil-square-o" aria-hidden="true" style="font-size: 18px;"></i></a>
                                            <!-- #modal-dialog -->
                                            <div class="modal fade" id="modal-dialog<?php echo $project->id;?>">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                    {!! Form::open(array('route' => ['project.update',$project->id],'class'=>'form-horizontal author_form','method'=>'PUT','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                                                        <div class="modal-header">
                                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                            <h4 class="modal-title">Modal Dialog</h4>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-4 col-sm-4" for="company_name"></label>
                                                                <div class="col-md-8 col-sm-8">
                                                                    <input class="form-control" type="hidden" id="company_name" name="company_name" value="<?php echo $project->company_name; ?>" data-parsley-required="true" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label col-md-4 col-sm-4" for="project_name">project Name * :</label>
                                                                <div class="col-md-8 col-sm-8">
                                                                    <input class="form-control" type="text" id="project_name" name="project_name" value="<?php echo $project->project_name; ?>" data-parsley-required="true" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label col-md-4 col-sm-4" for="project_name">project Description * :</label>
                                                                <div class="col-md-8 col-sm-8">
                                                                    <textarea class="form-control" id="address" name="project_description" rows="4"><?php echo $project->project_description; ?></textarea>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label col-md-4 col-sm-4">project Status :</label>
                                                                <div class="col-md-3 col-sm-3">
                                                                    <div class="radio">
                                                                        <label>
                                                                            <input type="radio" name="project_status" value="1" id="radio-required" data-parsley-required="true" @if($project->project_status=="1"){{"checked"}}@endif> Active
                                                                        </label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4 col-sm-4">
                                                                    <div class="radio">
                                                                        <label>
                                                                            <input type="radio" name="project_status" id="radio-required2" value="0" @if($project->project_status=="0"){{"checked"}}@endif> Inactive
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
                                            {!! Form::open(array('route'=> ['project.destroy',$project->id],'method'=>'DELETE')) !!}
                                                {{ Form::hidden('id',$project->id)}}
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
		<!-- end #content -->
		
    <script src="{{asset('public/plugins/jquery/jquery-1.9.1.min.js')}}"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            App.init();
            TableManageResponsive.init();
        });
    </script>
    @endsection
