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
                                <a class="btn btn-info btn-xs" href="{{URL::to('/deposit/create')}}">Add New Create Deposit</a>
                            </div>
                            <h4 class="panel-title">Deposit Page </h4>
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
                                @foreach($getDepositData as $deposit)
                                <?php $i++; 
                                $last_invoice=DB::table('deposit_history')->leftJoin('deposit_cost_item','deposit_history.fk_deposit_item_id','deposit_cost_item.id')->where('deposit_cost_item.fk_deposit_id',$deposit->id)->orderBy('deposit_history.id','desc')->value('deposit_history.invoice_id');
                                ?>
                                    <tr class="odd gradeX">
                                        <td>{{$i}}</td>
                                        <td><a href='{{URL::to("deposit/$deposit->invoice_no")}}'>{{$deposit->invoice_no}}</a></td>
                                        <td>{{$deposit->client_name}}</td>
                                        <td>{{$deposit->t_date}}</td>
                                        <td>{{$deposit->amount}}</td>
                                        <td>{{$deposit->amount-$deposit->total_paid}}</td>
                                        <td>{{$deposit->branch_name}}</td>

                                        <td>
                                        @if($deposit->amount-$deposit->total_paid!=0)
                                            <a href='{{URL::to("due-deposit/$deposit->id/edit")}}' class="btn btn-xs btn-warning">Due</a>
                                        @else

                                            <a href='{{URL::to("deposit/$last_invoice")}}' class="btn btn-xs btn-success">Paid</a>
                                        @endif
                                            <!-- end edit section -->

                                            <!-- delete section -->
                                            {!! Form::open(array('route'=> ['deposit.destroy',$deposit->id],'method'=>'DELETE')) !!}
                                                {{ Form::hidden('id',$deposit->id)}}
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
