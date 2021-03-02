
	@extends('layout.app')
		@section('content')
		<!-- begin #content -->
		<div id="content" class="content">
			
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                                <a href="{{URL::to('acl-permission')}}" class="btn btn-success btn-xs">Permission</a>
                            </div>
                            <h4 class="panel-title">ACL Roles</h4>
                        </div>

                        <div class="view_uom_set">
                        	<div class="panel-body">
	                            <table id="data-table" class="table table-striped table-bordered nowrap" width="100%">
	                                <thead>
	                                    <tr>
	                                        <th width="5%">Sl</th>
	                                        <th width="90%">Role Name</th>
	                                        <th width="5%">Action</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <?php $i=0; ?>
	                                @foreach($roles as $id => $name)
	                                <?php $i++; ?>
	                                    <tr class="odd gradeX">
	                                        <td>{{$i}}</td>
	                                        <td>{{$name}}</td>
	                                        <td>
	                                        	<a href='{{URL::to("acl-permission/$id/edit")}}' class="btn btn-xs btn-success"><i class="fa fa-eye"></i></a>
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
