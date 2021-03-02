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
                            <h4 class="panel-title">Client Wise Due Deposit Page </h4>
                        </div>
                        <div class="panel-body">
                            <table id="data-table" class="table table-striped table-bordered nowrap" width="100%">
                                <thead>
                                    <tr>
                                        <th>Sl</th>
                                        <th>Invoice No.</th>
                                        <th>Date</th>
                                        <th>Client Name</th>
                                        <th>Account Name</th>
                                        <th>Method Name</th>

                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <?php $i=0; ?>
                                @foreach($getDueDeposit as $dueDeposit)
                                <?php $i++; ?>
                                    
                                    <tr class="odd gradeX">
                                        <td>{{$i}}</td>
                                        <td>{{$dueDeposit->invoice_no}}</td>
                                        <td>{{$dueDeposit->t_date}}</td>
                                        <td>{{$dueDeposit->client_name}}</td>
                                        <td>{{$dueDeposit->account_name}}</td>
                                        <td>{{$dueDeposit->method_name}}</td>

                                        <td>
                                            
                                            <!-- edit section -->
                                            <a href='{{URL::to("client-wise-due-deposit/$dueDeposit->fk_client_id/edit")}}' class="btn btn-sm btn-success"><i class="fa fa-pencil-square-o" aria-hidden="true" style="font-size: 18px;"></i></a>
                                            <a href='{{URL::to("client-wise-due-deposit/$dueDeposit->fk_client_id")}}' class="btn btn-sm btn-success"><i class="fa fa-eye" aria-hidden="true" style="font-size: 18px;"></i></a>
                                            <!-- end edit section -->

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
