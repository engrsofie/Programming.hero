	@extends('layout.app')
		@section('content')
        
        <style type="text/css">
            form{display: inline;}
            .form-group{width: 100%;height: auto; overflow: hidden; display: block !important; margin: 5px;}
            .form-control{width: 100% !important;}
            table.dataTable tbody th, table.dataTable tbody td{padding: 5px;}
        </style>
		<!-- begin #content -->
		<div id="content" class="content">
			
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                                <a class="btn btn-info btn-xs" href="{{URL::to('/inventory-order-payment/create')}}">Add New Payment</a>
                            </div>
                            <h4 class="panel-title">View Payment </h4>
                        </div>
                        <div class="panel-body">
                            <table id="all_data" class="table table-striped table-bordered nowrap" width="100%">
                                <thead>
                                    <tr>
                                        <th>Invoice Id</th>
                                        <th>Supplier Name</th>
                                        <th>Payment Date</th>
                                        <th>Payable Amount</th>
                                        <th>Paid Amount</th>
                                        <th>Due Amount</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
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
        $(function() {
            $('#all_data').DataTable( {
                processing: true,
                serverSide: true,
                ajax: '{!! URL::asset("inventory-order-all-payment") !!}',
                columns: [
                    { data: 'invoice_id',name:'inventory_order_payment.invoice_id'},
                    { data: 'company_name',name:'inventory_supplier.company_name'},
                    { data: 'payment_date'},
                    { data: 'total_amount'},
                    { data: 'paid'},
                    { data: 'due_amount'},
                    { data: 'action'}
                ]
            });
        });
    </script>
    @endsection
