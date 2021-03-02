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
        .printable{display: none;}

        
    </style>
		<!-- begin #content -->
		<div id="content" class="content">
            <!-- begin invoice -->
            <div class="invoice">
                <div class="invoice-company">
                    <span class="pull-right hidden-print">
                    
                    <a href="javascript:;" onclick="printPage('print_body')" class="printbtn btn btn-sm btn-success m-b-10"><i class="fa fa-print m-r-5"></i> Print</a>
                    <a class="printbtn btn btn-sm btn-info m-b-10" href='{{URL::to("inventory-sales-challan/$getInvoiceData->id/edit")}}'><i class="fa fa-pencil"></i> Edit</a>
                    {!! Form::open(array('route'=> ['inventory-sales-challan.destroy',$getInvoiceData->id],'method'=>'DELETE')) !!}
                        {{ Form::hidden('id',$getInvoiceData->id)}}
                        <button type="submit" onclick="return confirmDelete();" class="printbtn btn btn-sm m-b-10 btn-danger">
                          <i class="fa fa-trash-o" aria-hidden="true"></i> Delete
                        </button>
                    {!! Form::close() !!}
                    </span>
                    <!-- Invoice No. : {{$getInvoiceData->invoice_id}} --> 
                </div>
            <div id="print_body" style="width: 100%;overflow: hidden; padding: 10px 20px;">
                

			 @include('pad.header')
                <div id="customer_info" style="padding: 0 10px;">
                    <div class="row">
                        <h4 style="width: 100%;text-align: center;margin-top: 15px;"><b style="padding: 10px 20px;border-radius: 10px;color: #000;border:1px solid #ddd;">Challan</b>
                        <br>
                        <br>
                        <br>
                        <br>
                        </h4>

                        <div class="customerInfo" style="width: 60%;float: left;">
                            <p><b>Organization Name : </b>{{$getInvoiceData->company_name}}</p>
                            <p><b>Billing Address : </b>{{$getInvoiceData->address}}</p>
                           
                            <p><b>Mobile No : </b>{{$getInvoiceData->mobile_no}}</p>
                            <br>
                            <br>
                        </div>
                        
                        <div class="invoiceInfo" style="width: 40%;float: left;">
                            <table class="table table-bordered">
                                <tr>
                                    <td>Challan ID : </td>
                                    <td>{{$getInvoiceData->challan_id}}</td>
                                </tr>
                                <tr>
                                    <td>Delivery Date : </td>
                                    <td>{{$getInvoiceData->received_date}}</td>
                                </tr>
                                <tr>
                                    <th>P.O. ID : </th>
                                    <th>{{$getInvoiceData->order_id}}</th>
                                </tr>
                                 <tr>
                                    <td>Sales Order Date : </td>
                                    <td>{{$getInvoiceData->date}}</td>
                                </tr>
                            </table>
                            <div>
                            <br>
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
                                    <th>Unit Price</th>
                                    <th>Commission</th>
                                    <th>Sub Total</th>
                                    <th>Net Price</th>
                                </tr>
                            </thead>
                            <tbody>
                            <? $i=0; $totalComm=0;?>
                                @if(isset($getProductData))
                                @foreach($getProductData as $product)
                                <? $i++;
                                $comValue= ($product->product_price_amount/100)*$product->product_wise_discount*$product->qty;
                                $totalComm+=$comValue; ?>
                                <tr>
                                <td>{{$i}}</td>
                                    <td> {{$product->product_name}} ({{$product->model_name}})</td>
                                    <td>{{$product->qty}} {{$product->small_unit_name}}</td>
                                    <td>{{round($product->product_price_amount,2)}}</td>
                                    <td><?echo $comValue;?></td>
                                    <td>{{round($product->payable_amount+$comValue,2)}}</td>
                                    <td>{{round($product->payable_amount,2)}}</td>
                                    
                                </tr>
                                @endforeach

                                @endif
                                <tr class="success no-print">
                                    
                                    <th colspan="4" style="text-align: right;">Total=</th>
                                    <th>{{round($totalComm,3)}}</th>
                                    <th>{{round($getInvoiceData->total_amount+$totalComm,2)}}</th>
                                    <th>{{round($getInvoiceData->total_amount,2)}}</th>
                                </tr>
                            </tbody>
                        </table>
                         <h6 style="text-transform: capitalize;text-align: left;"><b>Total In Words :</b>
                        <? 
                        echo App\Http\Controllers\NumberFormat::taka(round($getInvoiceData->total_amount,2));
                        ?><b></b></h6>
                    </div>

                
                </div>
               <div class="printFooter" style="overflow: hidden;width: 100%;">
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