
@extends('layout.app')
	@section('content')
    <style type="text/css">
        .transition_cul_section{margin-left: 0 !important; margin-right: 0 !important;}
        input[type=number]::-webkit-inner-spin-button, 
        input[type=number]::-webkit-outer-spin-button { 
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            margin: 0; 
        }
    </style>
	<!-- begin #content -->
	<div id="content" class="content">
		
		<div class="row">
		    <div class="col-md-12">
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a class="btn btn-info btn-xs" href="{{URL::to('/payment')}}">View All Payment List</a>
                        </div>
                        <h4 class="panel-title">Payment </h4>
                    </div>
                    <div class="panel-body">
                        {!! Form::open(array('route' => 'payment.store','class'=>'form-horizontal author_form','method'=>'POST','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
							
                            <div class="row">
                            <div class="col-md-6">
                                
                           
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4" for="Date">Date * :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <input class="form-control" type="date" id="Date" name="t_date" placeholder="t_date" data-parsley-required="true" value="{{date('Y-m-d')}}" />
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4">Pay to :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <input name="client_name" class="form-control" id="client" onfocus="autoComplete(this.id)" type="text"  placeholder="Pay to" />
                                        <input type="hidden" name="clientId" id="client_h">
                                    </div>
                                </div>
                             </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4" for="number">Ref(#ID). :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <input class="form-control" type="number" id="number" name="ref_id" data-parsley-type="number" placeholder="Ref. Id" />
                                    </div>
                                    <input type="hidden" name="invoice_no">
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4">Account :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <select name="fk_account_id" data-placeholder="- Select account-" class="select form-control" tabindex="10" required="required">
                                            <option value="">Please choose</option>
                                            @foreach($getAccountData as $account)
                                            <option value="{{$account->id}}" {{($account->id==1)?'selected':''}}>{{$account->account_name}}</option>
                                            @endforeach
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4">Receive Method :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <select name="fk_method_id" data-placeholder="- Select method-" class="chosen-select-method form-control" tabindex="10" required="required">
                                            <option value="">Please choose</option>
                                            @foreach($getMethodData as $method)
                                            <option value="{{$method->id}}" {{($method->id==3)?'selected':''}}>{{$method->method_name}}</option>
                                            @endforeach
                                        </select>
                                    </div>
                                </div>
                            </div>
                                <input type="hidden" name="created_by" value="{{ Auth::user()->id }}">
                                <!-- transition -->
                                <div class="view_transition_table">
                                    <div class='row'>
                                        <div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
                                            <table class="table table-bordered table-hover" id="table_auto">
                                                <thead>
                                                    <tr>
                                                        <th width="2%"><input id="check_all" class="formcontrol" type="checkbox"/></th>
                                                        <th width="18%">Select Sector</th>
                                                        <th width="50%">Description</th>
                                                        <th width="15%">Total</th>
                                                        <th width="15%">Paid</th>
                                                        
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td><input class="case" type="checkbox"/></td>
                                                        <td>
                                                            <select name="fk_sub_category_id[]" data-placeholder="- Select -" class="select form-control" tabindex="10" required="required">
                                                                <option value="">Please choose</option>
                                                                
                                                                <?php 
                                                                foreach ($subCategories as $subCategory) {
                                                                 ?>
                                                                 
                                                                <option value="<?php echo $subCategory->id; ?>"><?php echo $subCategory->sub_category_name; ?></option>
                                                                <?php } ?>
                                                            </select>
                                                        </td>
                                                        
                                                        <td>

                                                            <input type="text" data-type="description" name="description[]" id="description_1" class="form-control autocomplete_txt">
                                                            
                                                        </td>
                                                        <td>
                                                            <input type="number" min="0" name="total[]" id="price_1" class="form-control onChangeAmount" onKeyPress="amount(this.value,'1')" onKeyUp="amount(this.value,'1')">
                                                            
                                                        </td>
                                                        <td>
                                                            <input type="number" min="0" name="paid[]" id="paid_1" class="form-control onChangeAmountPaid" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;">
                                                            
                                                        </td>
                                                        
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div class='row'>
                                        <div class='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
                                            <button class="btn btn-success addmore" type="button">+ Add More</button>
                                            <button class="btn btn-danger delete" type="button">- Delete</button>
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
                                                    <input value="0" type="number" class="form-control" name="total_amount" id="total_amount" placeholder="Tatal Amount" readonly>
                                                    
                                                </div>
                                            </div>
                                            <div class="form-group transition_cul_section">
                                                <label>Paid Amount: &nbsp;</label>
                                                <div class="input-group">
                                                    <div class="input-group-addon currency">৳</div>
                                                    <input value="0" type="number" min="0" step="any" class="form-control" name="paid_amount" id="amountPaid" placeholder="Paid Amount" readonly>
                                                </div>
                                            </div>
                                            <div class="form-group transition_cul_section">
                                                <label>Due Amount: &nbsp;</label>
                                                <div class="input-group">
                                                    <div class="input-group-addon currency">৳</div>
                                                    
                                                    <input value="0" type="number" step="any" class="form-control" name="due_amount" id="total-due-amount" placeholder="Due Amount" readonly>
                                                </div>
                                            </div>
                                        </span>

                                        </div>
                                    </div>
                                </div>
                            </div>

							 <div class="form-group col-md-12">
                                <label class="control-label col-md-2 col-sm-2"></label>
                                <div class="col-md-8 col-sm-8">
                                    <br>
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
	        

<input type="hidden" value="{{URL::to('')}}" id="rootUrl">

@endsection
@section('script')
@include('payment.payment_js_setting')
@endsection
