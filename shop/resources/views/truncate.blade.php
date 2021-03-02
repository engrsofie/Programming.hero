@extends('layout.app')
@section('content')

<div class="tab_content">

  <h3 class="box_title text-center">All Table From Database 
 </h3>
 <div class="col-md-8 col-md-offset-2">
    <table class="table table-striped table-hover table-bordered center_table" id="my_table">
        <thead>
            <tr>
                <th>SL</th>
                <th>Name</th>
                <th>Data</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <? $i=1; 
        ?>
        @foreach($allData as $key => $data)
            <tr>
                <td>{{$i++}}</td>
                <td>{{$data['table']}}</td>
                <td>{{$data['row']}}</td>
                <td>
                    <? $table = $data['table']; ?>
    {!! Form::open(array('url' =>"truncate/$table",'method'=>'GET','id'=>'form')) !!}
        <button type="submit" class="btn btn-xs btn-danger" onclick="return confirmDelete()"><i class="fa fa-trash"></i></button>
    {!! Form::close() !!}
                </td>

            </tr>
        @endforeach
        </tbody>
    </table>
 </div>
  </div>


@endsection
