@extends('layout.app')
		@section('content')
        
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
                            <a href="javascript:;" onclick="printPage('print_body')" class="printbtn btn btn-xs btn-success m-b-10 pull-right"><i class="fa fa-print m-r-5"></i> Print</a>
                            <h4 class="panel-title">View Inventory Item </h4>
                        </div>
                        <div class="panel-body">
                        @if(Auth::user()->isRole('administrator'))
                           <div class="form-group col-md-5">
                               <label class="col-md-4"> Branch : </label>
                               <div class="col-md-8">
                                   {{Form::select('fk_branch_id',$branch,$branchId,['class'=>'form-control onchange','placeholder'=>'Select Branch','id'=>'branch'])}}
                               </div>
                           </div>
                        @else
                            <input type="hidden" name="fk_branch_id" id="branch" value="{{Auth::user()->fk_branch_id}}">
                        @endif
                           <div class="form-group col-md-6">
                               <label class="col-md-4"> Category : </label>
                               <div class="col-md-8">
                                   {{Form::select('fk_branch_id',$category,$categoryId,['class'=>'form-control onchange','placeholder'=>'All Category','id'=>'category'])}}
                               </div>
                           </div>
                           <hr class="col-md-12" style="margin:0">
                           
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
                              <h5 align="center">All Stock Item</h5>
                            <table id="all_data" class="table table-striped table-bordered nowrap" width="100%">
                                <thead>
                                    <tr>
                                        
                                        <th width="18%">Product Name</th>
                                        <th width="10%">Model</th>
                                        <th width="12%">Last QTY</th>
                                        <th width="12%">Today In</th>
                                        <th width="12%">Today Sale</th>
                                        <th width="12%">Available QTY</th>
                                        <th width="12%">Branch</th>
                                        <th width="10%">Product Value</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                          <div class="col-md-12">
                            
                            <div class="col-md-6" style="width: 70%">
                              <table class="table table-bordered" width="100%">
                                <tr class="active">
                                  <th width="30%" style="text-align: right;">Total Available Qty: </th>
                                  <th width="20%" id="totalQty">{{$data->qty}}</th>

                                  <th width="30%" style="text-align: right;">Total Value: </th>
                                  <th width="20%" id="totalPrice">{{$data->price}}</th>
                                </tr>
                                
                              </table>
                          </div>
                        </div>
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
        $('.onchange').on('change',function(){
            var branch = $('#branch').val();
            var category = $('#category').val();
            window.location='{{URL::to("/inventory")}}?branch='+branch+'&category='+category;

        });
        $(function() {
            var branch = $('#branch').val();
            var category = $('#category').val();
            $('#all_data').DataTable( {
                processing: true,
                serverSide: true,
                ajax: '{{ URL::to("inventory/create") }}?branch='+branch+'&category='+category,
                columns: [
                    { data: 'product_name',name:'inventory_product.product_name'},
                    { data: 'model_name',name:'inventory_product_model.model_name'},
                    { data: 'last_qty'},
                    { data: 'today_qty'},
                    { data: 'today_sale'},
                    { data: 'available_qty'},
                    { data: 'branch_name',name:'inventory_branch.branch_name'},
                    { data: 'price'},
                ]
            });
            
        });

    </script>
@endsection