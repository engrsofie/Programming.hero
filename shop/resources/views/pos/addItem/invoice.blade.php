@extends('layout.app')
	@section('content')
    <style type="text/css">
        .modal-dialog{width: 900px;}
        .invoice-note {margin-top: 35px;}
        .refId {display: none;}
        .customerInfo p{margin-bottom: 2px;text-align: center;}
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
                    Purchase Product Brochure
                </div>
                <input type="hidden" id="generate-id" value="{{$getInvoiceData->id}}">
                <input type="hidden" name="_token" value="{{ csrf_token() }}">
            <div id="print_body" style="width: 100%;overflow: hidden; padding: 10px 20px;">
                

			 @include('pad.header')
             <h4 style="text-align: center;">Purchase Product</h4>
             <h5><b>Company:</b> {{$getInvoiceData->company_name}}</h5>
             <h5><b>Date:</b> {{date('d-m-Y',strtotime($getInvoiceData->date))}}</h5>
                <div class="invoice-content">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th width="5%">SL</th>
                                    <th>Product Name</th>
                                    <th>Cost per unit</th>
                                    <th>Sales Per Unit</th>
                                    <th>Quantity</th>
                                    <th>Sub Total</th>
                                    <th>Branch</th>
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
                                ?>
                                <tr>
                                <td>{{$i}}</td>
                                    <td>{{$product->product_name}} ({{$product->model_name}})</td>
                                    <td>{{round($product->cost_per_unit,3)}}</td>
                                    <td>{{round($product->sales_per_unit,3)}}</td>
                                    <td>{{$product->qty}} {{$product->small_unit_name}}</td>
                                    <td>{{round($product->payable_amount,3)}}</td>
                                    <td>{{$product->position_name}}</td>
                                    
                                </tr>
                                @endforeach

                                @endif
                                <tr>
                                    <td colspan="5" style="text-align: right">Payable Amount =</td>
                                    <th>{{round($getInvoiceData->total_amount,3)}}</th>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td colspan="5" style="text-align: right">Paid =</td>
                                    <th>{{round($getInvoiceData->total_paid,3)}}</th>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                    <h4>Grand Total : {{round(($getInvoiceData->total_amount),3)}} BDT</h4>
                    <h6 style="text-transform: capitalize;"><b>In Words :</b>
                        <? 
                        echo App\Http\Controllers\NumberFormat::taka($getInvoiceData->total_amount);
                        ?><b></b></h6>
                
                </div>
               <div class="printFooter" style="overflow: hidden;width: 100%;">
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
    $(document).ready(function(){
        $('#signature1').html("Purchase By <br> {{$getInvoiceData->user_name}}");
        $('#print_body').printThis();
    })
    function printPage(id){
        $('#'+id).printThis();
    }
</script>
@endsection