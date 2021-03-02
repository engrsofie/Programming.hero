@extends('layout.app')
@section('content')
<div class="tab_content">

<h3 class="box_title">Add Custom Menu 
 <a href="{{route('menu.index')}}" class="btn btn-default pull-right"> <i class="ion ion-navicon-round"></i> View All </a>

 </h3>

	{!! Form::open(array('route' => 'menu.store','class'=>'form-horizontal','files'=>true)) !!}
        <div class="form-group   {{ $errors->has('name') ? 'has-error' : '' }}">
            {{Form::label('name', ' Name', array('class' => 'col-md-3 control-label'))}}
            <div class="col-md-8">
                {{Form::text('name','',array('class'=>'form-control','placeholder'=>'Name','required'))}}
            </div>
        </div>
         <div class="form-group  {{ $errors->has('url') ? 'has-error' : '' }}">
            
            {{Form::label('url', 'URL', array('class' => 'col-md-3 control-label'))}}
            <div class="col-md-8">
                <div class="input-group">
                    <div class="input-group-addon">{{URL::to('/')}}/</div>
                    {{Form::text('url','',array('class'=>'form-control','placeholder'=>'URL','required'))}}
                </div>
                @if ($errors->has('url'))
                    <span class="help-block">
                        <strong>{{ $errors->first('url') }}</strong>
                    </span>
                @endif
            </div>
        </div>
        <div class="form-group">
            {{Form::label('serial_num', 'Serial', array('class' => 'col-md-3 control-label'))}}
            <div class="col-md-8">
            <? $max=$max_serial+1; ?>
                {{Form::number('serial_num',"$max",array('class'=>'form-control','placeholder'=>'Serial Number','max'=>"$max",'min'=>'0'))}}
            </div>
        </div>
        <div class="form-group">
            {{Form::label('status', 'Status', array('class' => 'col-md-3 control-label'))}}
            <div class="col-md-8">
                {{Form::select('status', array('1' => 'Active', '2' => 'Inactive'),'1', ['class' => 'form-control'])}}
            </div>
        </div>
        
	    <div class="form-group">
	        <div class="col-md-9 col-md-offset-3">
	            <button type="submit" class="btn btn-primary">Submit</button>
	        </div>
	    </div>
      </div>
	{!! Form::close() !!}

@endsection

