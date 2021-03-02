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
                                <a class="btn btn-info btn-xs" href="{{URL::to('/billing-payment-system/create')}}">Add New bill payment</a>
                            </div>
                            <h4 class="panel-title">billing-payment-system </h4>
                        </div>
                        <div class="panel-body">
                            <table id="data-table" class="table table-striped table-bordered nowrap" width="100%">
                                <thead>
                                    <tr>
                                        <th>Sl</th>
                                        <th>Staff Name</th>
                                        <th>Customer Name</th>
                                        <!-- <th>Year</th>
                                        <th>Month</th> -->
                                        <th>Action</th>
                                        <th>status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <?php $i=0; ?>
                                @foreach($getPaymentDetails as $payment)
                                <?php $i++; ?>
                                    <tr class="odd gradeX">
                                        <td>{{$i}}</td>
                                        <td>{{$payment->staff_name}}</td>
                                        <td>{{$payment->customer_name}}</td>
                                        <!-- <td>{{$payment->customer_name}}</td>
                                        <td>{{$payment->customer_name}}</td> -->
                                        <td>
                                        @if($payment->status=='1')
                                            {{"Active"}}
                                        @else
                                            {{"Inactive"}}
                                        @endif
                                        </td>
                                        <td>
                                        

                                            <!-- delete section -->
                                            {!! Form::open(array('route'=> ['billing-payment-system.destroy',$payment->id],'method'=>'DELETE')) !!}
                                                {{ Form::hidden('id',$payment->id)}}
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

    @endsection
