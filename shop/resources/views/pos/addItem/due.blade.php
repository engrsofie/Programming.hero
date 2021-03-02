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
                    <a href='{{URL::to("inventory-product-add")}}' class="btn btn-sm btn-info m-b-10"><i class="fa fa-eye m-r-5"></i> View All</a>
                    </span>
                    <b>Due Paid Inventory Product</b>
                    
                </div>
               {!! Form::open(array('url' =>'inventory-product-add-due','class'=>'form-horizontal author_form','method'=>'POST', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
               <input type="hidden" name="created_by" value="{{Auth::user()->id}}">
               <input type="hidden" name="id" value="{{$getOrder->id}}">
                <div class="invoice-content">
                     <h5><b>Company:</b> {{$getOrder->company_name}}</h5>
                     <h5><b>Branch:</b> {{$getOrder->branch_name}}</h5>
                     <h5><b>Date:</b> <input type="text" name="date" class=" datepicker" value="{{date('d-m-Y',strtotime($getOrder->date))}}"> </h5>
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr class="active">
                                    <th width="18%">Product Name</th>
                                    <th>Cost Per Unit</th>
                                    <th>Sales Per Unit</th>
                                    <th colspan="2" width="18%">Quantity</th>
                                    <th width="18%">Total</th>
                                </tr>
                            </thead>
                            <tbody>
                            <? $i=0; ?>
                            @foreach($getOrderItem as $orderItem)
                            <? $i++; ?>
                                <tr>
                                    <td>{{$orderItem->product_name}} ({{$orderItem->model_name}})<input type="hidden" data-type="product_name" name="item_id[]" id="itemId_{{$i}}" class="form-control autocomplete_txt" autocomplete="off" value="{{$orderItem->id}}"></td>
                                    <td>
                                        <input type="number" value="{{round($orderItem->cost_per_unit,3)}}" min="0" step="any" name="cost_per_unit[]" id="cost_{{$i}}" class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" placeholder="Unit Price" readonly> 
                                    </td>
                                    <td>
                                        <input type="number" value="{{round($orderItem->sales_per_unit,3)}}" min="0" step="any" name="sales_per_unit[]" class="form-control" placeholder=" Sales Price" readonly> 
                                    </td>
                                    
                                    <td>
                                        <input type="number" value="{{round($orderItem->qty,3)}}" min="0" step="any" name="qty[]" id="quantity2_{{$i}}" class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" placeholder="Quantity" readonly>
                                        
                                    </td>
                                    <td>
                                    <span id="uom_{{$i}}">Unit</span> 
                                    </td>
                                    <td>
                                        <input type="number" value="{{round($orderItem->payable_amount,3)}}" min="0" step="any" name="amount[]" id="total_{{$i}}" class="form-control totalLinePrice" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly>
                                        
                                    </td>

                                </tr>
                            @endforeach 
                            </tbody>
                        </table>
                    </div>
                    <div class="invoice-price">
                        <div class='row'>   
                            <div class='col-xs-12 col-sm-7 col-md-7 col-lg-7'></div>
                            <div class='col-xs-12 col-sm-5 col-md-5 col-lg-5'>
                                <span class="form-inlines">
                                    <div class="form-group aside_system">
                                        <label class="col-md-4">Total Amount : </label>
                                        <div class="input-group col-md-8">
                                            <div class="input-group-addon currency">৳</div>
                                            <input type="number" min="0" step="any" class="form-control" name="total_amount" id="subTotal" placeholder="Sub Total" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly value="{{round($getOrder->total_amount,2)}}">
                                        </div>
                                    </div>
                                    <div class="form-group aside_system">
                                        <label class="col-md-4">Previous Paid :</label>
                                        <div class="input-group col-md-8">
                                            <div class="input-group-addon currency">৳</div>
                                            <input type="number" min="0" step="any" class="form-control" placeholder="Previous Paid" value="{{round($getOrder->total_paid,2)}}" readonly>
                                        </div>
                                    </div>
                                     <?
                                     $due= floatval($getOrder->total_amount)-floatval($getOrder->total_paid);
                                    ?>
                                    <div class="form-group aside_system">
                                        <label class="col-md-4">Total Due :</label>
                                        <div class="input-group col-md-8">
                                            <div class="input-group-addon currency">৳</div>
                                            <input type="number" min="0" step="any" class="form-control" name="last_due" placeholder="Total Due" value="{{round($due,2)}}" readonly>
                                        </div>
                                    </div>
                                    <div class="form-group aside_system">
                                        <label class="col-md-4">Paid Amount: &nbsp;</label>
                                        <div class="input-group col-md-8">
                                            <div class="input-group-addon currency">৳</div>
                                            <input value="" type="number" min="0" max="{{$due}}" step="any" class="form-control" name="paid" id="amountPaid" value="">
                                        </div>
                                    </div>
                                </span>

                            </div>
                        </div>
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
    <script src="{{asset('public/custom_js/script_add_product.js')}}"></script>

@endsection