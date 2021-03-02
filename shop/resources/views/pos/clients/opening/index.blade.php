
	@extends('layout.app')
		@section('content')
		<!-- begin #content -->
		<div id="content" class="content">
			
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                            	<a class="btn btn-info btn-xs" href="{{URL::to('/inventory-client-opening-due')}}">View All</a>
                                
                            </div>
                            <h4 class="panel-title">Client Previous Due</h4>
                        </div>
                        <div class="panel-body">
                            
                                <div class="col-md-6 col-md-offset-3">
                            	    <div class="form-group">
                                        <label class="col-md-4 control-label" for="Date">Select client * :</label>
                                        <div class="col-md-8">
                                        <? $id= isset($client)?$client->id:''?>
                                            {{Form::select('id',$clients,$id,['class'=>'form-control select','placeholder'=>'Select client','required' ,'onchange'=>'loadDue(this.value)'])}}
                                        </div>
                                    </div>                                    
                                </div>
                            <div class="col-md-12">
                                <hr>
                            </div>
                        @if(isset($client))
                        <div class="col-md-6">
                            
                        <table class="table table-bordered">
                            <tr>
                                <td><b>Name : </b></td><td> <? echo $client->client_name ?></td>
                            </tr>
                            <tr>
                                <td><b>Mobile : </b></td><td> <? echo $client->mobile_no ?></td>
                            </tr>
                            <tr>
                                <td><b>Address : </b></td><td> <? echo $client->address ?></td>

                            </tr>
                            <tr>
                                <td><b>Email : </b></td><td> <? echo $client->email_id ?></td>
                            </tr>
                        </table>
                        </div>
                        <div class="col-md-6 ">
                        {!! Form::open(array('route' => 'inventory-client-opening-due.store','class'=>'form-horizontal author_form','method'=>'POST','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                        <input type="hidden" name="fk_client_id" value="{{$client->id}}">
                            <div class="form-group"> 
                                <label class="col-md-12">Description : </label>
                                <div class="col-md-12">
                                <textarea class="form-control" placeholder="Write something about previous due" name="summary">{{isset($openingDue->summary)?$openingDue->summary:''}}</textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-12">Date:</label>
                                <div class="col-md-12">
                                <?
                                if(isset($openingDue->date)){
                                    $date=date('d-m-Y',strtotime($openingDue->date));
                                }else{
                                    $date=date('d-m-Y');
                                }
                                if(isset($openingDue->total_amount)){
                                    $total_amount=round($openingDue->total_amount,2);
                                }else{
                                    $total_amount='';
                                }
                                if(isset($openingDue->paid_amount)){
                                    $paid_amount=round($openingDue->paid_amount,2);
                                }else{
                                    $paid_amount=0;
                                }
                                ?>
                                <input type="text" class="form-control datepicker" placeholder="Date" name="date" value="{{$date}}" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-12">Total Previous Due :</label>
                                <div class="col-md-12">
                                <input type="number" class="form-control" placeholder="Total Previous Due" name="total_amount" step="any" min="0" value="{{$total_amount}}" required>
                                </div>
                            </div>
                            @if(isset($openingDue->paid_amount))
                            <input type="hidden" name="id" value="{{$openingDue->id}}">
                            <div class="form-group">
                                <label class="col-md-12">Previous Due Paid:</label>
                                <div class="col-md-12">
                                <input type="text" class="form-control" placeholder="Previous Due Paid" value="{{$paid_amount}}" readonly>
                                </div>
                            </div>
                            @endif
                            <div class="form-group">
                                <div class="col-md-12">
                                <button class="btn btn-info form-control">Save Previous Due</button>
                                </div>
                            </div>
                        
                      
                        {{Form::close()}}
                        </div>
                        @endif
                        </div>
                    </div>
			    </div>
			</div>
		</div>
		<!-- end #content -->
		
    @endsection
@section('script')
<script type="text/javascript">
    function loadDue(id){
        window.location='{{URL::to("/inventory-client-opening-due")}}/'+id;
    }
</script>
@endsection
