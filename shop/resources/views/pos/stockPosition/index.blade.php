@extends('layout.app')
@section('content')
<div id="content" class="content">
		
		<div class="row">
		    <div class="col-md-12">
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <h4 class="panel-title">Stock Position</h4>
                    </div>
                    <div class="panel-body print_body">
                    <div class="box-body">
		{!! Form::open(array('route' => 'inventory-stock-position.store','class'=>'form-horizontal','files'=>true)) !!}
		<div class="form-group {{ $errors->has('position_name') ? 'has-error' : '' }}">
			{{Form::label('position_name', 'Position Name', array('class' => 'col-md-2 control-label'))}}
			<div class="col-md-6">
				{{Form::text('position_name','',array('class'=>'form-control','placeholder'=>'Position Name','required'))}}
				@if ($errors->has('position_name'))
                    <span class="help-block">
                        <strong>{{ $errors->first('position_name') }}</strong>
                    </span>
	            @endif
			</div>
			<div class="col-md-2">
				@if(Auth::user()->isRole('administrator'))
				{{Form::select('fk_branch_id', $branch, Auth::user()->fk_branch_id, ['class' => 'form-control'])}}
				<input type="hidden" name="status" value="1">
				@else
				<input type="hidden" name="fk_branch_id" value="{{Auth::user()->fk_branch_id}}">
				{{Form::select('status', array('1' => 'Active', '2' => 'Inactive'), '1', ['class' => 'form-control'])}}
				@endif
			</div>
			<div class="col-md-2">
			{{Form::submit('Submit',array('class'=>'btn btn-info'))}}
			</div>
		</div>
			
		{!! Form::close() !!}
	</div>
	<div class="col-md-12">
		<table class="table table-striped table-hover table-bordered center_table" id="my_table">
			<thead>
				<tr>
					<th>SL</th>
					<th>Position Name</th>
					<th>Status</th>
					<th>Branch</th>
					<th>Created At</th>
					<th colspan="2">Action</th>
				</tr>
			</thead>
			<tbody>
			<? $i=1; ?>
			@foreach($allData as $data)
				<tr>
					<td>{{$i++}}</td>
					<td>{{$data->position_name}}</td>
					<td><i class="{{($data->status==1)? 'fa fa-check-circle text-success' : 'fa fa-times-circle text-danger'}}"></i></td>
					<td>{{$data->branch_name}}</td>
					<td>{{date('d-m-Y',strtotime($data->created_at))}}</td>
					<td><a href="#editModal{{$data->id}}" data-toggle="modal" class="btn btn-info btn-xs"><i class="fa fa-pencil-square"></i></a>
					<!-- Modal -->
<div class="modal fade" id="editModal{{$data->id}}" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-md">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Edit Position</h4>
      </div>
        {!! Form::open(array('route' => ['inventory-stock-position.update',$data->id],'class'=>'form-horizontal','method'=>'PUT','files'=>true)) !!}
      <div class="modal-body">
		<div class="form-group">
			{{Form::label('position_name', 'Position Name', array('class' => 'col-md-3 control-label'))}}
			<div class="col-md-8">
				{{Form::text('position_name',$data->position_name,array('class'=>'form-control','placeholder'=>'Position Name','required'))}}
				{{Form::hidden('id',$data->id)}}
			</div>
			
			
		</div>
		@if(Auth::user()->isRole('administrator'))
		<div class="form-group">
			{{Form::label('Brnach', 'Branch Name', array('class' => 'col-md-3 control-label'))}}
			<div class="col-md-5">
				{{Form::select('fk_branch_id', $branch, $data->fk_branch_id, ['class' => 'form-control'])}}
			</div>
			<div class="col-md-3">
				{{Form::select('status', array('1' => 'Active', '2' => 'Inactive'), $data->status, ['class' => 'form-control'])}}
			</div>
		</div>
		@endif
			
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				{{Form::submit('Save changes',array('class'=>'btn btn-info'))}}
      </div>
		{!! Form::close() !!}
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

					</td>
					<td>
						{{Form::open(array('route'=>['inventory-stock-position.destroy',$data->id],'method'=>'DELETE'))}}
            				<button type="submit" class="btn btn-danger btn-xs" onclick="return confirmDelete();"><i class="fa fa-trash"></i></button>
        				{!! Form::close() !!}
					</td>
				</tr>
			@endforeach
			</tbody>
		</table>
		<div class="pull-right">
		{{$allData->render()}}	
		</div>
	</div>
                    </div>
                </div>
            </div>
        </div>
     </div>

	
	<script src="{{asset('public/plugins/jquery/jquery-1.9.1.min.js')}}"></script>
	<script type="text/javascript">
	    $(document).ready(function() {
	        App.init();
	        TableManageResponsive.init();
	    });
	</script>
@endsection
