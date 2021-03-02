@extends('layout.app')
		@section('content')
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.15/css/jquery.dataTables.min.css">
        <style type="text/css">
            form{display: inline;}
            .company_info{width: 50%;float: left;}
            .form-group{width: 100%;height: auto; overflow: hidden; display: block !important; margin: 5px;}
            .form-control{width: 100% !important;}
            .invoice_top_left{display: none;}
        </style>
		<!-- begin #content -->
		<div id="content" class="content">
			
			<div class="row">
			    <div class="col-md-12">

                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <a href='{{URL::to("inventory-transfer/create")}}' class="printbtn btn btn-xs btn-success m-b-10 pull-right"><i class="fa fa-print m-r-5"></i>New Transfer</a>
                            <h4 class="panel-title"> All Transfered Item </h4>
                        </div>
                        <div class="panel-body">
                           
                           <div id="print_body" style="width: 100%;overflow: hidden; padding: 10px 20px;">
                

                            @include('pad.header')
                            <style type="text/css">
                              @media print {
                                      @page {
                                          size: auto;   /* auto is the initial value */
                                          margin: 5mm;  /* this affects the margin in the printer settings */
                                      }
                                  .invoice_top_left{display: block;}
                                  .btn-group {display: none;}
                                  
                                  .printbtn {display: none;}
                                  .unprint {display: none;}
                                  .unprint {display: none;}
                                  .dataTables_length {display: none;}
                                  .dataTables_filter {display: none;}
                                  .dataTables_info {display: none;}
                                  .dataTables_paginate{display: none;}
                                  .panel-title {display: none;}
                                  table.dataTable thead .sorting_asc:after {display: none;}
                              }
                            </style>
                            <table id="all_data" class="table table-striped table-bordered nowrap" width="100%">
                                <thead>
                                    <tr>
                                        
                                        <th width="5%">Invoice</th>
                                        <th width="12%">Transfer From</th>
                                        <th width="12%">Transfer From</th>
                                        <th width="12%">Total Amount</th>
                                        <th width="12%">Date</th>
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
		</div>
		<!-- end #content -->
		
    @endsection
@section('script')

<script src="{{asset('public/custom_js/printThis.js')}}"></script>
<script type="text/javascript">
    function printPage(id){
        $('#'+id).printThis();
    }
</script>
 <script type="text/javascript">
        
        $(function() {
            $('#all_data').DataTable({
                processing: true,
                serverSide: true,
                ajax: '{{ URL::to("inventory-transfer/show") }}',
                columns: [
                    { data: 'id'},
                    { data: 'branch_one',name:'inventory_branch.branch_name'},
                    { data: 'branch_two',name:'inventory_branch.branch_name'},
                    { data: 'total_amount'},
                    { data: 'date'},
                    { data: 'action'},
                ]
            });
            
        });

    </script>
@endsection