
	@extends('layout.app')
		@section('content')
		<!-- begin #content -->
        
		<div id="content" class="content">
			
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                            	<a href="javascript:;" onclick="printPage('print_body')" class="printbtn btn btn-sm btn-success m-b-10"><i class="fa fa-print m-r-5"></i> Print</a>
                                
                            </div>
                            <h4 class="panel-title">CLient wise report</h4>
                        </div>
                        <div class="panel-body">
                            <div id="print_body" style="width: 100%;overflow: hidden; padding: 10px 20px;">
                            @include('pad.header')
                            <div id="customer_info" style="padding: 0 10px;">
                                <div class="row">
                                    <div class="invoiceInfo" style="width: 100%;">
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
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
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
                                        @foreach($sales as $data)
                                        <? 
                                        $i++;
                                         $total+=$data->total_amount;
                                         $paid+=$data->paid_amount;
                                         $due+=($data->total_amount-$data->paid_amount);
                                        ?>
                                        <tr>
                                            <td>{{$i}}</td>
                                            <td>{{$data->invoice_id}}</td>
                                            <td>{{$data->date}}</td>
                                            <td>{{round($data->total_amount,2)}}
                                            </td>
                                            <td>{{round($data->paid_amount,2)}}</td>
                                            <td>{{round($data->total_amount-$data->paid_amount,2)}}</td>
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
                                            <td>{{round($prev->paid_amount,2)}}</td>
                                            <td>{{round($prev->total_amount-$prev->paid_amount,2)}}</td>
                                        </tr>
                                        @endif
                                        @if($next->total_amount>0)
                                        <tr>
                                            <td colspan="3" style="text-align: right;">After Transaction </td>
                                            <td>{{round($next->total_amount,2)}}</td>
                                            <td>{{round($next->paid_amount,2)}}</td>
                                            <td>{{round($next->total_amount-$next->paid_amount,2)}}</td>
                                        </tr>
                                        @endif
                                        <tr class="success">
                                            <th colspan="3" style="text-align: right;">Total Amount = </th>
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