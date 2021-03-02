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
                    <a href='{{URL::to("inventory-product-order")}}' class="btn btn-sm btn-info m-b-10"><i class="fa fa-eye m-r-5"></i> View All Order</a>
                    
                    </span>
                    
                </div>
               {!! Form::open(array('route' =>[ 'inventory-product-order-challan.update',$getOrder->id],'class'=>'form-horizontal author_form','method'=>'PUT', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                <div class="row">
                    <div id="customer_info">
                        <div class="row">
                            <div class="col-md-6">
                                <table class="table">
                                     
                                    <tr>
                                        <td width="30%">Challan Id :</td>
                                        <td>{{$getOrder->challan_id}}</td>
                                    </tr>
                                    <tr>
                                        <td width="30%">Received Date :</td>
                                        <td>{{$getOrder->received_date}}</td>
                                    </tr>
                                    
                                </table>
                            </div>
                        <div class="col-md-6">
                            <table class="table">
                                <tr>
                                    <th width="30%">Order ID : </th>
                                    <th>{{$getOrder->inventory_order_id}}</th>
                                </tr>
                                 <tr>
                                    <td width="30%">Order Date : </td>
                                    <td>{{$getOrder->order_date}}</td>
                                </tr>
                                
                                <tr>
                                    <td width="30%">Supplier Name : </td>
                                    <td>{{$getOrder->company_name}}</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div> 
            </div>        
               <input type="hidden" name="created_by" value="{{Auth::user()->id}}">
                <div class="invoice-content">
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr class="active">
                                    <th>Product Name</th>
                                    <th width="15%">Cost Per Unit</th>
                                    <th width="20%" colspan="2">Quantity</th>
                                    <th width="20%">Total</th>
                                </tr>
                            </thead>
                            <tbody>
                            <? $i=0; ?>
                            @foreach($getOrderItem as $orderItem)
                            <? $i++; ?>
                                <tr>
                                    <td>{{$orderItem->product_name}}<input type="hidden" name="item_id[]" value="{{$orderItem->id}}"></td>

                                    <td><input type="number" min="0" step="any" name="cost_per_unit[]"  class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" value="{{round($orderItem->sales_per_unit,2)}}" readonly></td>

                                    <input type="hidden" id="rates_{{$i}}" class="form-control changesNo"  value="{{round($orderItem->bdt_rates,2)}}" readonly>

                                    <input type="hidden" id="cost_{{$i}}" class="form-control changesNo"  value="{{round($orderItem->foreign_amount,2)}}" readonly>

                                    <td><input type="number" min="0" max="{{$orderItem->maxQty}}" step="any" name="qty[]" id="quantity2_{{$i}}" class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" value="{{$orderItem->qty}}"></td>
                                    <td>{{$orderItem->uom_name}}</td>

                                    <td><input type="number" min="0" step="any" name="amount[]" id="total_{{$i}}" class="form-control totalLinePrice" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" value="{{round($orderItem->payable_amount,2)}}" readonly></td>
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
                                            <input type="number" min="0" step="any" class="form-control" name="total_amount" id="subTotal" placeholder="Total Amount" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly value="{{round($getOrder->total_amount,2)}}">
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
    <script src="{{asset('public/custom_js/script_order.js')}}"></script>

@endsection