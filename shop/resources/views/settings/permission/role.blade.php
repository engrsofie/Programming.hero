@extends('layout.app')
	@section('content')
    <style type="text/css">
        .permission_label{border:1px solid #ddd;cursor: pointer;}
    </style>
	<!-- begin #content -->
	<div id="content" class="content">
		
		<div class="row">
		    <div class="col-md-12">
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="{{URL::to('acl-permission/roles')}}" class="btn btn-success btn-xs">Roles</a>
                        </div>
                        <h4 class="panel-title">{{$role->name}}</h4>
                    </div>
                    <div class="panel-body">
                        {!! Form::open(array('url' => 'acl-permission-role','class'=>'form-horizontal','method'=>'POST','role'=>'form','data-parsley-validate novalidate')) !!}
                        <input type="hidden" name="role_id" value="{{$role->id}}">
                        <div class="form-group">
                            <label class="col-md-12">Use Permission for this role</label>
                            <hr>
                            <div class="col-md-12">
                            @foreach($allData as $data)
                                <? $label='<label class="col-md-3 permission_label"><input type="checkbox" name="permission_id[]" value="'.$data->id.'">'.$data->name.'</label>'; ?>
                                <? foreach($permissionRole as $permission){?>
                                @if($permission->permission_id == $data->id)
                                 <? $label='<label class="col-md-3 permission_label"><input type="checkbox" name="permission_id[]" value="'.$data->id.'" checked>'.$data->name.'</label>'; ?>
                                <? break; ?>
                                @endif
                                <?}
                                echo $label;
                                ?>
                            @endforeach
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-12">
                                
                                <button type="submit" class="btn btn-success">Submit</button>
                            </div>
                        </div>


                        {!! Form::close() !!}

                    </div>
                </div>
            </div>
        </div>
    </div>
   @endsection