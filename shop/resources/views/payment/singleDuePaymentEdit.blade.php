
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
                        <h4 class="panel-title">Due Payment </h4>
                    </div>
                    <div class="panel-body">
                    <div class="col-md-6">
                        <table class="table table-bordered ">
                            <tr>
                                <th>Date * :</th>
                                <td><?php echo $getPaymentData->t_date;?></td>
                            </tr>
                            <tr>
                                <th>Client Name :</th>
                                <td>{{$getPaymentData->client_name}}</td>
                            </tr>
                            <tr>
                                <th>Account : </th>
                                <td>{{$getPaymentData->account_name}}</td>
                            </tr>
                           

                        
                        </table>
                    </div>
                    <div class="col-md-6">
                        <table class="table table-bordered">
                            <tr>
                                <th>Ref(#ID). :</th>
                                <td><?php echo $getPaymentData->ref_id;?></td>
                            </tr>
                            <tr>
                                <th>Receive Method : </th>
                                <td>{{$getPaymentData->method_name}}</td>
                            </tr>
                        
                        </table>
                    </div>
                        {!! Form::open(array('route' => ['due-payment.update',$getPaymentData->id],'class'=>'form-horizontal author_form','method'=>'PUT','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                        <div class="form-group col-md-6 pull-right">
                                <label class="control-label col-md-4 col-sm-4" for="Date">Date * :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <input class="form-control" type="date" id="Date" name="t_date" placeholder="t_date" data-parsley-required="true" value="{{date('Y-m-d')}}" />
                                    </div>
                            </div>
                        	<div class="form-group">
								
								<input class="form-control" type="hidden" id="client" value="<?php echo $getPaymentData->company_name; ?>" name="company_name" placeholder="Company Name" data-parsley-required="true" />
							</div>
							
                            
                                <input type="hidden" name="updated_by" value="{{ Auth::user()->id }}">
                                <input type="hidden" name="fk_payment_id" value="{{ $getPaymentData->id }}">
                                <!-- transition -->
                                <div class="view_transition_table">
                                    <div class='row'>
                                        <div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
                                            <table class="table table-bordered padding5" id="table_auto">
                                                <thead>
                                                    <tr class="success">
                                                        <th width="18%">Sector</th>
                                                        <th width="32%">Description</th>
                                                        <th width="12%">Total</th>
                                                        <th width="13%">Prev. Paid</th>
                                                        <th width="12%">Due</th>
                                                        <th width="13%">Paid</th>
                                                        
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                @if(isset($getDuePaymentData))
                                                    <?php $i=0; ?>
                                                    @foreach($getDuePaymentData as $paymentItem)
                                                        <?php $i++; ?>

                                                    <tr>
                                                        <td>
                                                        {{$paymentItem->sub_category_name}}
                                                                
                                                            <input type="hidden" name="payment_item_old_id[]" id="<?php echo $paymentItem->id;?>" value="<?php echo $paymentItem->id;?>" class="payment_item_old_id">
                                                        </td>
                                                        
                                                        <td>
                                                            {{$paymentItem->description}}
                                                            
                                                        </td>
                                                        <td>
                                                        {{$paymentItem->total_amount}}
                                                            
                                                        </td>
                                                        <td>
                                                        {{$paymentItem->paid_amount}}
                                                            
                                                        </td>
                                                        <td>
                                                          {{$paymentItem->total_amount-$paymentItem->paid_amount}}
                                                           <input type="hidden" name="last_due[]" value="{{$paymentItem->total_amount-$paymentItem->paid_amount}}"> 
                                                        </td>
                                                        <td>
                                                            <input type="number" min="0" max="{{$paymentItem->total_amount-$paymentItem->paid_amount}}" name="paid[]" id="paid_<?php echo $paymentItem->id; ?>" class="form-control onChangeAmountPaid" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" value="0" required>
                                                            
                                                        </td>
                                                        
                                                    </tr>
                                                    @endforeach
                                                    <tr class="active">
                                                        <th>*</th>
                                                        <th style="text-align: right">Total =</th>
                                                        <th>{{$getPaymentData->amount}}</th>
                                                        <th>{{$getPaymentData->total_paid}}</th>
                                                        <th>{{$getPaymentData->amount-$getPaymentData->total_paid}}
                                                        </th>
                                                        <th></th>
                                                    </tr>
                                                @endif
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    
                                    <div class='row'>   
                                        <div class='col-xs-12 col-sm-8 col-md-8 col-lg-8'>
                                            
                                            
                                        </div>
                                        <div class='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
                                            
                                            <div class="form-group transition_cul_section">
                                                <label>Payable Amount: &nbsp;</label>
                                                <div class="input-group">
                                                    <div class="input-group-addon currency">৳</div>
                                                    <input value="<?php echo $getPaymentData->amount-$getPaymentData->total_paid;?>" type="number" min="0" step="any" class="form-control" id="total_amount" placeholder="Paid Amount" readonly>
                                                </div>
                                            </div>
                                            <div class="form-group transition_cul_section">
                                                <label>Paid Amount: &nbsp;</label>
                                                <div class="input-group">
                                                    <div class="input-group-addon currency">৳</div>
                                                    <input name="total_paid" value="" type="number" min="0" step="any" class="form-control" id="amountPaid" placeholder="Paid Amount" readonly>
                                                </div>
                                            </div>

                                            <div class="form-group transition_cul_section">
                                                <label>Due Amount: &nbsp;</label>
                                                <div class="input-group">
                                                    <div class="input-group-addon currency">৳</div>
                                                    
                                                    <input value="<?php echo $getPaymentData->amount-$getPaymentData->total_paid;?>" type="number" step="any" class="form-control" id="total-due-amount" placeholder="Due Amount" readonly>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-md-6 col-sm-6">
                                                    <button type="submit" class="btn btn-primary btn-lg">Submit</button>
                                                </div>
                                            </div>
                                        </div>

                                        </div>
                                    </div>
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

    //total amount paid calculate
     $(document).on('change keyup blur','.onChangeAmountPaid',function(){
         calculateTotalPaid();
     });
     function calculateTotalPaid(){
         totalPaid = 0;
         $('.onChangeAmountPaid').each(function(){

             //alert(total);
             if($(this).val() != '' )totalPaid += parseFloat( $(this).val() );
             $("#amountPaid").val(totalPaid);
             //check due
             amount_due = parseFloat($("#total_amount").val()) - parseFloat( $("#amountPaid").val());
             $("#total-due-amount").val(amount_due);
         });

     }
</script>


@endsection
