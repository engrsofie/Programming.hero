
@extends('layout.app')
	@section('content')
  
	<!-- begin #content -->
	<div id="content" class="content">
		<div class="row">
		    <div class="col-md-12">
                <div class="panel panel-inverse">
                    <div class="panel-heading"> 
                        <h4 class="panel-title">Sales</h4>
                    </div>
                    <div class="panel-body">
                        {!! Form::open(array('route' =>[ 'inventory-product-sales.update',$getInvoiceData->id],'class'=>'form-horizontal sales-form','method'=>'PUT', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                        	<div class="form-group">
								
								<input class="form-control" type="hidden" id="client" name="company_name" placeholder="Company Name" data-parsley-required="true" />

                                <input type="hidden" name="invoice_id" value="">
							</div>
							
                            <div class="col-md-12">
                                <!-- info -->
                                <div class="row">
                                    <div id="customer_info" style="width: 100%">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <table class="table table-bordered">
                                                 <tr>
                                                    <td width="45%">Invoice : </td>
                                                    <td>{{$getInvoiceData->invoice_id}}</td>
                                                </tr>
                                                <tr>
                                                    <td width="30%">Organization Name :</td>
                                                    <td>{{$getInvoiceData->company_name}}</td>
                                                </tr>
                                                <tr>
                                                    <td width="30%">Mobile No :</td>
                                                    <td>{{$getInvoiceData->mobile_no}}</td>
                                                </tr>
                                                
                                            </table>
                                        </div>
                                        <div class="col-md-6">
                                            <table class="table table-bordered">
                                                <tr>
                                                    <td width="45%">Email : </td>
                                                    <td>{{$getInvoiceData->email_id}}</td>
                                                </tr>
                                                <tr>
                                                    <td width="30%">Representative : </td>
                                                    <td>{{$getInvoiceData->client_name}}</td>
                                                </tr>
                                                <tr>
                                                    <td>Payment Date * :</td>
                                                    <td><input class="form-control datepicker" type="text"  name="date" value="{{date('d-m-Y',strtotime($getInvoiceData->date))}}" placeholder="t_date" data-parsley-required="true" /></td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                </div>
                                <input type="hidden" name="created_by" value="{{ Auth::user()->id }}">
                                <!-- transition -->
                                <div class="view_center_folwchart">
                                <div class='row'>
                                    <div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
                                        <table class="table table-bordered table-hover" id="table_auto">
                                            <thead>
                                                <tr class="active">
                                                <th width="3%">SL</th>
                                                    <th width="22%">Product Name</th>
                                                    <th width="15%" colspan="2">Quantity</th>
                                                    <th width="10%">Unit Price</th>
                                                    <th width="20%">Sub Total Price</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <? $i=0; ?>
                                            @foreach($getProductData as $sales)
                                            <? $i++; ?>
                                            <input type="hidden" name="sales_item_id[]" value="{{$sales->id}}">
                                                <tr>
                                                <td>{{$i}}</td>
                                                    <td>{{$sales->product_name}}  ({{$sales->model_name}})</td>
                                                    
                                                    <td><input type="number" value="{{$sales->sales_qty}}" min="0" step="any" name="sales_qty[]" id="quantity2_{{$i}}" class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;"></td>
                                                    <td>{{$sales->small_unit_name}}</td>
                                                    <td>
                                                    <input type="number" min="0" step="any" name="product_price_amount[]" id="hidden_{{$i}}" class="form-control changesNo" value="{{round($sales->product_price_amount,2)}}"></td>

                                                    <td>
                                                    <input type="number" value="{{round($sales->sales_qty,2)*round($sales->product_price_amount,2)}}" min="0" step="any" name="product_paid_amount[]" id="total_{{$i}}" class="form-control totalLinePrice" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly="readonly">

                                                    </td>
                                                </tr>
                                            @endforeach
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class='row'>   
                                    <div class='col-xs-12 col-sm-7 col-md-7 col-lg-7'>
                                    
                                    </div>
                                    <?
                                    $due=$getInvoiceData->total_amount-$getInvoiceData->paid_amount;
                                    ?>
                                    <div class='col-xs-12 col-sm-5 col-md-5 col-lg-5'>
                                        <span class="form-inlines">
                                           
                                            
                                            <?
                                            $paid_amount=isset($payment->paid)?$payment->paid:$getInvoiceData->paid_amount;
                                            ?>
                                            
                                            <input type="hidden" name="payment_id" value="{{isset($payment->id)?$payment->id:''}}">
                                           
                                            
                                            <!-- new -->
                                            <div class="form-group">
                                                <label class="col-md-4 control-label">Sub Total :</label>
                                                <div class="input-group col-md-8">
                                                    <div class="input-group-addon currency">৳</div>
                                                    <input tabindex="-1" value="{{round($getInvoiceData->total_amount+$getInvoiceData->discount,2)}}" type="number" min="0" step="any" class="form-control" id="subTotal" name="sub_total" placeholder="Sub Total" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-4 control-label">Discount :</label>
                                                <div class="input-group col-md-8">
                                                    <div class="input-group-addon currency">৳</div>
                                                    <input value="{{round($getInvoiceData->discount,2)}}" type="number" min="0" step="any" class="form-control changesNo" name="discount" id="discount" placeholder="Discount" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-4 control-label"><b>Total Amount :</b></label>
                                                <div class="input-group col-md-8">
                                                    <div class="input-group-addon currency">৳</div>
                                                    <input tabindex="-1" value="{{round($getInvoiceData->total_amount,2)}}" type="number" min="0" step="any" class="form-control" name="total_amount" id="total" placeholder="Total Amount" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly>
                                                </div>
                                            </div>
                                        <div id="clientPrev">
                                         <div class="form-group">
                                            <label class="col-md-4 control-label">Previous :</label>
                                            <div class="input-group col-md-8">
                                                <div class="input-group-addon currency">৳</div>
                                                <input tabindex="-1" value="{{round($getInvoiceData->prev_amount,3)}}" type="number" min="0" step="any" class="form-control" name="prev_amount" id="prev_amount" placeholder="Previous Amount" readonly>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-md-4 control-label"><b> Grand Total: </b></label>
                                            <div class="input-group col-md-8">
                                                <div class="input-group-addon currency">৳</div>
                                                <input tabindex="-1" value="{{round($getInvoiceData->total_amount+$getInvoiceData->prev_amount,2)}}" type="number" min="0" step="any" class="form-control" name="grand_total" id="grandTotal" placeholder="Total Amount" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly>
                                            </div>
                                        </div>
                                        </div>
                                        <div id="payment">
                                            
                                            <div class="form-group aside_system">
                                                <label class="col-md-4">Paid Amount :</label>
                                                <div class="input-group col-md-8">
                                                    <div class="input-group-addon currency">৳</div>
                                                    <input value="{{round($paid_amount,3)}}" type="number" min="0" step="any" class="form-control" name="total_paid" id="amountPaid" placeholder="Paid Amount" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;">
                                                </div>
                                            </div>
                                            
                                            <div class="form-group aside_system">
                                                <label class="col-md-4">Amount Due :</label>
                                                <div class="input-group col-md-8">
                                                    <div class="input-group-addon currency">৳</div>
                                                    <input tabindex="-1" value="{{round($getInvoiceData->total_amount+$getInvoiceData->prev_amount-$paid_amount,2)}}" type="number" min="0" step="any" class="form-control amountDue" name="due"  id="amountDue" placeholder="Amount Due" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly >
                                                </div>
                                            </div>
                                            <input type="hidden" name="fk_account_id" value="1">
                                            <input type="hidden" name="fk_method_id" value="3">
                                        </div>
                                                <!--  -->
                                        </span>

                                    </div>
                                </div>

                            </div><br>
                            </div>

							<div class="form-group">
								<label class="control-label col-md-2 col-sm-2"></label>
								<div class="col-md-8 col-sm-8">
									<button type="submit" class="btn btn-primary" style="width: 100%;">Confirm</button>
								</div>
                                <label class="control-label col-md-2 col-sm-2"></label>
							</div>
                        {!! Form::close(); !!}
                    </div>
                </div>
		    </div>
		</div>
	</div>
	<!-- end #content -->
@endsection
@section('script')
<script src="{{asset('public/custom_js/script_sales.js')}}"></script> 
@endsection
