@extends('layout.app')
	@section('content')
    <style type="text/css">
        .modal-dialog{width: 900px;}
        .invoice-note {margin-top: 35px;}
        .refId {display: none;}
        .customerInfo p{margin-bottom: 2px;}
        .customerInfo, .invoiceInfo{float: left;padding: 0 10px;}
        .table{margin-bottom: 0px;}
        .invoice>div:not(.invoice-footer){margin-bottom: 5px;}
        .print-logo{width: 100px;}
        .invoice_top{display: none;}
        .print-footer{display: none;}

        
    </style>
		<!-- begin #content -->
		<div id="content" class="content">
            <!-- begin invoice -->
            <div class="invoice">
                <div class="invoice-company">
                    <span class="pull-right hidden-print">
                    
                    <a href="javascript:;" onclick="printPage('print_body')" class="printbtn btn btn-sm btn-success m-b-10"><i class="fa fa-print m-r-5"></i> Print</a>
                    </span>
                    <!-- Invoice No. : {{$getInvoiceData->invoice_id}} --> 
                </div>
                <input type="hidden" id="generate-id" value="{{$getInvoiceData->id}}">
                <input type="hidden" name="_token" value="{{ csrf_token() }}">
            <div id="print_body" style="width: 100%;overflow: hidden; padding: 10px 20px;">
                

			 @include('pad.header')
                <div id="customer_info" style="padding: 0 10px;">
                    <div class="row">
                        <div class="customerInfo" style="width: 60%;float: left;">
                            <p><b><u>Order to</u></b></p>
                            <p><b>Company Name :</b>{{$getInvoiceData->company_name}}</p>
                            <p><b>Region : </b> {{$getInvoiceData->address}}</p>
                            <p><b>Mobile No :</b> {{$getInvoiceData->mobile_no}}</p>
                            <p><b>Email : </b> {{$getInvoiceData->email_id}}</p>
                        </div>
                        <div class="invoiceInfo" style="width: 40%;float: left;">
                            <table class="table table-bordered">
                                <tr>
                                    <th> Order Id #: </th>
                                    <th>{{$getInvoiceData->inventory_order_id}} </th>
                                </tr>
                                 <tr>
                                    <td> Order Date : </td>
                                    <td>{{$getInvoiceData->order_date}}</td>
                                </tr>
                                <tr>
                                    <td> L/C No. : </td>
                                    <td>{{$getInvoiceData->lc_no}}</td>
                                </tr>
                                <tr>
                                    <td> L/C Opening Date : </td>
                                    <td>{{$getInvoiceData->opening_date}}</td>
                                </tr>
                            </table>
                            <div>
                            <p><b><u>Shipping Address</u></b></p>
                                <p>{{$getInvoiceData->shipping_address}}</p>
                            </div>
                        </div>
                    </div>
                </div> 
                
                <div class="invoice-content">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th width="5%">SL</th>
                                    <th>Product Name</th>
                                    <th>Quantity</th>
                                    <th>Free of Cost</th>
                                    <th>Cost per unit</th>
                                    <th>L/C Value</th>
                                </tr>
                            </thead>
                            <tbody>
                            <? $i=0;
                                $total=0;
                             ?>
                                @if(isset($getProductData))
                                @foreach($getProductData as $product)
                                <? 
                                $i++;
                                $total +=$product->foreign_amount*$product->qty;
                                ?>
                                <tr>
                                <td>{{$i}}</td>
                                    <td>{{$product->product_name}}</td>
                                    <td>{{$product->qty}} {{$product->small_unit_name}}</td>
                                    <td>{{$product->free_of_cost}} {{$product->small_unit_name}}</td>
                                    <td>{{round($product->foreign_amount,2)}} {{$product->currency_name}}</td>
                                    <td>{{round($product->foreign_amount,2)*$product->qty}} {{$product->currency_name}}</td>
                                    
                                </tr>
                                @endforeach

                                @endif
                                <tr>
                                    <td colspan="5" style="text-align: right">Total Price =</td>
                                    <th>{{$total}}</th>
                                </tr>
                            </tbody>
                        </table>
                    <div class="col-md-6 no-padding" style="width: 50%;float: left;">
                        <h5><u>Other Expenses</u></h5>
                        <table class="table table-bordered">
                            <tr class="active">
                                <th>Expense Details</th>
                                <th>Amount</th>
                            </tr>
                        @foreach($expenses as $expense)
                            <tr>
                                <td>{{$expense->other_expense_title}}</td>
                                <td>{{$expense->other_expense}}</td>
                            </tr>
                        @endforeach
                        <tr class="active">
                            <th>Total =</th>
                            <th>{{round($getInvoiceData->other_expenses,2)}}</th>
                        </tr>
                        </table>
                    </div>
                    </div>
                    <h4>Grand Total : {{round(($getInvoiceData->total_amount+$getInvoiceData->other_expenses),2)}} BDT</h4>
                    <h6 style="text-transform: capitalize;"><b>In Words :</b>
                        <? 
                        echo App\Http\Controllers\NumberFormat::taka($getInvoiceData->total_amount+$getInvoiceData->other_expenses);
                        ?><b></b></h6>
                
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

		


   
<script src="{{asset('public/plugins/jquery/jquery-1.9.1.min.js')}}"></script> 

@endsection
@section('script')

<script src="{{asset('public/custom_js/printThis.js')}}"></script>
<script type="text/javascript">
    function printPage(id){
        $('#'+id).printThis();
    }
</script>
@endsection