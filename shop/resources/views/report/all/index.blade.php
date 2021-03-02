
@extends('layout.app')
	@section('content')
    <style type="text/css">
        .transition_cul_section{margin-left: 0 !important; margin-right: 0 !important;}
        .filter_info{display: none;}
        .company_header{display: none;}
        .companyFooter{display: none;}
        @media print {
            @page {
                    size: auto;   /* auto is the initial value */
                    margin: 5mm;  /* this affects the margin in the printer settings */
                }
            .filter_info{display: block;}
            .company_header{display: block;}
            .companyFooter{display: block;}
            .invoice_top{display: block;}
            .print_footer{display: block;}
            .panel-heading-btn {display: none;}
            .report_filler {display: none;}
            .panel-title {display: none;}
            .printbtn {display: none;}
            .print_body{padding-bottom: 100px;}
            .col-md-6{width: 50%;float: left;padding: 5px;overflow: hidden;}
            .col-md-12{width:100%;overflow: hidden;}
            .div{width: 100%;overflow: hidden;}
            .print_footer {
              font-size: 9px;
              color: #f00;
              text-align: center;
            }

           
        }
    </style>
	<!-- begin #content -->
	<div id="content" class="content">
		
		<div class="row">
		    <div class="col-md-12">
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                    <button class="btn btn-xs btn-info pull-right printbtn" onclick="printPage('print_body')">Print</button>
                        <h4 class="panel-title">All Reports </h4>
                    </div>
                    <div class="panel-body">
                        <!-- <form method="post"> -->
                        	<form action="{{URL::to('report-deposit')}}" method="GET">
                            <div class="report_filler">
                                <div class="row">
                                @if(Auth::user()->isRole('administrator'))
                                <div class="form-group col-md-3 no-padding">
                                    <label class="control-label col-md-12">Select Branch :</label>
                                    <div class="col-md-12">
                                        {{Form::select('branch',$branch,'',['class'=>'form-control','placeholder'=>'All Branch','id'=>'branch'])}}
                                    </div>
                                </div>
                                @endif
                                <div class="form-group col-md-3">
                                     <label class="control-label col-md-12" for="Date">Start Date* :</label>
                                    <div class="col-md-12">
                                        
                                        {{Form::date('start',date('Y-m-d'),['class'=>'form-control','placeholder'=>'Start Date'])}}
                                    </div>
                                </div>
                                <div class="form-group col-md-1">
                                    <label class="col-md-12"> &nbsp; </label>
                                    <div class="col-md-12 no_padding" >
                                    <input class="form-control text-center" type="text" value="TO" readonly>
                                        <!-- <b>TO</b> -->
                                    </div>
                                </div>
                                <div class="form-group col-md-3">
                                 <label class="control-label col-md-12" for="Date">End Date* :</label>
                                    <div class="col-md-12">
                                        {{Form::date('end',date('Y-m-d'),['class'=>'form-control','placeholder'=>'End Date'])}}
                                    </div>
                                </div>
                                <div class="form-group col-md-1">
                                 <label class="col-md-12" for="Date">&nbsp;</label>
                                       
                                    <div class="col-sm-12 ">

                                        <button type="submit" class="btn btn-success btn-bordred waves-effect w-md waves-light m-b-5">
                                            Confirm
                                        </button>
                                    </div>
                                </div>
                                

                            
                            </div> 
                        </div>
                    </form>
                        <!-- </form> -->
                        <div id="print_body">
                            
                        <div class="company_header">
                            @include('pad.header')
                        </div>
                        
                            <div id="show-report">
                                @if(isset($sales))
                                <div class="invoice-content">
                                    <div class="table-responsive">
                                    
                                    <div class="filter_info">
                                        <h3 align="center">Income &amp; Expense Reports <br> <small>{{$branchName}}</small> </h3>
                                        <table class="table table-bordered">
                                            <tr>
                                                 <td><b>From : </b> {{$filterData['start']}}</td>
                                                <td><b>To : </b> {{$filterData['start']}}</td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="div">
                                    <div class="col-md-6">
                                    <p>Income</p>
                                        <table class="table table-bordered padding5">
                                            <thead>
                                                <tr class="success">
                                                    <th>SL</th>
                                                    <th>Sector Name</th>
                                                    <th>Total</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                 <tr>
                                                    <td>1</td>
                                                    <td>Product Sales</td>
                                                    <td>{{round($sales->total_amount,3)}}</td>
                                                </tr>
                                            <? 
                                            $i=2;
                                            $totalAmount=0;
                                            $totalPaid=0;
                                             ?>
                                            @foreach($depositReports as $subReport)
                                            <?
                                            $totalAmount+=$subReport->total_amount;
                                            $totalPaid+=$subReport->total_paid;
                                            ?>
                                                <tr>
                                                    <td>{{$i++}}</td>
                                                    <td>{{$subReport->sub_category_name}}</td>
                                                    <td>{{$subReport->total_amount}}</td>
                                                </tr>
                                            @endforeach
                                            </tbody>
                                            <tfoot>
                                                <tr class="active">
                                                    <th>*</th>
                                                    <th class="text-right">Total = </th>
                                                    <th>{{round($totalAmount+$sales->total_amount,3)}}</th>
                                                </tr>
                                                
                                            </tfoot>
                                        </table>
                                    </div>
                                    <div class="col-md-6">
                                        <p>Expense</p>
                                        <table class="table table-bordered padding5">
                                            <thead>
                                                <tr class="success">
                                                    <th>SL</th>
                                                    <th>Sector Name</th>
                                                    <th>Total</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>1</td>
                                                    <td>Product Purchase</td>
                                                    <td>{{round($purchase->total_amount,3)}}</td>
                                                </tr>
                                                <tr>
                                                    <td>2</td>
                                                    <td>Total Salary</td>
                                                    <td>{{round($salary->total_amount,3)}}</td>
                                                </tr>
                                            <? 
                                            $i=3;
                                            $totalAmount=0;
                                            $totalPaid=0;
                                             ?>
                                            @foreach($paymentReports as $subReport)
                                            <?
                                            $totalAmount+=$subReport->total_amount;
                                            $totalPaid+=$subReport->total_paid;
                                            ?>
                                                <tr>
                                                    <td>{{$i++}}</td>
                                                    <td>{{$subReport->sub_category_name}}</td>
                                                    <td>{{$subReport->total_amount}}</td>
                                                </tr>
                                            @endforeach
                                            </tbody>
                                            <tfoot>
                                                <tr class="active">
                                                    <th>*</th>
                                                    <th class="text-right">Total = </th>
                                                    <th>{{round($totalAmount+$purchase->total_amount+$salary->total_amount,3)}}</th>
                                                </tr>
                                                
                                            </tfoot>
                                        </table>
                                    </div>
                                    </div>  
                                @if(Auth::user()->isRole('administrator'))
                                    <div class="col-md-12">
                                        <p style="width: 100%">Accoutn Balance</p>
                                        <table class="table table-bordered padding5">
                                            <thead>
                                                <tr class="success">
                                                    <th>SL</th>
                                                    <th>Account Name</th>
                                                    <th>Balance</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <? 
                                            $i=1;
                                            $totalAmount=0;
                                            $totalPaid=0;
                                             ?>
                                            @foreach($accountReports as $acReport)
                                            <?
                                            $totalAmount+=$acReport['balance'];
                                            ?>
                                                <tr>
                                                    <td>{{$i++}}</td>
                                                    <td>{{$acReport['account_name']}}</td>
                                                    <td>{{$acReport['balance']}}</td>
                                                </tr>
                                            @endforeach
                                            </tbody>
                                            <tfoot>
                                                <tr class="active">
                                                    <th>*</th>
                                                    <th class="text-right">Total = </th>
                                                    <th>{{$totalAmount}}</th>
                                                </tr>
                                                
                                            </tfoot>
                                        </table>
                                    </div>
                                @endif
                                    </div>
                                    
                                </div>
                                @endif
                            </div>
                        </div>
                    </div>
                </div>
		    </div>
		</div>
	</div>

	<!-- end #content -->
	
<script src="{{asset('public/plugins/jquery/jquery-1.9.1.min.js')}}"></script>        

<script type="text/javascript">
    
    $("#submit").click(function(){
            var _token = $("#_token").val();
            var form_date = $("#form_date").val();
            var to_date = $("#to_date").val();
            //alert(_token);

            $.ajax({
                url: "{{URL::to('/')}}"+'/deposit-report-generat',
                type: "GET",
                data: {
                        form_date:  form_date,
                        to_date:  to_date
                         },

                success: function(response){
                    //console.log(response);
                    $("#show-report").html(response);
                }
            });
        });
</script>

@endsection
@section('script')
<script src="{{asset('public/custom_js/printThis.js')}}"></script>
<script type="text/javascript">
    function printPage(id){
        $('#'+id).printThis();
    }
</script>
@endsection