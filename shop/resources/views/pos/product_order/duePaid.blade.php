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
                    
                    <a href="javascript:;" onclick="window.print()" class="btn btn-sm btn-success m-b-10"><i class="fa fa-print m-r-5"></i> Print</a>
                    <a href='{{URL::to("inventory-product-order")}}' class="btn btn-sm btn-info m-b-10"><i class="fa fa-eye m-r-5"></i> View All Order</a>
                    
                    </span>
                    
                </div>
               {!! Form::open(array('url' =>'inventory-product-order-due-paid','class'=>'form-horizontal author_form','method'=>'POST', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
               <input type="hidden" name="id" value="{{$getOrder->id}}">
                <div class="row">
                    <div id="customer_info">
                        <div class="row">
                            <div class="col-md-6">
                                <table class="table">
                                     
                                    <tr>
                                        <td width="30%">Supplier Name :</td>
                                        <td>{{$getOrder->client_name}}</td>
                                    </tr>
                                    <tr>
                                        <td width="30%">Customer Id :</td>
                                        <td>{{$getOrder->client_id}}</td>
                                    </tr>
                                    <tr>
                                        <td width="30%">Mobile No :</td>
                                        <td>{{$getOrder->mobile_no}}</td>
                                    </tr>
                                    <tr>
                                        <td width="30%">Email : </td>
                                        <td>{{$getOrder->email_id}}</td>
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
                                    <td width="30%">Company name : </td>
                                    <td>{{$getOrder->company_name}}</td>
                                </tr>
                                <tr>
                                    <td>Date * :</td>
                                    <td><input class="form-control" type="date" name="payment_date" value="<?php echo date('Y-m-d'); ?>" data-parsley-required="true" /></td>
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
                                    <th>Barcode</th>
                                    <th>Product Name</th>
                                    <th>UOM</th>
                                    <th>Cost Per Unit</th>
                                    <th>Sales Per Unit</th>
                                    <th>Qty.</th>
                                    <th>Total</th>
                                </tr>
                            </thead>
                            <tbody>
                            @foreach($getOrderItem as $orderItem)
                                <tr>
                                    <td>
                                        {{$orderItem->barcode}}<br />
                                    </td>
                                    <td>{{$orderItem->product_name}}</td>
                                    <td>{{$orderItem->uom_name}}</td>
                                    <td>{{$orderItem->cost_per_unit}}</td>
                                    <td>{{$orderItem->sales_per_unit}}</td>
                                    <td>{{$orderItem->qty}}</td>
                                    <td>{{$orderItem->cost_per_unit*$orderItem->qty}}</td>
                                </tr>
                            @endforeach 
                                <tr class="success">
                                    <th></th>
                                    <th></th>
                                    <th></th>
                                    <th></th>
                                    <th></th>
                                    <th>Total=</th>
                                    <th>{{round($getOrder->total_amount,2)}}</th>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="invoice-price">
                        <div class='row'>   
                            <div class='col-xs-12 col-sm-7 col-md-7 col-lg-7'>
                              <textarea name="summery" rows="3" class="form-control "><?php echo $getOrder->summery; ?></textarea>  
                                
                            </div>
                            <div class='col-xs-12 col-sm-5 col-md-5 col-lg-5'>
                                <span class="form-inline">
                                    <div class="form-group aside_system">
                                        <label class="col-md-4">Previous Paid: &nbsp;</label>
                                        <div class="input-group col-md-8">
                                            <div class="input-group-addon currency">৳</div>
                                            <input value="<?php echo $getOrder->total_paid; ?>" type="number" class="form-control" readonly>
                                        </div>
                                    </div>
                                    <?
                                     $due= floatval($getOrder->total_amount)-floatval($getOrder->total_paid);
                                    ?>
                                    <div class="form-group aside_system">
                                        <label class="col-md-4">Previous Due: &nbsp;</label>
                                        <div class="input-group col-md-8">
                                            <div class="input-group-addon currency">৳</div>
                                            <input value="{{$due}}" type="number" min="0" step="any" class="form-control" id="subTotal" name="last_due" readonly>
                                        </div>
                                    </div>
                                        <!--  -->
                                    
                                    <div class="form-group aside_system">
                                        <label class="col-md-4">Paid Amount: &nbsp;</label>
                                        <div class="input-group col-md-8">
                                            <div class="input-group-addon currency">৳</div>
                                            <input value="" type="number" min="0" max="{{$due}}" step="any" class="form-control" name="paid" id="amountPaid" value="">
                                        </div>
                                    </div>
                                    
                                    <div class="form-group aside_system">
                                        <label class="col-md-4">Amount Due: &nbsp;</label>
                                        <div class="input-group col-md-8">
                                            <div class="input-group-addon currency">৳</div>
                                            <input value="{{$due}}" type="number" min="0" step="any" class="form-control amountDue"  id="amountDue" value="" readonly>
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