@extends('layout.app')
	@section('content')
    <style type="text/css">
        .no_padding{padding: 0 !important;}
        .filter_info{display: none;}
        .invoice_top{display: block;position: fixed; top: 0;left: 0;width: 100%;}
        .print_footer{position: fixed; bottom: 0;left: 0;width: 100%;display: none;}
            .print_body{padding-bottom: 100px;}

        @media print {
            @page {
                    size: auto;   /* auto is the initial value */
                    margin: 5mm;  /* this affects the margin in the printer settings */
                }
            .filter_info{display: block;}
            .invoice_top{display: block;}
            .print_footer{display: block;}
            .panel-heading-btn {display: none;}
            .report_filler {display: none;}
            .panel-title {display: none;}
            .printbtn {display: none;}
            .print_body{padding-bottom: 100px;}
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
                        <div class="panel-heading-btn">
                            <a href="javascript:;" onclick="printPage('print_body')" class="printbtn btn btn-xs btn-success pull-right"><i class="fa fa-print m-r-5"></i> Print</a>
                        </div>
                        <h4 class="panel-title">Add Purchase Report </h4>
                    </div>
                    <div class="panel-body print_body">
                        <form action="{{URL::to('inventory-report-purchase')}}" method="GET">
                        
                        <div class="report_filler">
                            <div class="row">
                                <div class="form-group col-md-2 no-padding">
                                     <label class="control-label col-md-12" for="Date">Start Date* :</label>
                                    <div class="col-md-12">
                                        
                                        {{Form::date('start',date('Y-m-d'),['class'=>'form-control','placeholder'=>'Start Time'])}}
                                    </div>
                                </div>
                                <div class="form-group col-md-1">
                                    <label class="col-md-12"> &nbsp; </label>
                                    <div class="col-md-12 no_padding" >
                                    <input class="form-control text-center" type="text" value="TO" readonly>
                                        <!-- <b>TO</b> -->
                                    </div>
                                </div>
                                <div class="form-group col-md-2 no-padding">
                                 <label class="control-label col-md-12" for="Date">End Date* :</label>
                                    <div class="col-md-12">
                                        {{Form::date('end',date('Y-m-d'),['class'=>'form-control','placeholder'=>'End Time'])}}
                                    </div>
                                </div>
                                 @if(Auth::user()->isRole('administrator'))
                                <div class="form-group col-md-3 no-padding">
                                    <label class="col-md-12">Select Branch :</label>
                                    <div class="col-md-12">
                                        {{Form::select('branch',$branch,'',['class'=>'form-control','placeholder'=>'All Branch','id'=>'branch'])}}
                                    </div>
                                </div>
                                @endif
                                <div class="form-group col-md-2 no-padding">
                                    <label class="control-label col-md-12">Select Category :</label>
                                    <div class="col-md-12">
                                        {{Form::select('category',$category,'',['class'=>'form-control','placeholder'=>'All','id'=>'category'])}} 
                                    </div>
                                </div>
                                <div class="form-group col-md-1">
                                 <label class="col-md-12" for="Date">&nbsp;</label>
                                       
                                    <div class="col-sm-12 ">

                                        <button type="submit" id="submit" class="btn btn-success btn-bordred waves-effect w-md waves-light m-b-5">
                                            Confirm
                                        </button>
                                    </div>
                                </div>
                                

                            
                            </div> 
                        </div>
                        </form>
                        <br>
                        <div id="print_body">
                            @include('pad.header')
                            <style type="text/css">
                                @page {
                                  margin-bottom: 100px;
                                }
                            </style>
                            <div class="report_result" id="load_result">
                            <div class="filter_infos">
                            <h3 align="center">Purchase Report</h3>
                                <table class="table table-bordered">
                                    <tr>
                                        <td><b>Start Date:</b> {{isset($filterData['start'])?$filterData['start']:date('d-M-Y')}}</td>
                                        <td><b>End Date:</b> {{isset($filterData['end'])?$filterData['end']:date('d-M-Y')}}</td>
                                        <td><b>Category:</b> {{isset($filterData['category'])?$filterData['category']:'All'}}</td>
                                        <td><b>Branch:</b> {{isset($filterData['branch'])?$filterData['branch']:'All'}}</td>
                                    </tr>
                                </table>
                            </div>
        
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="success">
                                        <th>Sl</th>
                                        <th>Product Name</th>
                                        <th>Model</th>
                                        <th>Category Name</th>
                                        <th>Branch</th>
                                        <th>QTY</th>
                                        <th>Total Amount</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <? 
                                $i=0;
                                $total_qty=0;
                                $total_amount=0;
                                ?>
                                @foreach($allData as $data)
                                <? 
                                $i++;
                                $total_qty=$total_qty+$data->total_qty;
                                $total_amount=$total_amount+$data->total_amount;
                                ?>
                                <tr>
                                    <td>{{$i}}</td>
                                    <td>{{$data->product_name}}</td>
                                    <td>{{$data->model_name}}</td>
                                    <td>{{$data->category_name}}</td>
                                    <td>{{$data->branch_name}}</td>
                                    <td>{{$data->total_qty}}</td>
                                    <td>{{round($data->total_amount,2)}}</td>
                                </tr>
                                @endforeach
                                <tr class="active">
                                    <th>*</th>
                                    <th style="text-align: right" colspan="4">Total = </th>
                                    <th>{{$total_qty}}</th>
                                    <th>{{round($total_amount,2)}}</th>
                                    
                                </tr>
                                </tbody>
                                
                            </table>

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