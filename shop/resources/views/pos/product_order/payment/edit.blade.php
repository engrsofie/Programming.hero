@extends('layout.app')
	@section('content')
		<!-- begin #content -->
		<div id="content" class="content">
			
			<!-- begin invoice -->
			<div class="invoice">
                <div class="invoice-company">
                    <span class="pull-right hidden-print">
                    <a href="{{URL::to('inventory-product-sales/create')}}" class="btn btn-sm btn-info m-b-10"><i class="fa fa-plus m-r-5"></i> Created New Order </a>
                    </span>
                    
                    
                    <!-- Invoice No. : {{$getInvoiceData->invoice_id}} --> 
                </div>
                <div id="print_body" style="width: 100%;overflow: hidden; padding: 10px 20px;">

                        <div class="customerInfo" style="width: 60%;float: left;">
                            <table class="table table-bordered">
                                <tr>
                                    <td><b>Organization Name : </b> <? echo $getInvoiceData->company_name ?></td>
                                    <td><b>Mobile : </b> <? echo $getInvoiceData->mobile_no ?></td>
                                </tr>
                                <tr>
                                    <td><b>Address : </b> <? echo $getInvoiceData->address ?></td>
                                    <td><b>Email : </b> <? echo $getInvoiceData->email_id ?></td>
                                </tr>
                            </table>
                        </div>
                        <div class="invoiceInfo" style="width: 40%;float: left;">
                            <table class="table table-bordered">
                                <tr>
                                    <th>Invoice #: </th>
                                    <th>{{$getInvoiceData->invoice_id}} </th>
                                </tr>
                                 <tr>
                                    <td>Payment Date : </td>
                                    <td>{{date('d-m-Y',strtotime($getInvoiceData->payment_date))}}</td>
                                </tr>
                            </table>
                        </div>
                {!! Form::open(array('route' =>[ 'inventory-sales-payment.update',$getInvoiceData->id],'class'=>'form-horizontal author_form','method'=>'PUT','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                <div class="invoice-content">
                    <div class="">
                        <table class="table table-bordered table-responsive">
                            <thead>
                                <tr>
                                    <th width="5%">SL</th>
                                    <th>Order ID</th>
                                    <th>Total Amount</th>
                                    <th>Prev Due</th>
                                    <th>Paid</th>
                                    <th>Due</th>
                                </tr>
                            </thead>
                            <tbody>
                            
                            <? $i=0; ?>
                                @if(isset($getProductData))
                                @foreach($getProductData as $data)
                                <? $i++; ?>
                                <input type="hidden" name="fk_sales_id[]" value="{{$data->fk_sales_id}}">
                                <input type="hidden" name="item_id[]" value="{{$data->id}}">
                                <input type="hidden" name="sales_last_due[]" value="{{$data->sales_last_due}}">
                                <input type="hidden" name="sales_paid[]" value="{{$data->sales_paid}}">
                                <tr>
                                    <td>{{$i}}</td>
                                    <td>{{$data->invoice_id}}</td>
                                    <td>{{round($data->total_amount,2)}}</td>
                                    <td>{{round($data->sales_last_due,2)}}</td>
                                    <td>{{round($data->sales_paid,2)}}</td>
                                    <td>{{round($data->sales_last_due-$data->sales_paid,2)}} </td>
                                    
                                </tr>
                                @endforeach

                                @endif
                                <tr class="success">
                                    <th colspan="2" style="text-align: right;">Total=</th>
                                    <th>{{round($getInvoiceData->total_amount,2)}}</th>
                                    <th>{{round($getInvoiceData->last_due,2)}}</th>
                                    <th>{{round($getInvoiceData->paid,2)}}</th>
                                    <th>{{round($getInvoiceData->last_due-$getInvoiceData->paid,2)}}</th>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="control-label col-md-4">Select Account : </label>
                                <div class="col-md-8">
                                    {{Form::select('fk_account_id',$account,$getInvoiceData->fk_account_id,['class'=>'form-control'])}}
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4">Select Method : </label>
                                <div class="col-md-8">
                                    {{Form::select('fk_method_id',$method,$getInvoiceData->fk_method_id,['class'=>'form-control'])}}
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4">Ref ID : </label>
                                <div class="col-md-8">
                                    <input type="text" class="form-control" name="ref_id" placeholder="Ref ID" value="{{$getInvoiceData->ref_id}}">
                                </div>
                            </div>
                            
                        </div>
                        <div class="col-md-6">
                            <div class="form-group aside_system">
                                <label class="col-md-4">Payable Amount :</label>
                                <div class="input-group col-md-8">
                                    <div class="input-group-addon currency">৳</div>
                                    <input value="{{round($getInvoiceData->last_due,2)}}" class="form-control" name="last_due" id="subTotal" placeholder="Total Amount" readonly>
                                </div>
                            </div>
                            <div class="form-group aside_system">
                                <label class="col-md-4">Paid Amount :</label>
                                <div class="input-group col-md-8">
                                    <div class="input-group-addon currency">৳</div>
                                    <input value="{{round($getInvoiceData->paid,2)}}" type="number" min="0" step="any" class="form-control" name="paid" id="amountPaid" placeholder="Paid Amount" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;">
                                </div>
                            </div>
                            
                            <div class="form-group aside_system">
                                <label class="col-md-4">Amount Due :</label>
                                <div class="input-group col-md-8">
                                    <div class="input-group-addon currency">৳</div>
                                    <input value="{{round($getInvoiceData->last_due-$getInvoiceData->paid,2)}}" type="number" min="0" step="any" class="form-control amountDue"  id="amountDue" placeholder="Amount Due" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly >
                                </div>
                            </div>
                            <div class="form-group aside_system">
                                <label class=" col-md-4">Payment Date :</label>
                                <div class="input-group col-md-8">
                                   <input type="text" name="payment_date" class="form-control datepicker" value="{{date('d-m-Y',strtotime($getInvoiceData->payment_date))}}" required>
                                </div>
                            </div>
                            <div class="form-group aside_system">
                                <div class="input-group col-md-8 col-md-offset-4">
                                  <button type="submit" class="form-control btn btn-info pull-right">Submit Payment</button>
                                </div>
                            </div>
                            
                        </div>
                </div>

                {{Form::close()}}

               </div>
                
            </div>

			<!-- end invoice -->
		</div>
		<!-- end #content -->
        
    
@endsection
@section('script')
<script type="text/javascript">
    $('#amountPaid').on('change keyup blur',function(){
        var total=$('#subTotal').val();
        var paid =$(this).val();
        $('#amountDue').val(total-paid);
    })
</script>
@endsection