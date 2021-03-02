@extends('layout.app')
	@section('content')
    <style type="text/css">
        .modal-dialog{width: 900px;}
        .invoice-note {margin-top: 35px;}
        .aside_system{width: 100%; overflow: hidden; margin: 10px 0px;}

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
                
                
                <div class="invoice-header" style="width: 100%; overflow: hidden;">
                    <div class="col-md-4 client_info">
                        <div class="list">
                            Company Name :
                            <label> {{$getOrder->client_name}}</label>
                        </div>
                        
                    </div>
                    <div class="col-md-4 client_info">
                        <div class="list">
                            L/C No :
                            <label> {{$getOrder->lc_no}}</label>
                        </div>
                        <div class="list">
                           L/C Opening Date :
                            <label> {{$getOrder->opening_date}}</label>
                        </div>
                        
                    </div>
                    <div class="col-md-4 client_invoice_id">
                       <div class="list">
                            Order Id :
                            <label> <a href="{{URL::to('inventory-order-browser',$getOrder->inventory_order_id)}}">{{$getOrder->inventory_order_id}}</a></label>
                        </div>
                        <div class="list">
                           Order Date :
                            <label> {{$getOrder->order_date}}</label>
                        </div> 
                    </div>
                </div>
                @if(count($oldChallan)>0)
                <div class="col-md-12">
                    <ul class="old_challan">
                        <li><b>Challan : </b></li>
                        @foreach($oldChallan as $challan)
                        <li><a class="btn btn-xs btn-success" href='{{URL::to("inventory-product-order-challan/$challan->id")}}'>{{$challan->challan_id}}</a></li>
                        @endforeach
                    </ul>
                </div>
                @endif
                @if($getOrder->total_amount>0)
               {!! Form::open(array('url'=> 'add-to-inventory','method'=>'POST','role'=>'form','data-parsley-validate novalidate')) !!}
                {{ Form::hidden('id',$id)}}

                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th width="5%"><i class="fa fa-trash text-danger"></i></th>
                                    <th>Product Name</th>
                                    <th colspan="2" width="15%">Quantity</th>
                                    <th width="10%">Free of cost</th>
                                    <th colspan="2" width="18%">Cost Per Unit</th>
                                    <th width="18%">Total (Tk.)</th>
                                    <th width="18%">Location</th>
                                </tr>
                            </thead>
                            <tbody>
                            <? $i=0; ?>
                            @foreach($getOrderItem as $orderItem)
                            @if($orderItem->qty>0)
                            <? $i++; ?>
                                <tr id="row{{$i}}">
                                <td><button type="button" class="fa fa-trash btn btn-danger btn-xs"  onclick="removeRow({{$i}})"></button>
                                <input type="hidden" name="order_item_id[]" value="{{$orderItem->id}}"></td>
                                    <td>{{$orderItem->product_name}}</td>
                                    <td><input type="number" min="0" step="any" max="{{$orderItem->qty}}" name="qty[]" id="quantity2_{{$i}}" class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" value="{{$orderItem->qty}}"></td>
                                    <td>{{$orderItem->uom_name}}</td>
                                    <td> <input type="number" min="0" step="any" name="free_of_cost[]" class="form-control" placeholder="Free" value="{{$orderItem->free_of_cost}}"> </td>

                                    <td><input id="cost_{{$i}}" class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" value="{{round($orderItem->foreign_amount,2)}}" readonly ></td>
                                     <td width="5%">
                                        {{$orderItem->currency_name}}
                                    </td>
                                    <input type="hidden" id="rates_{{$i}}" value="{{round($orderItem->bdt_rates,2)}}">
                                    <td><input type="number" min="0" step="any" name="amount[]" id="total_{{$i}}" class="form-control totalLinePrice" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" value="{{round($orderItem->payable_amount,2)}}" readonly></td>
                                    <td>
                                        {{Form::select('fk_stock_position_id[]',$stockPosition,'',['class'=>'form-control select','placeholder'=>'Select Location','required'])}}
                                    </td>
                                </tr>
                                @endif
                            @endforeach 
                            </tbody>
                        </table>
                    
                <div class="invoice-content">
                    <div class="invoice-price">
                        <div class='row'>   
                            <div class='col-xs-12 col-sm-7 col-md-7 col-lg-7'>
                              <textarea rows="3" class="form-control " placeholder="Order note" readonly><?php echo $getOrder->summery; ?></textarea>  
                                
                            </div>
                            <div class='col-xs-12 col-sm-5 col-md-5 col-lg-5'>
                                <span class="form-inline">
                                    <div class="form-group aside_system">
                                            <label class="col-md-4">Total Amount: &nbsp;</label>
                                            <div class="input-group col-md-8">
                                                <div class="input-group-addon currency">৳</div>
                                                <input name="total_amount" value="<?php echo round($getOrder->total_amount,2); ?>" type="number" min="0" step="any" class="form-control" id="subTotal" readonly>
                                            </div>
                                        </div>
                                        <!--  -->
                                    
                                    <div class="form-group aside_system">
                                        <label class="col-md-4">Challan Id: &nbsp;</label>
                                        <div class="input-group col-md-8">
                                            <input type="text" name="challan_id" class="form-control" required>
                                        </div>
                                    </div>
                                    
                                    <div class="form-group aside_system">
                                        <label class="col-md-4">Received Date: &nbsp;</label>
                                        <div class="input-group col-md-8">
                                            <input name="received_date" value="{{date('Y-m-d')}}" type="date" class="form-control">
                                        </div>
                                    </div>
                                </span>

                            </div>
                        </div>
                        <br>
                    <button type="submit" class="btn btn-primary pull-right">Add to Inventory</button>

                    </div>
                </div>
                {!! Form::close() !!}
                @else
                <h2 class="text-success">This order is received successfully.</h2>
                @endif
            </div>

			<!-- end invoice -->
		</div>
		<!-- end #content -->

		
    <script src="{{asset('public/plugins/jquery/jquery-1.9.1.min.js')}}"></script>
    <script src="{{asset('public/custom_js/script_order.js')}}"></script>
    <script>
        function removeRow(id){
            var sub_total = $('#total_'+id).val();
            var total = $('#subTotal').val()-sub_total;
            $('#subTotal').val(total);
            $('#row'+id).html('<td colspan="8" class="text-warning">Pending for next challan</td>');
        }
	</script>

@endsection