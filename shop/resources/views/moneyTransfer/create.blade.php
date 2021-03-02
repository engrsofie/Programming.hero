
	@extends('layout.app')
		@section('content')
		<!-- begin #content -->
		<div id="content" class="content">
			
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                                <a class="btn btn-xs btn-info" href="{{URL::to('/account-money-transfer')}}">Transfered List</a>
                            </div>
                            <h4 class="panel-title">Balance Transfer </h4>
                        </div>
                        <div class="panel-body">
                            {!! Form::open(array('route' => 'account-money-transfer.store','class'=>'form-horizontal author_form','method'=>'POST','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                            <div class="well col-md-12 no-padding">
                                
                            
                            <div class="col-md-6">
                                <div class="col-md-12">
                                    <h6 class="text-center"><b><u>Transfer From</u></b></h6>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4">Branch :</label>
                                    <div class="col-md-8">
                                        {{Form::select('branch_one',$branch,Auth::user()->fk_branch_id,['class'=>'form-control branch','id'=>'branchOne'])}}
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4">Account :</label>
                                    <div class="col-md-8 branchOne">
                                        {{Form::select('transfer_from',$accounts,'',['class'=>'form-control account','id'=>'accountOne','placeholder'=>'Select Account','required'])}}
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4">Current Balance :</label>
                                    <div class="col-md-8">
                                        <input type="number" id="balanceOne" min="0" step="any" class="form-control accountOne" placeholder="Balance" readonly>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="col-md-12">
                                    <h6 class="text-center"><b><u>Transfer To</u></b></h6>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4">Branch :</label>
                                    <div class="col-md-8">
                                        {{Form::select('branch_one',$branch,'',['class'=>'form-control branch','id'=>'branchTwo','required','placeholder'=>'Select Branch'])}}
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4">Account :</label>
                                    <div class="col-md-8 branchTwo">
                                        <span class="form-control">First Select Branch</span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4">Current Balance :</label>
                                    <div class="col-md-8">
                                        <input type="number" id="balanceTwo" step="any" class="form-control" placeholder="Balance" readonly>
                                    </div>
                                </div>
                                
                            </div>
                            </div>
                            <div class="col-md-8 col-md-offset-2 border">
                                
                            	<div class="form-group">
									<label class="control-label col-md-3 col-sm-3" for="Date">Date * :</label>
									<div class="col-md-8 col-sm-8">
										<input class="form-control datepicker" type="text" name="date" placeholder="Date" data-parsley-required="true" value="<?php echo date('d-m-Y'); ?>" />
									</div>
								</div>
                                <div class="form-group">
                                    <label class="control-label col-md-3">Method :</label>
                                    <div class="col-md-8">
                                        {{Form::select('fk_method_id',$methods,'3',['class'=>'form-control','id'=>'method','placeholder'=>'Select Method'])}}
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3 col-sm-3" for="account_name">Amount * :</label>
                                    <div class="col-md-8 col-sm-8">
                                        <input class="form-control" type="number" id="amount" name="amount" step="any" min="0" placeholder="Amount" required>
                                    </div>
                                </div> 
                                <div class="form-group">
									<label class="control-label col-md-3 col-sm-3" for="account_name"> Description * :</label>
									<div class="col-md-8 col-sm-8">
										<textarea class="form-control" id="description" name="description" rows="4"  placeholder="Description"></textarea>
									</div>
								</div>

								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3"></label>
									<div class="col-md-8 col-sm-8">
										<button type="submit" class="btn btn-primary">Submit</button>
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
    <script type="text/javascript">
        $('#accountOne').on('change',function(){
            var id =$(this).val();
            $.ajax({
                url: "{{URL::to('account-money-transfer')}}/"+id,
                type: "GET",
                data:'',
                success: function(response){
                $('#amount').attr('max',response);
                $('#balanceOne').val(response);
                        
                }
            });
        });
        $('#accountTwo').on('change',function(){
            var id =$(this).val();
            $.ajax({
                url: "{{URL::to('account-money-transfer')}}/"+id,
                type: "GET",
                data:'',
                success: function(response){
                $('#balanceTwo').val(response);
                        
                }
            });
        });

        $('#branchOne').on('change',function(){
            var id =$(this).val();
            $('.branchOne').load('{{URL::to("load-acoount")}}/'+id+'/1');
        });
        $('#branchTwo').on('change',function(){
            var id =$(this).val();
            $('.branchTwo').load('{{URL::to("load-acoount")}}/'+id+'/2');
        })
    </script>
    @endsection
