
@extends('layout.app')
	@section('content')
    <style type="text/css">
        .transition_cul_section{margin-left: 0 !important; margin-right: 0 !important;}
    </style>
	<!-- begin #content -->
	<div id="content" class="content">
		
		<div class="row">
		    <div class="col-md-12">
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a class="btn btn-info btn-xs" href="{{URL::to('/payment')}}">View All Payment List</a>
                            <a class="btn btn-success btn-xs" href="{{URL::to('/payment/create')}}">Add New Create Payment</a>
                        </div>
                        <h4 class="panel-title">Payment Page</h4>
                    </div>
                    <div class="panel-body">
                        {!! Form::open(array('route' => ['payment.update',$getPaymentData->id],'class'=>'form-horizontal author_form','method'=>'PUT','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                        	<div class="form-group">
								
								<input class="form-control" type="hidden" id="client" value="<?php echo $getPaymentData->company_name; ?>" name="company_name" placeholder="Company Name" data-parsley-required="true" />
							</div>
							
                            <div class="row">
                            <div class="col-md-6">
                                
                            
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4" for="Date">Date * :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <input class="form-control" value="<?php echo $getPaymentData->t_date;?>" type="date" id="Date" name="t_date" placeholder="t_date" data-parsley-required="true" />
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4">Client Name :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <select name="fk_client_id" data-placeholder="- Select Client-" class="chosen-select-client form-control" tabindex="10" required="required">
                                            @foreach($getClientData as $client)
                                                <option value="{{$client->id}}" @if($client->id == $getPaymentData->fk_client_id){{ "selected" }} @endif>{{$client->client_name}}</option>
                                            @endforeach
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4" for="number">Ref(#ID). :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <input class="form-control" type="number" id="number" value="<?php echo $getPaymentData->ref_id;?>" name="ref_id" data-parsley-type="number" placeholder="Ref. Id" />
                                    </div>
                                    <input type="hidden" name="invoice_no" value="<?php echo $getPaymentData->invoice_no;?>">
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4">Account :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <select name="fk_account_id" data-placeholder="- Select account-" class="chosen-select-account form-control" tabindex="10" required="required">
                                            @foreach($getAccountData as $account)
                                            <option value="{{$account->id}}" @if($account->id == $getPaymentData->fk_account_id){{ "selected" }} @endif>{{$account->account_name}}</option>
                                            @endforeach
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4">Receive Method :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <select name="fk_method_id" data-placeholder="- Select method-" class="chosen-select-method form-control" tabindex="10" required="required">
                                            @foreach($getMethodData as $method)
                                            <option value="{{$method->id}}" @if($method->id == $getPaymentData->fk_method_id){{ "selected" }} @endif>{{$method->method_name}}</option>
                                            @endforeach
                                        </select>
                                    </div>
                                </div>
                            </div>
                                <input type="hidden" name="updated_by" value="{{ Auth::user()->id }}">
                                <input type="hidden" name="fk_payment_id" value="{{ $getPaymentData->id }}">
                                <!-- transition -->
                                <div class="view_transition_table">
                                    <div class='row'>
                                        <div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
                                            <table class="table table-bordered table-hover" id="table_auto">
                                                <thead>
                                                    <tr>
                                                        <th width="2%"><input id="check_all" class="formcontrol" type="checkbox"/></th>
                                                        <th width="18%">Select Sub Category</th>
                                                        <th width="50%">Description</th>
                                                        <th width="15%">Total</th>
                                                        <th width="15%">Paid</th>
                                                        
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                @if(isset($getPaymentItemData))
                                                    <?php $i=0; ?>
                                                    @foreach($getPaymentItemData as $paymentItem)
                                                        <?php $i++; ?>

                                                    <tr>
                                                        <td><input class="case" type="checkbox"/></td>
                                                        <td>
                                                            <select name="fk_sub_category_id[]" data-placeholder="- Select -" class="chosen-select-category1 form-control" tabindex="10" required="required">
                                                                <?php 
                                                                foreach ($subCategories as $subCategory) {
                                                                 ?>
                                                                <option value="<?php echo $subCategory->id; ?>" @if($paymentItem->fk_sub_category_id == $subCategory->id){{ "selected" }} @endif><?php echo $subCategory->sub_category_name; ?></option>
                                                                <?php } ?>
                                                            </select>
                                                            <input type="hidden" name="payment_item_old_id[]" id="<?php echo $paymentItem->id;?>" value="<?php echo $paymentItem->id;?>" class="payment_item_old_id">
                                                        </td>
                                                        
                                                        <td>

                                                            <input type="text" data-type="description" name="description[]" id="description_1" value="{{$paymentItem->description}}" class="form-control autocomplete_txt" autocomplete="off" required>
                                                            
                                                        </td>
                                                        <td>
                                                            <input type="number" min="0" name="total[]" id="price_1" class="form-control onChangeAmount" value="{{$paymentItem->total_amount}}" onKeyPress="amount()" onKeyUp="amount()">
                                                            
                                                        </td>
                                                        <td>
                                                            <input type="number" min="0" name="paid[]" id="paid_1" class="form-control onChangeAmountPaid" value="{{$paymentItem->paid_amount}}"  autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;">
                                                            
                                                        </td>
                                                        
                                                    </tr>
                                                    @endforeach
                                                @endif
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="deleteItemList"></div>
                                    <div class='row'>
                                        <div class='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
                                            <button class="btn btn-danger delete" type="button">- Delete</button>
                                            <button class="btn btn-success addmore" type="button">+ Add More</button>
                                        </div>
                                    </div>
                                    <div class='row'>   
                                        <div class='col-xs-12 col-sm-8 col-md-8 col-lg-8'>
                                            
                                            
                                        </div>
                                        <div class='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
                                            
                                            <div class="form-group transition_cul_section">
                                                <label>Total Amount: &nbsp;</label>
                                                <div class="input-group">
                                                    <div class="input-group-addon currency">৳</div>
                                                    <input value="<?php echo intval($totalAmount->total_amount);?>" type="number" class="form-control" name="total_amount" id="total_amount" placeholder="Tatal Amount" readonly>
                                                    
                                                </div>
                                            </div>
                                            <div class="form-group transition_cul_section">
                                                <label>Paid Amount: &nbsp;</label>
                                                <div class="input-group">
                                                    <div class="input-group-addon currency">৳</div>
                                                    <input value="<?php echo intval($totalPaid->total_paid);?>" type="number" min="0" step="0.1" class="form-control" name="paid_amount" id="amountPaid" placeholder="Paid Amount" readonly>
                                                </div>
                                            </div>
                                            <div class="form-group transition_cul_section">
                                                <label>Due Amount: &nbsp;</label>
                                                <div class="input-group">
                                                    <div class="input-group-addon currency">৳</div>
                                                    
                                                    <input value="<?php echo intval($totalAmount->total_amount)-intval($totalPaid->total_paid);?>" type="number" step="0.1" class="form-control" name="due_amount" id="total-due-amount" placeholder="Due Amount" readonly>
                                                </div>
                                            </div>
                                        </span>

                                        </div>
                                    </div>
                                </div>
                            </div>
							<div class="form-group">
								<label class="control-label col-md-4 col-sm-4"></label>
								<div class="col-md-6 col-sm-6">
									<button type="submit" class="btn btn-primary">Update</button>
								</div>
							</div>
                        {!! Form::close(); !!}
                    </div>
                </div>
		    </div>
		</div>
	</div>
	<!-- end #content -->
	
<script src="{{asset('public/plugins/jquery/jquery-1.9.1.min.js')}}"></script>
<script src="{{ asset('public/js/chosen.jquery.js') }}" type="text/javascript"></script>
@include('payment.payment_js_setting_update')
<script type="text/javascript">
	$(document).ready(function() {
        App.init();
        DashboardV2.init();
        //
    });
    //
    /*chosen select option start*/
    //$(".chosen-select-category1").chosen({width:"180px"});
    //$(".chosen-select-category2").chosen({width:"180px"});
    $(".chosen-select-client").chosen({width:"100%"});
    $(".chosen-select-project").chosen({width:"100%"});
    $(".chosen-select-account").chosen({width:"100%"});
    $(".chosen-select-method").chosen({width:"100%"});
</script>


@endsection
