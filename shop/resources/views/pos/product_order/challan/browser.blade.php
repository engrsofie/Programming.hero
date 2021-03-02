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
                    <a class="printbtn btn btn-sm btn-info m-b-10" href='{{URL::to("inventory-product-order-challan/$getInvoiceData->id/edit")}}'><i class="fa fa-pencil"></i> Edit</a>
                    {!! Form::open(array('route'=> ['inventory-product-order-challan.destroy',$getInvoiceData->id],'method'=>'DELETE')) !!}
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
                        <h4 style="width: 100%;text-align: center;margin-top: 15px;"><b style="padding: 10px 20px;border-radius: 10px;color: #000;border:1px solid #ddd;">Challan</b></h4>
                        <div class="customerInfo" style="width: 60%;float: left;">
                            <p><b>Challan No : </b>{{$getInvoiceData->challan_id}}</p>
                            <p><b>Date : </b>{{$getInvoiceData->received_date}}</p>
                            <p><b>Supplier Name : </b>{{$getInvoiceData->company_name}}</p>
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
                                    <th>Product Info</th>
                                    <th>Cost per unit</th>
                                    <th>Quantity</th>
                                    <th>Total Price</th>
                                </tr>
                            </thead>
                            <tbody>
                            <? $i=0; ?>
                                @if(isset($getProductData))
                                @foreach($getProductData as $product)
                                <? $i++; ?>
                                <tr>
                                <td>{{$i}}</td>
                                    <td>
                                        {{$product->product_name}}<br />
                                        <small>{{$product->specification}}</small>
                                    </td>
                                    <td>{{round($product->cost_per_unit,2)}}</td>
                                    <td>{{$product->qty}}</td>
                                    <td>{{round($product->payable_amount,2)}}</td>
                                    
                                </tr>
                                @endforeach

                                @endif
                                <tr class="success">
                                    <th>*</th>
                                    <th></th>
                                    <th></th>
                                    <th>Total=</th>
                                    <th>{{round($getInvoiceData->total_amount,2)}}</th>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    
                        <h6 style="text-transform: capitalize;text-align: right;"><b>In Words :</b>
                        <? 
                        echo App\Http\Controllers\NumberFormat::taka($getInvoiceData->total_amount);
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