
	@extends('layout.app')
		@section('content')
		<!-- begin #content -->
		<div id="content" class="content">
			
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                            @if(isset($report))
                                <a href="javascript:;" onclick="printPage('print_body')" class="btn btn-xs btn-success"><i class="fa fa-print"></i> Print</a>
                            @else
                                <a class="btn btn-info btn-xs" href="{{URL::to('/inventory-supplier')}}">View All Supplier</a>
                            @endif

                                
                            </div>
                            <h4 class="panel-title">Supplier report</h4>
                        </div>
                        <div class="panel-body">
                            {!! Form::open(array('url' => 'inventory-supplier-report-show','class'=>'form-horizontal author_form','method'=>'GET','data-parsley-validate novalidate')) !!}
                        	    <div class="form-group col-md-4">
                                    <label class="col-md-12" for="Date">Select supplier * :</label>
                                    <div class="col-md-12">
                                    <? $id= isset($input)?$input['id']:''?>
                                        {{Form::select('id',$supplier,$id,['class'=>'form-control select','placeholder'=>'Select supplier','required'])}}
                                    </div>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="col-md-12" for="Date">Select Date * :</label>
                                    <div class="col-md-5">
                                        <input class="form-control" type="date" name="start_date" value="{{isset($input)?$input['start_date']:date('Y-m-d')}}" placeholder="date" data-parsley-required="true" />
                                    </div>

                                    <div class="col-md-2"><input readonly class="form-control text-center" value="TO"></div>

                                    <div class="col-md-5">
                                        <input class="form-control" type="date" name="end_date" value="{{isset($input)?$input['end_date']:date('Y-m-d')}}" placeholder="date" data-parsley-required="true" />
                                    </div>
                                </div>
                                
								<div class="form-group col-md-2">
									<label class="col-md-12">Click Here</label>
									<div class="col-md-12">
										<button type="submit" class="btn btn-primary">Submit</button>
									</div>
								</div>
                            {!! Form::close(); !!}
                            @if(isset($report))
                            <div class="col-md-12">
                                <hr>
                            </div>
                            <!-- Print Body -->
                            <div id="print_body" style="width: 100%;overflow: hidden; padding: 10px 20px;">
                            @include('pad.header')
                            <div id="customer_info" style="padding: 0 10px;">
                                <div class="row">
                                    <div class="invoiceInfo" style="width: 100%;">
                                        <p align="center"><b>Report : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<u>{{$input['start_date']}}</u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TO  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<u>{{$input['end_date']}}</u></b></p>
                                        <table width="100%">
                                            <tr>
                                                <td><b>Company Name : </b> <? echo $supplierInfo->company_name ?></td>
                                                <td><b>Mobile : </b> <? echo $supplierInfo->mobile_no ?></td>
                                                <td><b>Address : </b> <? echo $supplierInfo->address ?></td>
                                                <td><b>Email : </b> <? echo $supplierInfo->email_id ?></td>
                                            </tr>
                                        </table>
                                        <div>
                                        <br>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                            <div class="invoice-content">
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th width="5%">SL</th>
                                                <th>Date</th>
                                                <th>Invoice ID</th>
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
                                        @foreach($report as $data)
                                        <? 
                                        $i++;
                                         $total+=$data->total_amount;
                                         $paid+=$data->total_paid;
                                         $due+=($data->total_amount-$data->total_paid);
                                        ?>
                                        <tr>
                                            <td>{{$i}}</td>
                                            <td>{{$data->date}}</td>
                                            <td><a href='{{URL::to("inventory-product-add/$data->inventory_order_id")}}' target="_blank">{{$data->inventory_order_id}}</a> </td>
                                            <td>{{round($data->total_amount,2)}}
                                            </td>
                                            <td>{{round($data->total_paid,2)}}</td>
                                            <td>{{round($data->total_amount-$data->total_paid,2)}}</td>
                                        </tr>
                                        @endforeach
                                        <tr class="active">
                                            <td colspan="3" style="text-align: right;">Total = </td>
                                            <td>{{$total}}</td>
                                            <td>{{$paid}}</td>
                                            <td>{{$due}}</td>
                                        </tr>
                                        @if($prev->total_amount>0)
                                        <tr>
                                            <td colspan="3" style="text-align: right;">Previous Transaction </td>
                                            <td>{{round($prev->total_amount,2)}}</td>
                                            <td>{{round($prev->total_paid,2)}}</td>
                                            <td>{{round($prev->total_amount-$prev->total_paid,2)}}</td>
                                        </tr>
                                        @endif
                                        @if($next->total_amount>0)
                                        <tr>
                                            <td colspan="3" style="text-align: right;">After Transaction </td>
                                            <td>{{round($next->total_amount,2)}}</td>
                                            <td>{{round($next->total_paid,2)}}</td>
                                            <td>{{round($next->total_amount-$next->total_paid,2)}}</td>
                                        </tr>
                                        @endif
                                        <tr class="success">
                                            <th colspan="3" style="text-align: right;">Total Amount = </th>
                                            <th>{{round($prev->total_amount+$total+$next->total_amount,2)}}</th>
                                            <th>{{round($prev->total_paid+$paid+$next->total_paid,2)}}</th>
                                            <th>{{round($next->total_amount-$next->total_paid,2)+round($prev->total_amount-$prev->total_paid,2)+$due}}</th>
                                        </tr>
                                        </tbody>

                                    </table>
                                </div>
                            </div>

                            <div class="printFooter" style="overflow: hidden;
                    width: 100%;position: fixed;bottom: 0;left: 0;">
                            <style type="text/css">
                                .print-footer .sign{display: none;}
                            </style>
                                   @include('pad.footer')
                            </div>
                            </div>
                            <!-- /Print Body -->
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
    function printPage(id){
        $('#'+id).printThis();
    }
</script>
@endsection