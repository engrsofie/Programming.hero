	@extends('layout.app')
		@section('content')
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.15/css/jquery.dataTables.min.css">
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
                                <a class="btn btn-info btn-xs" href="{{URL::to('/inventory-product-sales/create')}}">Add New Sales</a>
                                
                            </div>
                            <h4 class="panel-title">View Sales </h4>
                        </div>
                        <div class="panel-body">
                            <table id="all_data" class="table table-striped table-bordered nowrap" width="100%">
                                <thead>
                                    <tr>
                                        <th>SL</th>
                                        <th>Invoice Id</th>
                                        <th>Client Name</th>
                                        <th>Date</th>
                                        <th>Total Amount</th>
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
                ajax: '{!! URL::asset("sales-client-due-data?id=$id") !!}',
                columns: [
                    
                    { data: 'sl'},
                    { data: 'invoice_id'},
                    { data: 'client_name'},
                    { data: 'date'},
                    { data: 'total_amount'},
                    { data: 'paid_amount'},
                    { data: 'due_amount'},
                    { data: 'action'}
                ]
            });
        });
    </script>
    @endsection
