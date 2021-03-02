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
                                <a class="btn btn-info btn-xs" href="{{URL::to('/inventory-product-add/create')}}">Add New Product Order</a>
                                
                            </div>
                            <h4 class="panel-title">Product Order Page </h4>
                        </div>
                        <div class="panel-body">
                            <table  id="all_data" class="table table-striped table-bordered nowrap" width="100%">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Date</th>
                                        <th>Supplier Name</th>
                                        <th>Total Amount</th>
                                        <th>Total Paid</th>
                                        <th width="10%">Action</th>
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
                ajax: '{!! URL::asset("inventory-product-add-all") !!}',
                columns: [
                    { data: 'inventory_order_id',name:'inventory_product_add.inventory_order_id'},
                    { data: 'date'},
                    { data: 'company_name',name:'inventory_supplier.company_name'},
                    { data: 'total_amount'},
                    { data: 'total_paid'},
                    { data: 'action'}
                ]
            });
        });
    </script>
    <script type="text/javascript">
        
        function confirmStore(){
            return confirm("Do You Sure Want To Store to Inventory This Data ?");
        }
    </script>
    @endsection
