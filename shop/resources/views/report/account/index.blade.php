
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
                            <h4 class="panel-title">Account report</h4>
                        </div>
                        <div class="panel-body">
                            {!! Form::open(array('url' => 'inventory-account-report-show','class'=>'form-horizontal author_form','method'=>'GET','data-parsley-validate novalidate')) !!}
                        	    <div class="form-group col-md-3">
                                    <label class="col-md-12" for="Date">Select Account * :</label>
                                    <div class="col-md-12">
                                    <? $id= isset($input)?$input['id']:''?>
                                        {{Form::select('id',$accounts,$id,['class'=>'form-control select','placeholder'=>'Select account','required'])}}
                                    </div>
                                </div>
                                <? 
                                $branchId='';
                                if(isset($input['branch'])){
                                    $branchId=$input['branch'];
                                }
                                $clientId='';
                                if(isset($input['client'])){
                                    $clientId=$input['client'];
                                }
                                 ?>
                                @if(Auth::user()->isRole('administrator'))
                                <div class="form-group col-md-3 no-padding">
                                    <label class="col-md-12">Select Branch :</label>
                                    <div class="col-md-12">
                                        {{Form::select('fk_branch_id',$branch,$branchId,['class'=>'form-control','placeholder'=>'All Branch','onchange'=>'loadCLient(this.value)','id'=>'branch'])}}
                                    </div>
                                </div>
                                @else
                                <input type="hidden" name="fk_branch_id" id='branch' value="{{Auth::user()->fk_branch_id}}">
                                @endif
                                <div class="form-group col-md-5">
                                    <label class="col-md-12" for="Date">Select Date * :</label>
                                    <div class="col-md-5 no-padding">
                                        <input class="form-control" type="date" name="start_date" value="{{isset($input)?$input['start_date']:date('Y-m-d')}}" placeholder="date" data-parsley-required="true" />
                                    </div>

                                    <div class="col-md-2 no-padding"><input readonly class="form-control text-center" value="TO"></div>

                                    <div class="col-md-5 no-padding">
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
                                                <td><b>Account Name : </b> <? echo $accountInfo->account_name ?></td>
                                            </tr>
                                        </table>
                                        <div>
                                        <br>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                            <div class="invoice-content col-md-12">
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th width="5%">SL</th>
                                                <th>Date</th>
                                                <th>Invoice ID</th>
                                                <th>Particular</th>
                                                <th>Cash In</th>
                                                <th>Cash Out</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr class="active">
                                                <th>1</th>
                                                <th>{{$input['start_date']}}</th>
                                                <th>---</th>
                                                <th>Opening Balance</th>
                                                <th>{{$balance}}</th>
                                                <th></th>
                                                <!-- <td>@if($balance>0) {{$balance}} @endif</td> -->
                                                <!-- <td>@if($balance<0) {{$balance}} @endif</td> -->
                                            </tr>
                                        <? 
                                        $i=1; 
                                        $total=$balance;
                                        $cashOut=0;
                                        ?>
                                        @foreach($cash as $data)
                                        <? 
                                        $i++;
                                        $paid_amount=0;
                                        $total_paid=0;
                                        if(isset($data['paid_amount'])){
                                         $total+=$data['paid_amount'];
                                         $paid_amount=$data['paid_amount'];
                                        }
                                        if(isset($data['total_paid'])){
                                         $cashOut+=$data['total_paid'];
                                         $total_paid=$data['total_paid'];
                                        }
                                        ?>
                                        <tr>
                                            <td>{{$i}}</td>
                                            <td>{{$data['date']}}</td>
                                            <td>
                                            @if(isset($data['paid_amount']))
                                                <a href='{{URL::to("inventory-sales-invoice/".$data['invoice_id'])}}' target="_blank">{{$data['invoice_id']}}</a>
                                            @else
                                                <a href='{{URL::to("inventory-product-add/".$data['invoice_id'])}}' target="_blank">{{$data['invoice_id']}}</a>
                                            @endif
                                            </td>
                                            <td>@if(isset($data['paid_amount'])) Sales @else Purchase @endif</td>
                                            <td>{{round($paid_amount,2)}}</td>
                                            <td>{{round($total_paid,2)}}</td>
                                        </tr>
                                        @endforeach
                                        <? 
                                     ?>
                                    @foreach($deposit as $dep)
                                    <? 
                                    $i++;
                                    $total+=$dep->total_amount;
                                    ?>
                                        <tr>
                                            <td>{{$i}}</td>
                                            <td>---</td>
                                            <td>Deposit</td>
                                            <td>{{$dep->sub_category_name}}</td>
                                            <td>{{round($dep->total_amount,3)}}</td>
                                            <td></td>
                                        </tr>
                                    @endforeach
                                    <? 
                                        $total_payment=0;
                                        ?>
                                        @foreach($payment as $pay)
                                        <? 
                                        $i++;
                                        $cashOut+=$pay->total_amount;
                                         ?>
                                            <tr>
                                                <td>{{$i}}</td>
                                                <td>---</td>
                                                <td>Payment</td>
                                                <td>{{$pay->sub_category_name}}</td>
                                                <td></td>
                                                <td>{{round($pay->total_amount,3)}}</td>
                                            </tr>
                                        @endforeach
                                    @if($salary->total_amount>0)
                                        <tr>
                                            <? $i++;
                                            $cashOut+=$salary->total_amount;
                                             ?>
                                            <td>{{$i}}</td>
                                            <td>---</td>
                                            <td>---</td>
                                            <td>Total Salary</td>
                                            <td></td>
                                            <td>{{round($salary->total_amount,3)}}</td>
                                        </tr>
                                    @endif
                                        
                                        <tr class="active">
                                            <th colspan="4" style="text-align: right;">Total = </th>
                                            <th>{{$total}}</th>
                                            <th>{{$cashOut}}</th>
                                        </tr>
                                        <tr class="active">
                                            <th colspan="5" style="text-align: right;">Accoutn Balance= </th>
                                            <th>{{$total-$cashOut}}</th>
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