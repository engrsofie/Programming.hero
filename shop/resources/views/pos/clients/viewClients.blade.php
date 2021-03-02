	@extends('layout.app')
		@section('content')
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.15/css/jquery.dataTables.min.css">
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
                                <a class="btn btn-info btn-xs" href="{{URL::to('/inventory-client/create')}}">Add New Client</a>
                                
                            </div>
                            <h4 class="panel-title">Client Page </h4>
                        </div>
                        <div class="panel-body">
                            <table  id="all_data" class="table table-striped table-bordered nowrap" width="100%">
                                <thead>
                                    <tr>
                                        <th>Client Id</th>
                                        <th>Client Name</th>
                                        <th>Client Phone</th>
                                        <th>Client Email</th>
                                        <th>Branch</th>
                                        <th>Status</th>
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

    @endsection
    @section('script')
    <script type="text/javascript">
        $(function() {
            $('#all_data').DataTable( {
                processing: true,
                serverSide: true,
                ajax: '{{ URL::to("inventory-client/show") }}',
                columns: [
                    { data: 'client_id'},
                    { data: 'client_name'},
                    { data: 'mobile_no'},
                    { data: 'email_id'},
                    { data: 'branch_name',name:'inventory_branch.branch_name'},
                    { data: 'client_status'},
                    { data: 'action'},
                ]
            });
            
        });

    </script>
    @endsection
