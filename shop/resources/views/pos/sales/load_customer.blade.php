<div class="row">
	<!-- <div class="form-group col-md-6">
	    <label class="control-label col-md-5 col-sm-5">Customer Name :</label>
	    <div class="col-md-7 col-sm-7">
	    	<input type="text" value="{{$getCustomer->customer_name}}" readonly class="form-control">
            	   
	    </div>
	</div> -->
    <input type="hidden" value="{{$getCustomer->id}}" id="customerId"> 
    <div class="form-group col-md-6">
        <label class="control-label col-md-5 col-sm-5">Customer Email :</label>
        <div class="col-md-7 col-sm-7">
            <input type="text" value="{{$getCustomer->customer_email}}" readonly class="form-control"> 
        </div>
    </div>
	<div class="form-group col-md-6">
	    <label class="control-label col-md-5 col-sm-5">Customer Phone No. :</label>
	    <div class="col-md-7 col-sm-7">
	     	<input type="text" value="{{$getCustomer->customer_phone}}" readonly class="form-control">    
	    </div>
	</div>
</div>
<div class="row">
	
	<div class="form-group col-md-6">
	    <label class="control-label col-md-5 col-sm-5">Area Name :</label>
	    <div class="col-md-7 col-sm-7">
	        <input type="text" value="{{$getCustomer->area_name}}" readonly class="form-control"> 
	    </div>
	</div>
    <div class="form-group col-md-6">
        <label class="control-label col-md-5 col-sm-5">Line Package Name :</label>
        <div class="col-md-7 col-sm-7">
            <input type="text" value="{{$getCustomer->line_name}}" readonly class="form-control"> 
        </div>
    </div>
</div>
<div class="row">
	
	<div class="form-group col-md-6">
	    <label class="control-label col-md-5 col-sm-5">Line Amount :</label>
	    <div class="col-md-7 col-sm-7">
	        <input type="text" name="line_amount" id="line_amount" value="{{$getCustomer->line_amount}}" readonly class="form-control"> 
	    </div>
	</div>
    <div class="form-group col-md-6">
        <label class="control-label col-md-5 col-sm-5">Payment method Option :</label>
        <div class="col-md-7 col-sm-7">
            <select name="fk_line_transition_id" data-placeholder="- Select Payment option-" class="form-control select1" tabindex="10" required="required">
                <option value="-1">Please choose Payment option</option>
                @foreach($getPaymentOption as $transition)
                    <option value="{{$transition->id}}">{{$transition->name}}</option>
                @endforeach
            </select>
        </div>
    </div>
</div>
<div class="row">
    <div class="form-group col-md-6">
        <label class="control-label col-md-5 col-sm-5">Staff Name :</label>
        <div class="col-md-7 col-sm-7">
            <select name="fk_staff_id" data-placeholder="- Select Staff-" class="form-control select1" tabindex="10" required="required">
                <option value="">Please choose Staff</option>
                @foreach($getStaff as $staff)
                    <option value="{{$staff->id}}">{{$staff->staff_name}}</option>
                @endforeach
            </select>
        </div>
    </div>
    <div class="form-group col-md-6">
        <label class="control-label col-md-5 col-sm-5">Transition Type :</label>
        <div class="col-md-7 col-sm-7">
            <select name="fk_transition_type_id" data-placeholder="- Select Staff-" class="form-control select1" tabindex="10" required="required" onchange="transitionType(this.value)">
                <option value="">Please choose Transition</option>
                @foreach($getTransitionType as $transitionType)
                    <option value="{{$transitionType->id}}">{{$transitionType->cost_category_name}}</option>
                @endforeach
            </select>
        </div>
    </div>
    
</div>
<!-- <div class="row">
    
</div> -->

<script src="{{asset('public/plugins/jquery/jquery-1.9.1.min.js')}}"></script>  
<script type="text/javascript">

    var amount = $('#line_amount').val();
    
    $('.select1').chosen("liszt:updated");

    function transitionType(value){
        //alert(value);
        customerId = $('#customerId').val();
        costAmount = $('#line_amount').val();
        var _token = $('input[name="_token"]').val();

       $.ajax({
            url: "{{URL::to('/')}}"+'/payment-transition-cost',
            type: "POST",
            data: { _token : _token,
                customerId:  customerId,
                transitionId:  value,
                costAmount: costAmount,
                },
            success: function(response){
                console.log(response);
                $('#total_amount').val(response);
                $('.line_amount').val(response);
                $('#line_cost_amount').val(response);
                //$("#show-preview-team").show();
                    
            }
        });
    }


</script>