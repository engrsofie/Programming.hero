@extends('layout.app')
	@section('content')
    <style type="text/css">
        .modal-dialog{width: 900px;}
        .invoice-note {margin-top: 35px;}
        .aside_system{width: 100%; overflow: hidden; margin: 10px 0px;}
        .invoice-company{overflow: hidden;}
    </style>
		<!-- begin #content -->
		<div id="content" class="content">
			
			<!-- begin invoice -->
			<div class="invoice">
                <div class="invoice-company">
                    <span class="pull-right hidden-print">
                    <a href='{{URL::to("inventory-product-sales/$getChallan->sales_id")}}' class="btn btn-sm btn-info m-b-10"><i class="fa fa-eye m-r-5"></i> View Order </a>
                    
                    </span>
                    
                </div>
               {!! Form::open(array('route' =>[ 'inventory-sales-challan.update',$getChallan->id],'class'=>'form-horizontal author_form','method'=>'PUT', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                <div class="row">
                    <div id="customer_info" style="width: 100%">
                        <div class="row">
                            <div class="col-md-6">
                                <table class="table table-bordered">
                                     
                                    <tr>
                                        <td width="45%">Challan ID :</td>
                                        <td>{{$getChallan->challan_id}}</td>
                                    </tr>
                                    <tr>
                                        <td width="30%">Received Date :</td>
                                        <td>{{$getChallan->received_date}}</td>
                                    </tr>
                                    <tr>
                                    <td width="30%">Organization Name : </td>
                                    <td>{{$getChallan->company_name}}</td>
                                </tr>
                                    
                                </table>
                            </div>
                        <div class="col-md-6">
                            <table class="table table-bordered">
                                <tr>
                                    <th width="45%">Order ID : </th>
                                    <th>{{$getChallan->invoice_id}}</th>
                                </tr>
                                 <tr>
                                    <td width="30%">Order Date : </td>
                                    <td>{{$getChallan->date}}</td>
                                </tr>
                                
                                <tr>
                                    <td width="30%"> ID# : </td>
                                    <td>{{$getChallan->client_id}}</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div> 
            </div>        
               <input type="hidden" name="created_by" value="{{Auth::user()->id}}">
                <div class="invoice-content">
                    <div class="table-responsive">
                                        <table class="table table-bordered table-hover" id="table_auto">
                                            <thead>
                                                <tr class="active">
                                                <th width="2%">SL</th>
                                                    <th width="22%">Product Name</th>
                                                    <th width="10%">Unit Price</th>
                                                    <th width="15%" colspan="2">Quantity</th>
                                                    <th width="5%">Commission</th>
                                                    <th width="20%">Sub Total Price</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <? $i=0; ?>
                                            @foreach($getChallanItem as $sales)
                                            <? $i++; ?>
                                            <input type="hidden" name="item_id[]" value="{{$sales->id}}">
                                                <tr>
                                                <td>{{$i}}</td>
                                                    <td>{{$sales->product_name}} ({{$sales->model_name}})</td>
                                                    
                                                    <td>{{round($sales->product_price_amount,2)}}
                                                    <input type="hidden" name="product_price_amount[]" id="cost_{{$i}}" class="form-control changesNo" value="{{round($sales->product_price_amount,2)}}"></td>

                                                    <td><input type="number" value="{{$sales->qty}}" min="0" max="{{$sales->maxQty}}" step="any" name="qty[]" id="quantity2_{{$i}}" class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;"></td>
                                                    <td>{{$sales->small_unit_name}}</td>
                                                    <td>{{$sales->product_wise_discount}} %<input type="hidden" value="{{$sales->product_wise_discount}}" min="0" step="any" id="discount_{{$i}}"></td>
                                                    <td>
                                                    <input type="number" value="{{round($sales->payable_amount,2)}}" min="0" step="any" name="payable_amount[]" id="total_{{$i}}" class="form-control totalLinePrice" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly="readonly">

                                                    <input type="hidden" value="{{round($sales->product_price_amount,2)-round($sales->product_wise_discount,2)}}" min="0" step="any" name="price[]" id="cost1_{{$i}}" class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" >
                                                    </td>
                                                </tr>
                                            @endforeach
                                            </tbody>
                                        </table>
                                    </div>
                    <div class="invoice-price">
                        <div class='row'>   
                            <div class='col-xs-12 col-sm-7 col-md-7 col-lg-7'>
                                
                            </div>
                            <div class='col-xs-12 col-sm-5 col-md-5 col-lg-5'>
                                <span class="form-inline">
                                    <div class="form-group aside_system">
                                        <label>Total Amount: &nbsp;</label>
                                        <div class="input-group">
                                            <div class="input-group-addon currency">৳</div>
                                            <input type="number" min="0" step="any" class="form-control" name="total_amount" id="subTotal" placeholder="Total Amount" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly value="{{round($getChallan->total_amount,2)}}">
                                        </div>
                                    </div>
                                </span>

                            </div>
                        </div>
                        
<br>
                    </div>
                    
                <div class="form-group">
                    <label class="control-label col-md-2 col-sm-2"></label>
                    <div class="col-md-8 col-sm-8">
                        <button type="submit" class="btn btn-primary" style="width: 100%;">Confirm</button>
                    </div>
                    <label class="control-label col-md-2 col-sm-2"></label>
                </div>
                {{Form::close()}}
                </div>
                
            </div>

			<!-- end invoice -->
		</div>
		<!-- end #content -->

		
    <script src="{{asset('public/plugins/jquery/jquery-1.9.1.min.js')}}"></script>
    <script src="{{asset('public/custom_js/script_sales.js')}}"></script>
    <script>
		$(document).ready(function() {
			App.init();
		});
	</script>

@endsection