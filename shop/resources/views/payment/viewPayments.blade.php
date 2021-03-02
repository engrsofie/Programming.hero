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
                                <a class="btn btn-info btn-xs" href="{{URL::to('/payment/create')}}">Add New Create Payment</a>
                            </div>
                            <h4 class="panel-title">Payment Page </h4>
                        </div>
                        <div class="panel-body">
                            <table id="data-table" class="table table-striped table-bordered nowrap" width="100%">
                                <thead>
                                    <tr>
                                        <th>Sl</th>
                                        <th>Invoice No.</th>
                                        <th>Client Name</th>
                                        <th>Date</th>
                                        <th>Total Amount</th>
                                        <th>Total Due</th>
                                        <th>Branch</th>

                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <?php $i=0; ?>
                                @foreach($getPaymentData as $payment)
                                <?php $i++; 
                                $last_invoice=DB::table('payment_history')->leftJoin('payment_cost_item','payment_history.fk_payment_item_id','payment_cost_item.id')->where('payment_cost_item.fk_payment_id',$payment->id)->orderBy('payment_history.id','desc')->value('payment_history.invoice_id');
                                ?>
                                    <tr class="odd gradeX">
                                        <td>{{$i}}</td>
                                        <td><a href='{{URL::to("payment/$payment->invoice_no")}}'>{{$payment->invoice_no}}</a></td>
                                        <td>{{$payment->client_name}}</td>
                                        <td>{{$payment->t_date}}</td>
                                        <td>{{$payment->amount}}</td>
                                        <td>{{$payment->amount-$payment->total_paid}}</td>

                                        <td>{{$payment->branch_name}}</td>
                                        <td>
                                            @if($payment->amount-$payment->total_paid!=0)
                                            <a href='{{URL::to("due-payment/$payment->id/edit")}}' class="btn btn-xs btn-warning">Due</a>
                                        @else

                                            <a href='{{URL::to("payment/$last_invoice")}}' class="btn btn-xs btn-success">Paid</a>
                                        @endif
                                            <!-- delete section -->
                                            {!! Form::open(array('route'=> ['payment.destroy',$payment->id],'method'=>'DELETE')) !!}
                                                {{ Form::hidden('id',$payment->id)}}
                                                <button type="submit" onclick="return confirmDelete();" class="btn btn-xs btn-danger">
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
