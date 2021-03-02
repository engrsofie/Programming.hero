
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
                            	<a class="btn btn-info btn-xs" href="{{URL::to('/inventory-client')}}">View All Clients</a>
                            @endif
                                
                            </div>
                            <h4 class="panel-title">Client account report</h4>
                        </div>
                        <div class="panel-body">
                            {!! Form::open(array('url' => 'inventory-client-report-show','class'=>'form-horizontal author_form','method'=>'GET','data-parsley-validate novalidate')) !!}
                                @if(Auth::user()->isRole('administrator'))
                                <? $branchId= isset($input['branch'])?$input['branch']:''?>
                                <div class="form-group col-md-3 no-padding">
                                    <label class="col-md-12">Select Branch :</label>
                                    <div class="col-md-12">
                                        {{Form::select('branch',$branch,$branchId,['class'=>'form-control','placeholder'=>'All Branch','onchange'=>'loadCLient(this.value)','id'=>'branch'])}}
                                    </div>
                                </div>
                                @else
                                <input type="hidden" id='branch' value="{{Auth::user()->fk_branch_id}}">
                                @endif
                        	    <div class="form-group col-md-3">
                                    <label class="col-md-12" for="Date">Select client * :</label>
                                    <div class="col-md-12" id="loadCLient">
                                    <? $id= isset($input)?$input['id']:''?>
                                        {{Form::select('id',$clients,$id,['class'=>'form-control select','placeholder'=>'Select client','required'])}}
                                    </div>
                                </div>
                                <div class="form-group col-md-6 no-padding">
                                    <label class="col-md-12" for="Date">Select Date * :</label>
                                    <div class="col-md-5">
                                        <input class="form-control" type="date" name="start_date" value="{{isset($input)?$input['start_date']:date('Y-m-d')}}" placeholder="date" data-parsley-required="true" />
                                    </div>

                                    <div class="col-md-2 no-padding"><input readonly class="form-control text-center" value="TO"></div>

                                    <div class="col-md-5">
                                        <input class="form-control" type="date" name="end_date" value="{{isset($input)?$input['end_date']:date('Y-m-d')}}" placeholder="date" data-parsley-required="true" />
                                    </div>
                                </div>
                                
                                <div class="form-group col-md-1">
                                    <label class="col-md-12">&nbsp;</label>
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
                                                <td><b>Name : </b> <? echo $client->client_name ?></td>
                                                <td><b>Mobile : </b> <? echo $client->mobile_no ?></td>
                                                <td><b>Address : </b> <? echo $client->address ?></td>
                                                <td><b>Email : </b> <? echo $client->email_id ?></td>
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
                                    <table class="table table-bordered smallHr">
                                        <thead>
                                            <tr>
                                                <th width="5%">SL</th>
                                                <th>Invoice ID</th>
                                                <th width="20%">Product</th>
                                                <th width="5%">Qty</th>
                                                <th width="10%">Price</th>
                                                <th width="7%">Comm(%)</th>
                                                <th width="10%">Sub Total</th>
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
                                         $paid+=$data->paid_amount;
                                         $due+=($data->total_amount-$data->paid_amount);
                                        ?>
                                        <tr>
                                            <td>{{$i}}</td>
                                            <td>#{{$data->invoice_id}}<hr>{{$data->date}}</td>
                                            <td><? echo$data->product ?></td>
                                            <td><? echo$data->qty ?></td>
                                            <td><? echo$data->price ?></td>
                                            <td><? echo$data->commission ?></td>
                                            <td><? echo$data->subTotal ?></td>
                                            <td>{{round($data->total_amount,2)}}
                                            </td>
                                            <td>{{round($data->paid_amount,2)}}</td>
                                            <td>{{round($data->total_amount-$data->paid_amount,2)}}</td>
                                        </tr>
                                        
                                        @endforeach
                                        <tr class="active">
                                            <td colspan="7" style="text-align: right;">Total = </td>
                                            <td>{{$total}}</td>
                                            <td>{{$paid}}</td>
                                            <td>{{$due}}</td>
                                        </tr>
                                        @if($prev->total_amount>0)
                                        <tr>
                                            <td colspan="7" style="text-align: right;">Previous Transaction </td>
                                            <td>{{round($prev->total_amount,2)}}</td>
                                            <td>{{round($prev->paid_amount,2)}}</td>
                                            <td>{{round($prev->total_amount-$prev->paid_amount,2)}}</td>
                                        </tr>
                                        @endif
                                        @if($next->total_amount>0)
                                        <tr>
                                            <td colspan="7" style="text-align: right;">After Transaction </td>
                                            <td>{{round($next->total_amount,2)}}</td>
                                            <td>{{round($next->paid_amount,2)}}</td>
                                            <td>{{round($next->total_amount-$next->paid_amount,2)}}</td>
                                        </tr>
                                        @endif
                                        <tr class="success">
                                            <th colspan="7" style="text-align: right;">Total Amount = </th>
                                            <th>{{round($prev->total_amount+$total+$next->total_amount,2)}}</th>
                                            <th>{{round($prev->paid_amount+$paid+$next->paid_amount,2)}}</th>
                                            <th>{{round($next->total_amount-$next->paid_amount,2)+round($prev->total_amount-$prev->paid_amount,2)+$due}}</th>
                                        </tr>
                                        </tbody>

                                    </table>
                                </div>
                            </div>

                            <div class="printFooter" style="overflow: hidden;
                    width: 100%;">
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
     function loadCLient(id){
        if(id.length==0){
            id=0;
        }
        $('#loadCLient').load('{{URL::to("report-client-load")}}/'+id);
    }
</script>
@endsection
