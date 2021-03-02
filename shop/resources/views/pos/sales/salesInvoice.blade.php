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
        
        }
    </style>
		<!-- begin #content -->
		<div id="content" class="content">
			
			<!-- begin invoice -->
			<div class="invoice">
                <div class="invoice-company">
                    <span class="pull-right hidden-print">
                   <a href="javascript:;" onclick="printPage('print_body')" class="printbtn btn btn-sm btn-success m-b-10"><i class="fa fa-print m-r-5"></i> Print</a>
                    <a href="{{URL::to('inventory-product-sales/create')}}" class="btn btn-sm btn-info m-b-10"><i class="fa fa-plus m-r-5"></i> New Sales </a>
                    </span>
                    
                    
                    <!-- Invoice No. : {{$getInvoiceData->invoice_id}} --> 
                </div>
                <div id="print_body" style="width: 100%;overflow: hidden; padding: 10px 20px;">
                
                    <style type="text/css">
                        @media print {
                            *{margin: 0;padding: 0;}
                            .summary-table{margin-top: -20px;}
                            .col-md-6{width: 50%;float: left;}
                            .alert {display: none;}
                            .reflink {display: none;}
                            .refId {display: inline-block;}
                            .table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th{padding: 2px;}
                          @page {
                          size: auto;   /* auto is the initial value */
                          margin: 5mm;  /* this affects the margin in the printer settings */
                        }
                    </style>
             @include('pad.header')
                    <h4 style="width: 100%;text-align: center;margin-top: 15px;"><b style="padding: 10px 20px;border-radius: 10px;color: #000;border:1px solid #ddd;">Sales Invoice</b>
                        <br>
                        <br>
                        </h4>
                    <div id="customer_info">
                    <div class="row">
                        <div class="customerInfo" style="width: 60%;float: left;">
                            <p><b><u>Invoiced to</u></b></p>
                            <p><b>Organization Name : </b>{{$getInvoiceData->company_name}}</p>
                            <p><b>Address : </b> {{$getInvoiceData->address}}</p>
                            <p><b>Mobile No :</b> {{$getInvoiceData->mobile_no}}</p>
                            <p><b>Email : </b> {{$getInvoiceData->email_id}}</p>
                            <br><br>
                        </div>
                        <div class="invoiceInfo" style="width: 40%;float: left;">
                            <table class="table table-bordered">
                                <tr>
                                    <th>Invoice #: </th>
                                    <th>{{$getInvoiceData->invoice_id}} </th>
                                </tr>
                                 <tr>
                                    <td>Invoice Date : </td>
                                    <td>{{date('d-m-Y',strtotime($getInvoiceData->date))}}</td>
                                </tr>
                            @if($getInvoiceData->order_id!=null)
                                <tr>
                                    <td>P.O : </td>
                                    <td>{{$getInvoiceData->order_id}}</td>
                                </tr>
                            @endif
                            </table>
                        </div>
                    </div>
                </div> 
                
                <div class="invoice-content">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                                <!-- <tr>
                                    <th>D. Challan:</th>
                                    <th colspan="8">
                                    <? $j=0; ?>
                                        @foreach($challan as $dChallan)
                                        <? $j++; ?>
                                        @if($j>1)
                                            ,  {{$dChallan->challan_id}}

                                        @else
                                            {{$dChallan->challan_id}}
                                        @endif
                                        @endforeach
                                    </th>
                                </tr> -->
                                <tr>
                                    <th width="5%">SL</th>
                                    <th>Product Info</th>
                                    <th width="12%">Quantity</th>
                                    <th width="15%" class="text-right">Unit Price</th>
                                    <th width="20%" class="text-right">Sub Total</th>
                                </tr>
                            </thead>
                            <tbody>
                            
                            <? $i=0;
                                $subTotal=0;
                             ?>
                                @if(isset($getProductData))
                                @foreach($getProductData as $product)
                                <? $i++;
                                $subTotal+=$product->product_price_amount*$product->sales_qty;
                                 ?>
                                <tr>
                                    <td>{{$i}}</td>
                                    <td>{{$product->product_name}} ({{$product->model_name}})</td>
                                    <td>{{$product->sales_qty}} {{$product->small_unit_name}}</td>
                                    <td class="text-right">{{round($product->product_price_amount,2)}}</td>
                                    <td class="text-right">{{round($product->product_price_amount*$product->sales_qty,2)}}</td>
                                    
                                </tr>
                                @endforeach

                                @endif
                                
                            </tbody>
                        </table>
                        <div class="col-md-6" style="width: 50%;float: left;">
                            @if($getInvoiceData->paid_amount+$getInvoiceData->prev_paid>0)
                             <h6 style="text-transform: capitalize;text-align: left;"><b>Paid In Words :</b>
                            <? 
                            echo App\Http\Controllers\NumberFormat::taka(round($getInvoiceData->paid_amount+$getInvoiceData->prev_paid,2));
                            ?><b></b></h6>
                            @endif

                            @if($prev->total_amount-$prev->paid_amount>0)
                            <div class="col-md-12 no-padding well">
                                <div class="col-md-12"> 
                                    <p><b>Previous Due: </b> {{$prev->total_amount-$prev->paid_amount}}</p>
                                </div>
                            </div>
                            @endif
                        </div>
                        <div class="col-md-4 col-md-offset-2 no-padding summary-table" style="width:40%;float: right;">
                            <table class="table table-bordered table-striped">
                                <thead>
                                   
                                </thead>
                                <tbody>
                                    <tr>
                                        <th width="40%" class="text-right">Sub Total :</th>
                                        <td class="text-right">{{round($getInvoiceData->total_amount+$getInvoiceData->discount,3)}}</td>
                                    </tr>
                                    <tr>
                                        <th class="text-right">Discount :</th>
                                        <td class="text-right">{{round($getInvoiceData->discount,3)}}</td>
                                    </tr>
                                    <tr>
                                        <th class="text-right">Total Amount:</th>
                                        <td class="text-right">{{round($getInvoiceData->total_amount,3)}}</td>
                                    </tr>
                                @if($getInvoiceData->prev_amount>0)
                                    <tr>
                                        <th class="text-right">Previous Due:</th>
                                        <td class="text-right">{{round($getInvoiceData->prev_amount,3)}}</td>
                                    </tr>
                                    <tr>
                                        <th class="text-right">Grand Total :</th>
                                        <td class="text-right">{{round($getInvoiceData->total_amount+$getInvoiceData->prev_amount,3)}}</td>
                                    </tr>
                                @endif
                                    <tr>
                                        <th class="text-right">Paid Amount :</th>
                                        <td class="text-right">{{round($getInvoiceData->paid_amount+$getInvoiceData->prev_paid,3)}}</td>
                                    </tr>
                                    <tr>
                                        <th class="text-right">Due Amount :</th>
                                        <th class="text-right">{{round(($getInvoiceData->total_amount+$getInvoiceData->prev_amount)-($getInvoiceData->paid_amount+$getInvoiceData->prev_paid),3)}}</th>
                                    </tr>

                                </tbody>
                            </table>
                        </div>
                       
                    </div>
                    
                </div>
                <div class="printFooter" style="overflow: hidden;width: 100%;">
                   <div class="print-footer" style="margin-top: 40px;overflow: hidden;width: 100%;position: fixed;bottom: 0;left: 0;padding: 0 10px;">

                     <div class="sign" style="width: 100%; overflow: hidden;">
                        <div class="company_sign" style="width: 33%; float: left;">
                            <h5 style="width:50%;margin: 0 auto;border-top: 1px solid #000;padding: 10px 0;text-align: center;">Sales By<br>{{$getInvoiceData->sales_by}}</h5>
                        </div> 
                        <div class="company_sign" style="width: 33%; float: left;">
                            <h5 style="width:50%;margin: 0 auto;border-top: 1px solid #000;padding: 10px 0;text-align: center;">Authorized By</h5>
                        </div> 
                        <div class="company_sign" style="width: 33%; float: left;">
                            <h5 style="width:50%;margin: 0 auto;border-top: 1px solid #000;padding: 10px 0;text-align: center;">Received By</h5>
                        </div>      
                    </div>

                    <hr>
                    <div class="copyright">
                        <div class="copyright-section">
                            <p class="pull-left">NB: This is system  generated report.</p>
                            
                            <p class="design_band pull-right">Powered By: <a href="#" > Smart Software Inc.</a></p>
                        </div>
                    </div>
                    <br>
                    </div>
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
    $(document).ready(function(){
        $('#print_body').printThis();
    })
    function printPage(id){
        $('#'+id).printThis();
    }
</script>
@endsection