@extends('layout.app')
	@section('content')
    <style type="text/css">
        .modal-dialog{width: 900px;}
        .invoice-note {margin-top: 35px;}
        .printable {display: none;}
        .customerInfo p{margin-bottom: 2px;}
        .customerInfo, .invoiceInfo{float: left;padding: 0 10px;}
        .table{margin-bottom: 0px;}
        .invoice>div:not(.invoice-footer){margin-bottom: 5px;}
        @media print {
            .col-md-6{width: 50%;float: left;}
            .alert {display: none;}
            .reflink {display: none;}
            .refId {display: inline-block;}
            .table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th{padding: 2px;}
          @page {
          size: auto;   /* auto is the initial value */
          margin: 5mm;  /* this affects the margin in the printer settings */
        }
        }
    </style>
		<!-- begin #content -->
		<div id="content" class="content">
			
			<!-- begin invoice -->
			<div class="invoice">
                <div class="invoice-company">
                    <span class="pull-right hidden-print">
                   <a href="javascript:;" onclick="printPage('print_body')" class="printbtn btn btn-sm btn-success m-b-10"><i class="fa fa-print m-r-5"></i> Print</a>
                    <a href="{{URL::to('inventory-product-sales/create')}}" class="btn btn-sm btn-info m-b-10"><i class="fa fa-plus m-r-5"></i> Created New Order </a>
                    </span>
                    
                    
                    <!-- Invoice No. : {{$getInvoiceData->invoice_id}} --> 
                </div>
                <div id="print_body" style="width: 100%;overflow: hidden; padding: 10px 20px;">
                

             @include('pad.header')

                    <div id="customer_info">
                    <div class="row">
                        <div class="customerInfo" style="width: 60%;float: left;">
                            <p><b><u>Invoiced to</u></b></p>
                            <p><b>Organization Name : </b>{{$getInvoiceData->company_name}}</p>
                            <p><b>Address : </b> {{$getInvoiceData->address}}</p>
                            <p><b>Mobile No :</b> {{$getInvoiceData->mobile_no}}</p>
                            <p><b>Customer Id :</b> {{$getInvoiceData->client_id}}</p>
                            <p><b>Email : </b> {{$getInvoiceData->email_id}}</p>
                            <p><b></b> </p>
                        </div>
                        <div class="invoiceInfo" style="width: 40%;float: left;">
                            <table class="table table-bordered">
                                <tr>
                                    <th>Invoice #: </th>
                                    <th>{{$getInvoiceData->invoice_id}} </th>
                                </th>
                                </tr>
                                 <tr>
                                    <td>Payment Date : </td>
                                    <td>{{date('d-m-Y',strtotime($getInvoiceData->payment_date))}}</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div> 
                
                <div class="invoice-content">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th width="5%">SL</th>
                                    <th>Order ID</th>
                                    <th>Total Amount</th>
                                    <th>Prev Due</th>
                                    <th>Paid</th>
                                    <th>Due</th>
                                </tr>
                            </thead>
                            <tbody>
                            
                            <? $i=0; ?>
                                @if(isset($getProductData))
                                @foreach($getProductData as $product)
                                <? $i++; ?>
                                <tr>
                                    <td>{{$i}}</td>
                                    <td>{{$product->invoice_id}}</td>
                                    <td>{{round($product->total_amount,2)}}</td>
                                    <td>{{round($product->sales_last_due,2)}}</td>
                                    <td>{{round($product->sales_paid,2)}}</td>
                                    <td>{{round($product->sales_last_due-$product->sales_paid,2)}} </td>
                                    
                                </tr>
                                @endforeach

                                @endif
                                <tr class="success">
                                    <th colspan="2" style="text-align: right;">Total=</th>
                                    <th>{{round($getInvoiceData->total_amount,2)}}</th>
                                    <th>{{round($getInvoiceData->last_due,2)}}</th>
                                    <th>{{round($getInvoiceData->paid,2)}}</th>
                                    <th>{{round($getInvoiceData->last_due-$getInvoiceData->paid,2)}}</th>
                                </tr>
                            </tbody>
                        </table>
                        <div class="col-md-6 well">
                            <b>Note:</b>{{$getInvoiceData->summary}}
                        </div>
                    </div>
                    
                </div>
                <div class="printFooter" style="overflow: hidden;
    width: 100%;">
                   @include('pad.footer')
               </div>
               </div>
                
            </div>

			<!-- end invoice -->
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
@endsection