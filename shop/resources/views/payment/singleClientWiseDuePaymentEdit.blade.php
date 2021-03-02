
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
                        <h4 class="panel-title">Client Wise Due Payment Page </h4>
                    </div>
                    <div class="panel-body">
                        {!! Form::open(array('route' => ['client-wise-due-payment.update',$getClientData->id],'class'=>'form-horizontal author_form','method'=>'PUT','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                        	<div class="form-group">
								<input class="form-control" type="hidden" id="client" value="<?php echo $companyInfo->company_name; ?>" name="company_name" placeholder="Company Name" data-parsley-required="true" />
							</div>
							
                            <div class="row">
                                 
                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label class="control-label col-md-4 col-sm-4">Client Name :</label>
                                        <div class="col-md-6 col-sm-6">
                                            <select name="fk_client_id" data-placeholder="- Select Client-" class="chosen-select-client form-control" tabindex="10" required="required" readonly>
                                                
                                                <option value="{{$getClientData->id}}" >{{$getClientData->client_name}}</option>
                                                
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label class="control-label col-md-4 col-sm-4">Client Phone :</label>
                                        <div class="col-md-6 col-sm-6">
                                            <input type="text" value="<?php echo $getClientData->mobile_no ?>" readonly class="form-control">
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label class="control-label col-md-4 col-sm-4">Account :</label>
                                        <div class="col-md-6 col-sm-6">
                                            <select name="fk_account_id" data-placeholder="- Select account-" class="chosen-select-account form-control" tabindex="10" required="required">
                                                <option value="">- Select -</option>
                                                @foreach($getAccountData as $account)
                                                <option value="{{$account->id}}">{{$account->account_name}}</option>
                                                @endforeach
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label class="control-label col-md-4 col-sm-4">Receive Method :</label>
                                        <div class="col-md-6 col-sm-6">
                                            <select name="fk_method_id" data-placeholder="- Select method-" class="chosen-select-method form-control" tabindex="10" required="required">
                                                <option value="">- Select -</option>
                                                @foreach($getMethodData as $method)
                                                <option value="{{$method->id}}">{{$method->method_name}}</option>
                                                @endforeach
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <input type="hidden" name="updated_by" value="{{ Auth::user()->id }}">
                                
                                <!-- transition -->
                                <div class="view_transition_table">
                                    <div class='row'>
                                        <div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
                                            <table class="table table-bordered table-hover" id="table_auto">
                                                <thead>
                                                    <tr>
                                                        <th width="2%"><input id="check_all" class="formcontrol" type="checkbox"/></th>
                                                        <th width="18%">Select Sub Category</th>
                                                        <th width="41%">Description</th>
                                                        <th width="13%">Total</th>
                                                        <th width="13%">Paid</th>
                                                        <th width="13%">Receive</th>
                                                        
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                @if(isset($getInvoiceData))
                                                    <?php $i=0; ?>
                                                    @foreach($getInvoiceData as $paymentItem)
                                                        <?php $i++; ?>
                                                    <tr>
                                                        <td><input class="case" type="checkbox"/></td>
                                                        
                                                        <td>
                                                            <input class="form-control" value="{{$paymentItem->sub_category_name}}" required="required" readonly="readonly">
                                                                
                                                            <input type="hidden" name="payment_item_old_id[]" id="<?php echo $paymentItem->id;?>" value="<?php echo $paymentItem->id;?>" class="payment_item_old_id">
                                                        </td>
                                                        
                                                        <td>

                                                            <input type="text" data-type="description" id="description_1" value="{{$paymentItem->description}}" class="form-control autocomplete_txt" autocomplete="off" required readonly="readonly">
                                                            
                                                        </td>
                                                        <td>
                                                            <input type="number" min="0" id="price_1" class="form-control onChangeAmount" value="{{$paymentItem->total_amount}}" readonly="readonly">
                                                            
                                                        </td>
                                                        <td>
                                                            <input type="number" min="0" id="paid_1" class="form-control onChangeAmountPaid" value="{{$paymentItem->paid_amount}}" required readonly="readonly">
                                                            
                                                        </td>
                                                        <td>
                                                            <input type="number" min="0" max="<?php echo intval($paymentItem->total_amount)-intval($paymentItem->paid_amount);?>" name="paid[]" id="paid_<?php echo $paymentItem->id; ?>" class="form-control paid" value="0" required>
                                                            
                                                        </td>
                                                        
                                                    </tr>
                                                    @endforeach
                                                @endif
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    
                                    <div class='row'>   
                                        <div class='col-xs-12 col-sm-8 col-md-8 col-lg-8'>
                                            
                                            
                                        </div>
                                        <div class='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
                                            
                                            <!-- <div class="form-group transition_cul_section">
                                                <label>Paid Amount: &nbsp;</label>
                                                <div class="input-group">
                                                    <div class="input-group-addon currency">৳</div>
                                                    <input value="" type="number" min="0" step="0.1" class="form-control" id="amountPaid" placeholder="Paid Amount" readonly>
                                                </div>
                                            </div> -->
                                            <div class="form-group transition_cul_section">
                                                <label>Due Amount: &nbsp;</label>
                                                <div class="input-group">
                                                    <div class="input-group-addon currency">৳</div>
                                                    
                                                    <input value="<?php echo intval($totalAmount->total_amount)-intval($totalPaid->total_paid);?>" type="number" step="0.1" class="form-control" id="total-due-amount" placeholder="Due Amount" readonly>
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
<!--  -->
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
<script>
    $(".paid").keyup(function(){
        var id = $(this).attr('id');
        var value = $(this).attr('value');
        var max = $(this).attr('max');
        
        if(parseInt(max) < parseInt(value)){
            alert("This value should be between 0 and "+max);
             $('#'+id).val(max);
         }else if(parseInt(value) < 0){
            alert("This value should be between 0 and "+max);
            $('#'+id).val('0');
         }

        // due check
        // total_due = $("#total-due-amount").val();
        // //alert(total_due);
        // due_amount = parseInt(total_due)-parseInt($('#'+id).val());
        // $("#total-due-amount").val(due_amount);
       
    });

    $('.paid').change(function(){
        var id = $(this).attr('id');
         //alert(id);
        total_due = $("#total-due-amount").val();
        //alert(total_due);
        due_amount = parseInt(total_due)-parseInt($('#'+id).val());
        var duePaid = $("#total-due-amount").val(due_amount);
        if(parseInt(duePaid)<0){
           $("#total-due-amount").val(0); 
        }
     });
    
</script>


@endsection
