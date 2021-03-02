
	@extends('layout.app')
		@section('content')
		<!-- begin #content -->
		<div id="content" class="content">
			
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                                @if(isset($client))
                                    <a href="javascript:;" onclick="printPage('print_body')" class="btn btn-xs btn-success"><i class="fa fa-print"></i> Print</a>
                                @else
                                	<a class="btn btn-info btn-xs" href="{{URL::to('/inventory-return')}}">View All</a>
                                @endif
                            </div>
                            <h4 class="panel-title">Product Return</h4>
                        </div>
                        <div class="panel-body">
                           
                            {!! Form::open(array('url' =>'inventory-return/create','class'=>'form-horizontals','method'=>'GET','role'=>'form','data-parsley-validate novalidate')) !!}
                                <div class="col-md-4 no-padding">
                                    <div class="form-group">
                                        <label class="col-md-12" for="client">Select Organization :</label>
                                        <div class="col-md-12">
                                            <? $id= isset($client)?$client->id:''?>
                                            {{Form::select('id',$clients,$id,['class'=>'form-control select','placeholder'=>'Select Organization','required'])}}
                                        </div>
                                    </div>                                    
                                </div>
                                <div class="col-md-3 no-padding">
                                    <div class="form-group">
                                        <label class="col-md-12" for="from">From :</label>
                                        <div class="col-md-12">
                                            
                                            {{Form::text('from',date('d-m-Y'),['class'=>'form-control datepicker'])}}
                                        </div>
                                    </div>                                    
                                </div>
                                <div class="col-md-3 no-padding">
                                    <div class="form-group">
                                        <label class="col-md-12" for="to">To :</label>
                                        <div class="col-md-12">
                                            {{Form::text('to',date('d-m-Y'),['class'=>'form-control datepicker'])}}
                                        </div>
                                    </div>                                    
                                </div>
                                <div class="col-md-2 no-padding">
                            	    <div class="form-group">
                                        <label class="col-md-12" for="submit">&nbsp;</label>
                                        <div class="col-md-12">
                                            <button class="btn btn-success">Submit</button>
                                        </div>
                                    </div>                                    
                                </div>
                        {{Form::close()}}
                            <div class="col-md-12">
                                <br>
                                <hr class="min">
                            </div>
                        @if(isset($client))
                        @if(count($sales)>0)
                        {!! Form::open(array('route' => 'inventory-return.store','class'=>'form-horizontal author_form','method'=>'POST','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                        <div id="print_body" style="width: 100%;overflow: hidden; padding: 10px 20px;">
                          @include('pad.header')
                            <table width="100%">
                                <tr>
                                    <td><b>Organization Name : </b> <? echo $client->company_name ?></td>
                                    <td><b>Mobile : </b> <? echo $client->mobile_no ?></td>
                                    <td><b>Address : </b> <? echo $client->address ?></td>
                                    <td><b>Email : </b> <? echo $client->email_id ?></td>
                                </tr>
                            </table>
                            <br>
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="success">
                                        <th width="5%">SL</th>
                                        <th>Invoice ID</th>
                                        <th>Date</th>
                                        <th>Total Amount</th>
                                        <th>Paid Amount</th>
                                        <th>Due</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <? 
                                $i=0;
                                ?>
                                @foreach($sales as $data)
                                <? 
                                $i++;
                                ?>
                                <tr>
                                    <td>{{$i}}</td>
                                    <td><a href='{{URL::to("inventory-sales-invoice/$data->invoice_id")}}'>{{$data->invoice_id}}</a> </td>
                                    <td>{{$data->date}}</td>
                                    <td>{{round($data->total_amount,3)}}
                                    </td>
                                    <td>{{round($data->paid_amount,3)}}</td>
                                    <td>{{round($data->total_amount-$data->paid_amount,3)}}</td>
                                    <td>
                                        <a href='{{URL::to("inventory-return/$data->id")}}' class="btn btn-xs btn-info"> <i class="fa fa-eye"></i></a>
                                    </td>
                                </tr>
                                <input type="hidden" name="fk_sales_id[]" value="{{$data->id}}">
                                <input type="hidden" name="sales_last_due[]" value="{{$data->total_amount-$data->paid_amount}}">
                                @endforeach
                               
                            </tbody>
                        </table>
                        <div class="printFooter" style="overflow: hidden;width: 100%;">
                           @include('pad.footer')
                       </div>
                        </div><!-- / print-body -->
                      
                        <input type="hidden" name="fk_client_id" value="{{$client->id}}">
                        <div class="col-md-6"></div>
                        <div class="col-md-6"></div>
                        {{Form::close()}}
                        @else
                        <table width="100%">
                            <tr>
                                <td><b>Name : </b> <? echo $client->client_name ?></td>
                                <td><b>Mobile : </b> <? echo $client->mobile_no ?></td>
                                <td><b>Address : </b> <? echo $client->address ?></td>
                                <td><b>Email : </b> <? echo $client->email_id ?></td>
                            </tr>
                        </table>
                        <h2 class="text-center text-success">Here has no invoice.</h2>
                        @endif
                        @endif
                        </div>
                    </div>
			    </div>
			</div>
		</div>
		<!-- end #content -->
		
    @endsection
    @section('script')

<script src="{{asset('public/custom_js/printThis.js')}}"></script>
<script type="text/javascript">
    $('#amountPaid').on('change keyup blur',function(){
        var total=$('#subTotal').val();
        var paid =$(this).val();
        $('#amountDue').val(total-paid);
    })
    function printPage(id){
        $('#'+id).printThis();
    }
    /*function loadDue(id){
        window.location='{{URL::to("/inventory-return")}}/'+id;
    }*/
</script>
@endsection
