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
                        <h4 class="panel-title">Payable Due</h4>
                    </div>
                    <div class="panel-body print_body">
                        <div class="report_filler">
                            <div class="row">
                                <div class="form-group col-md-3">
                                     <label class="control-label col-md-12" for="Date">Start Date* :</label>
                                    <div class="col-md-12">
                                        <input class="form-control" type="date"  name="start_date" value="<?php echo date('Y-m-d'); ?>" data-parsley-required="true" id="start" />
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
                                        <input class="form-control" type="date"  name="end_date" value="<?php echo date('Y-m-d'); ?>" data-parsley-required="true"  id="end" />
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
                        <br>
                        <div id="print_body">
                            @include('pad.header')
                            <style type="text/css">
                                @page {
                                  margin-bottom: 100px;
                                }
                            </style>
                            <div class="report_result" id="load_result">
                            <div class="filter_info">
                            <h3 align="center">Payable Due</h3>
                                <table class="table table-bordered">
                                    <tr>
                                        <td><b>Start Date:</b> {{date('d-M-Y')}}</td>
                                        <td><b>End Date:</b> {{date('d-M-Y')}}</td>
                                    </tr>
                                </table>
                            </div>
        
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="success">
                                        <th>Sl</th>
                                        <th>Supplier Name</th>
                                        <th>Total Amount</th>
                                        <th>Total Due</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <? 
                                $i=0;
                                $total_due=0;
                                $total_amount=0;
                                ?>
                                @foreach($allData as $data)
                                <? 
                                $i++;
                                $due=$data->total_amount-$data->paid_amount;
                                $total_due=$total_due+$due;
                                $total_amount=$total_amount+$data->total_amount;

                                ?>
                                <tr>
                                    <td>{{$i}}</td>
                                    <td>{{$data->company_name}}</td>
                                    <td>{{round($data->total_amount,3)}}</td>
                                    <td>{{round($due,3)}}</td>
                                </tr>
                                @endforeach
                                <tr class="active">
                                    <th>*</th>
                                    <th style="text-align: right">Total = </th>
                                    <th>{{round($total_amount,3)}}</th>
                                    <th>{{round($total_due,3)}}</th>
                                    
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
    $("#submit").click(function(){
        start = $("#start").val();
        end = $("#end").val();
        $('#load_result').load("{{URL::to('inventory-report-payable-result')}}?end="+end+'&start='+start);
    });

</script>
@endsection