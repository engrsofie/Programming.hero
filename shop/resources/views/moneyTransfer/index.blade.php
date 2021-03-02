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
                                <a class="btn btn-info btn-xs" href="{{URL::to('account-money-transfer/create')}}">New Transfer</a>
                            </div>
                            <h4 class="panel-title">All Transferd</h4>
                        </div>
                        <div class="panel-body">
                            <table id="data-table" class="table table-striped table-bordered nowrap" width="100%">
                                <thead>
                                    <tr>
                                        <th>Sl</th>
                                        <th>Transfer From</th>
                                        <th>Transfer To</th>
                                        <th>Date</th>
                                        <th>Method</th>
                                        <th>Amount</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <?php $i=0; ?>
                                @foreach($allData as $data)
                                <?php $i++; ?>
                                    <tr class="odd gradeX">
                                        <td>{{$i}}</td>
                                        <td><b>{{$data->branch_one}}</b><hr class="min">{{$data->account_name}}</td>
                                        <td><b>{{$data->branch_two}}</b><hr class="min">{{$data->account1_name}}</td>
                                        <td>{{$data->date}}</td>
                                        <td>{{$data->method_name}}</td>
                                        <td>{{$data->amount}}</td>
                                        <td>
                                            <a href='{{URL::to("account-money-transfer/$data->id/edit")}}' class="btn btn-info btn-xs"><i class="fa fa-pencil-square"></i></a>
                                            {!! Form::open(array('route'=> ['account-money-transfer.destroy',$data->id],'method'=>'DELETE')) !!}
                                                {{ Form::hidden('id',$data->id)}}
                                                <button type="submit" onclick="return confirmDelete();" class="btn btn-danger btn-xs">
                                                  <i class="fa fa-trash-o" aria-hidden="true"></i>
                                                </button>
                                            {!! Form::close() !!}
                                        </td>
                                    </tr>
                                @endforeach
                                </tbody>
                            </table>
                            {{$allData->render()}}
                        </div>
                    </div>
			    </div>
			</div>
		</div>
		<!-- end #content -->
    @endsection
