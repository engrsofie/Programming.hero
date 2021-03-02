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
               {!! Form::open(array('route' =>[ 'inventory-product-order.update',$getOrder->id],'class'=>'form-horizontal author_form','method'=>'PUT', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
               <div class="row">     
                    <div class="form-group col-md-3">
                        <label class=" col-md-12">L/C No :</label>
                        <div class="col-md-12">
                           <input type="text" name="lc_no" class="form-control" value="{{$getOrder->lc_no}}">
                        </div>
                    </div>
                    <div class="form-group col-md-3">
                        <label class=" col-md-12">Opening Date :</label>
                        <div class="col-md-12">
                           <input class="form-control datepicker" type="text" name="opening_date" value="{{date('d-m-Y',strtotime($getOrder->opening_date))}}" data-parsley-required="true" /> 
                        </div>
                    </div>
                    <div class="form-group col-md-3">
                        <label class="col-md-12" for="Date">Order Date :</label>
                        <div class="col-md-12">
                            <input class="form-control datepicker" type="text" name="order_date" value="<?php echo date('d-m-Y',strtotime($getOrder->order_date)); ?>" data-parsley-required="true" />
                        </div>
                    </div>         
               </div>
                <div class="row">
                    <div id="customer_info">
                        <div class="row">
                            <div class="col-md-6">
                                <table class="table">
                                     
                                    <tr>
                                        <th width="30%">Supplier Name :</th>
                                        <th>{{$getOrder->client_name}}</th>
                                    </tr>
                                    <tr>
                                        <td width="30%">Supplier Id :</td>
                                        <td>{{$getOrder->client_id}}</td>
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
                                    <td width="30%">Mobile No :</td>
                                    <td>{{$getOrder->mobile_no}}</td>
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
                                    <th width="20%">Product Name</th>
                                    <th colspan="2">Cost Per Unit &amp; Currency</th>
                                    <th width="10%">Currency Rates in BDT</th>
                                    <th colspan="2" width="20%">Quantity</th>
                                    <th width="10%">Free Of Cost</th>
                                    <th width="20%">Total</th>
                                </tr>
                            </thead>
                            <tbody>
                            <? $i=0; ?>
                            @foreach($getOrderItem as $orderItem)
                            <? $i++; ?>
                                <tr>
                                    <td>{{$orderItem->product_name}}<input type="hidden" data-type="product_name" name="item_id[]" id="itemId_{{$i}}" class="form-control autocomplete_txt" autocomplete="off" value="{{$orderItem->id}}"></td>
                                    <td><input type="number" min="0" step="any" name="foreign_amount[]" id="cost_{{$i}}" class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" value="{{round($orderItem->foreign_amount,2)}}" ></td>
                                    <td width="10%">
                                        <input type="text" name="currency_name[]" placeholder="Currency" class="form-control" value="{{$orderItem->currency_name}}">
                                    </td>
                                    <td>
                                        <input type="number" min="0" step="any" name="bdt_rates[]" id="rates_{{$i}}" class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" value="{{round($orderItem->bdt_rates,2)}}">
                                        
                                    </td>
                                    <td><input type="number" min="0" step="any" name="qty[]" id="quantity2_{{$i}}" class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" value="{{$orderItem->qty}}"></td>
                                    <td>{{$orderItem->uom_name}}</td>
                                    <td> <input type="number" min="0" step="any" name="free_of_cost[]" class="form-control" placeholder="Free" value="{{$orderItem->free_of_cost}}"> </td>

                                    <td><input type="number" min="0" step="any" name="amount[]" id="total_{{$i}}" class="form-control totalLinePrice" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" value="{{round($orderItem->payable_amount,2)}}" readonly></td>
                                </tr>
                            @endforeach 
                            </tbody>
                        </table>
                    </div>
                    <div class="invoice-price">
                        <div class='row'>   
                            <div class='col-xs-12 col-sm-7 col-md-7 col-lg-7'>
                                
                                <div class="form-group">
                                    <label class="col-md-3 control-label">Comments :</label>
                                      <div class="col-md-9">
                                        <textarea name="summery" rows="2" class="form-control " placeholder="Write something about order."><?php echo $getOrder->summery; ?></textarea>
                                      </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-3 control-label">Shipping Address :</label>
                                      <div class="col-md-9">
                                        <input type="" name="shipping_address" class="form-control " value="{{$getOrder->shipping_address}}">
                                      </div>
                                </div>
                              
                              <div class="other_expenses" id="other_expenses">
                              <h5>Other Expenses</h5>
                                @foreach($oldExpenses as $exp)
                                <div class="form-group">
                                    <div class="col-md-1">
                                    <span class="pull-right" style="font-size: 18px">
                                        <i class="fa fa-check-square-o text-success"></i>
                                    <input type="hidden" name="other_expense_id[]" value="{{$exp->id}}">
                                    </span>
                                    </div>

                                      <div class="col-md-7">
                                          {{Form::text('expense_title[]',$exp->other_expense_title,['class'=>'form-control'])}}
                                      </div>
                                      <div class="col-md-4">
                                          <input type="number" value="{{$exp->other_expense}}" class="form-control otherExpensesAmount" name="expense_amount[]" min="0" step="any" placeholder="Expance amount">
                                      </div>
                                      
                                  </div>
                                @endforeach
                                <div class="form-group" id="list">
                                    <div class="col-md-1">
                                        <span class="pull-right" style="font-size: 18px">
                                            <i class="fa fa-plus-square-o text-warning"></i>
                                        </span>
                                    
                                    </div>
                                     <div id="appendList">
                                      <div class="col-md-7">
                                          {{Form::select('other_expense_title[]',$expenses,'',['class'=>'form-control','placeholder'=>'Select Other Expense'])}}
                                      </div>
                                      <div class="col-md-4">
                                          <input type="number" class="form-control otherExpensesAmount" name="other_expense[]" min="0" step="any" placeholder="Expance amount">
                                      </div>
                                      </div>
                                  </div>
                                </div>
                                <div>
                                  <div class="form-group">
                                      <div class="col-md-11 col-md-offset-1">
                                          <button type="button" onclick="appendList()" id="adExpense" class="btn btn-warning btn-xs">+ Add More</button>
                                          <button type="button" id="adEmpty" class="btn btn-success btn-xs">+ Add Empty Field</button>
                                      </div>
                                  </div>
                              </div>
                            </div>
                            <div class='col-xs-12 col-sm-5 col-md-5 col-lg-5'>
                                <span class="form-inlines">
                                    <div class="form-group aside_system">
                                        <label class="col-md-4">Sub Total : </label>
                                        <div class="input-group col-md-8">
                                            <div class="input-group-addon currency">৳</div>
                                            <input type="number" min="0" step="any" class="form-control" name="total_amount" id="subTotal" placeholder="Sub Total" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly value="{{round($getOrder->total_amount,2)}}">
                                        </div>
                                    </div>
                                    <div class="form-group aside_system">
                                        <label class="col-md-4">Total Amount with expenses :</label>
                                        <div class="input-group col-md-8">
                                            <div class="input-group-addon currency">৳</div>
                                            <input value="{{round($getOrder->total_price_with_expenses,2)}}" type="number" min="0" step="any" class="form-control" name="total_price_with_expenses" id="totalWithExpenses" placeholder="Total Amount" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly>
                                        </div>
                                    </div>
                                    <div class="form-group aside_system">
                                        <label class="col-md-4">Paid Amount : </label>
                                        <div class="input-group col-md-8">
                                            <div class="input-group-addon currency">৳</div>
                                            <input value="{{round($getOrder->total_paid,2)}}" type="number" min="0" step="any" class="form-control" name="total_paid" id="amountPaid" placeholder="Paid Amount" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;">
                                        </div>
                                    </div>
                                    
                                    <div class="form-group aside_system">
                                        <label class="col-md-4">Amount Due : </label>
                                        <div class="input-group col-md-8">
                                            <div class="input-group-addon currency">৳</div>
                                            <input value="{{round($getOrder->total_price_with_expenses,2)-round($getOrder->total_paid,2)}}" type="number" min="0" step="any" class="form-control amountDue" name="total"  id="amountDue" placeholder="Amount Due" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly >
                                        </div>
                                    </div>
                                    <div class="form-group aside_system">
                                        <label class=" col-md-4">Account :</label>
                                        <div class="input-group col-md-8">
                                           {{form::select('fk_account_id',$account,$getOrder->fk_account_id,['class'=>'form-control','placeholder'=>'Select Account','required'])}}
                                        </div>
                                    </div>
                                    <div class="form-group aside_system">
                                        <label class=" col-md-4">Method :</label>
                                        <div class="input-group col-md-8">
                                           {{form::select('fk_method_id',$method,$getOrder->fk_method_id,['class'=>'form-control','placeholder'=>'Select Method','required'])}}
                                        </div>
                                    </div>
                                    <div class="form-group aside_system">
                                        <label class="col-md-4" for="Date">Ref ID :</label>
                                        <div class="input-group col-md-8">
                                            <input class="form-control" type="text" name="ref_id" placeholder="Ref ID" value="{{$getOrder->ref_id}}" />
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
    <script>
        i=2;
        function appendList(){
            var html = '<div class="form-group" id="list'+i+'"><div class="col-md-1"> <button type="button" onclick="deleteAppend('+i+')" class="btn btn-danger btn-sm"><i class="fa fa-trash"></i></button> </div>';
            html += $('#appendList').html();
            html += '</div>';
            $('#other_expenses').append(html);
            i++;
        }
        function deleteAppend(id){
            $('#list'+id).remove();
        }
	</script>

@endsection