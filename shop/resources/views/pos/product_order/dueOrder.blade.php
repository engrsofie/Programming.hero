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
                                <a class="btn btn-info btn-xs" href="{{URL::to('/inventory-product-order/create')}}">Add New Product Order</a>
                                
                            </div>
                            <h4 class="panel-title">Product Order Page </h4>
                        </div>
                        <div class="panel-body">
                            <table id="all_data" class="table table-striped table-bordered nowrap" width="100%">
                                <thead>
                                    <tr>
                                        <th>Order Date</th>
                                        <th>Order Id</th>
                                        <th>Suppliar name</th>
                                        <th>Total Amount</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
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
                order: [ [0, 'desc'] ],
                serverSide: true,
                ajax: '{!! URL::asset("all-due-order") !!}',
                columns: [
                    
                    { data: 'order_date'},
                    { data: 'inventory_order_id'},
                    { data: 'company_name'},
                    { data: 'total_amount'},
                    { data: 'status'},
                    { data: 'action'}
                ]
            });
        });
        function confirmStore(){
            return confirm("Do You Sure Want To Store to Inventory This Data ?");
        }
    </script>
    @endsection
