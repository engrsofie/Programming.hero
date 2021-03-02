
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
                            @endif
                            	<a class="btn btn-info btn-xs" href="{{URL::to('/inventory-order-payment')}}">View All</a>
                                
                            </div>
                            <h4 class="panel-title">Supplier wise Payment</h4>
                        </div>
                        <div class="panel-body">
                            
                                <div class="col-md-7 col-md-offset-3">
                            	    <div class="form-group">
                                        <label class="col-md-4 control-label" for="Date">Select Organization * :</label>
                                        <div class="col-md-8">
                                        <? $id= isset($client)?$client->id:''?>
                                            {{Form::select('id',$clients,$id,['class'=>'form-control select','placeholder'=>'Select Organization','required' ,'onchange'=>'loadDue(this.value)'])}}
                                        </div>
                                    </div>                                    
                                </div>
                            <div class="col-md-12">
                                <hr>
                            </div>
                        @if(isset($client))
                        @if(count($allDue)>0)
                        {!! Form::open(array('route' => 'inventory-order-payment.store','class'=>'form-horizontal','method'=>'POST','role'=>'form','data-parsley-validate novalidate')) !!}
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
                                    </tr>
                                </thead>
                                <tbody>
                                <? 
                                $i=0; 
                                $total=0;
                                $paid=0;
                                $due=0;
                                ?>
                                @foreach($allDue as $data)
                                <? 
                                $i++;
                                 $total+=$data->total_amount;
                                 $paid+=$data->total_paid;
                                 $due+=($data->total_amount-$data->total_paid);
                                ?>
                                <tr>
                                    <td>{{$i}}</td>
                                    <td><a href='{{URL::to("inventory-product-add/$data->invoice_id")}}'>{{$data->invoice_id}}</a> </td>
                                    <td>{{$data->date}}</td>
                                    <td>{{round($data->total_amount,3)}}
                                    </td>
                                    <td>{{round($data->total_paid,3)}}</td>
                                    <td>{{round($data->total_amount-$data->total_paid,3)}}</td>
                                </tr>
                                <input type="hidden" name="fk_order_id[]" value="{{$data->id}}">
                                <input type="hidden" name="order_last_due[]" value="{{$data->total_amount-$data->total_paid}}">
                                @endforeach
                                <tr class="active">
                                    <th colspan="3" style="text-align: right;">Total = </th>
                                    <th>{{round($total,2)}}</th>
                                    <th>{{round($paid,2)}}</th>
                                    <th>{{round($due,2)}}</td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="printFooter" style="overflow: hidden;width: 100%;">
                           @include('pad.footer')
                       </div>
                        </div><!-- / print-body -->
                      
                        <input type="hidden" name="fk_supplier_id" value="{{$client->id}}">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="control-label col-md-4">Select Account : </label>
                                <div class="col-md-8">
                                    {{Form::select('fk_account_id',$account,'1',['class'=>'form-control'])}}
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4">Select Method : </label>
                                <div class="col-md-8">
                                    {{Form::select('fk_method_id',$method,'3',['class'=>'form-control'])}}
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4">Ref ID : </label>
                                <div class="col-md-8">
                                    <input type="text" class="form-control" name="ref_id" placeholder="Ref ID">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group aside_system">
                            <input type="hidden" name="total_amount" value="{{round($total,2)}}">
                                <label class="col-md-4">Payable Amount :</label>
                                <div class="input-group col-md-8">
                                    <div class="input-group-addon currency">৳</div>
                                    <input value="{{round($due,2)}}" class="form-control" name="last_due" id="subTotal" placeholder="Total Amount" readonly>
                                </div>
                            </div>
                            <div class="form-group aside_system">
                                <label class="col-md-4">Paid Amount :</label>
                                <div class="input-group col-md-8">
                                    <div class="input-group-addon currency">৳</div>
                                    <input value="0" type="number" min="0" step="any" class="form-control" name="paid" id="amountPaid" placeholder="Paid Amount" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;">
                                </div>
                            </div>
                            
                            <div class="form-group aside_system">
                                <label class="col-md-4">Amount Due :</label>
                                <div class="input-group col-md-8">
                                    <div class="input-group-addon currency">৳</div>
                                    <input value="{{round($due,2)}}" type="number" min="0" step="any" class="form-control amountDue"  id="amountDue" placeholder="Amount Due" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly >
                                </div>
                            </div>
                            <div class="form-group aside_system">
                                <label class=" col-md-4">Payment Date :</label>
                                <div class="input-group col-md-8">
                                   <input type="text" name="payment_date" class="form-control datepicker" value="{{date('d-m-Y')}}" required>
                                </div>
                            </div>
                            <div class="form-group aside_system">
                                <div class="input-group col-md-12">
                                  <button type="submit" class="btn btn-info pull-right">Submit Payment</button>
                                </div>
                            </div>
                            
                        </div>
                        {{Form::close()}}
                        @else
                        <table width="100%">
                            <tr>
                                <td><b>Name : </b> <? echo $client->company_name ?></td>
                                <td><b>Mobile : </b> <? echo $client->mobile_no ?></td>
                                <td><b>Address : </b> <? echo $client->address ?></td>
                                <td><b>Email : </b> <? echo $client->email_id ?></td>
                            </tr>
                        </table>
                        <h2 class="text-center text-success">This Company has no due.</h2>
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
    function loadDue(id){
        window.location='{{URL::to("/inventory-order-payment")}}/'+id;
    }
</script>
@endsection
