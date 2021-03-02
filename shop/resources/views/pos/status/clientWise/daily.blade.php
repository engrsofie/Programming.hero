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
		    <div class="col-md-12 no-padding">
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" onclick="printPage('print_body')" class="printbtn btn btn-xs btn-success pull-right"><i class="fa fa-print m-r-5"></i> Print</a>
                        </div>
                        <h4 class="panel-title">Sales Report </h4>
                    </div>
                    <div class="panel-body print_body">
                        <div class="report_filler">
                            <div class="row">
                            <?
                                $start=date('Y-m-d');
                                $end=date('Y-m-d');
                                if(isset($input['start'])){
                                    $start=$input['start'];
                                }
                                if(isset($input['end'])){
                                    $end=$input['end'];
                                }
                            ?>
                                <div class="form-group col-md-3 no-padding">
                                     <label class="control-label col-md-12" for="Date">Start Date* :</label>
                                    <div class="col-md-9 no-padding">
                                        <input class="form-control" type="date"  name="start" value="{{$start}}" data-parsley-required="true" id="start" />
                                    </div>
                                    <div class="col-md-3 no-padding"><input class="form-control text-center" type="text" value="TO" readonly></div>
                                </div>
                                
                                <div class="form-group col-md-2 no-padding">
                                 <label class="control-label col-md-12" for="Date">End Date* :</label>
                                    <div class="col-md-12 no-padding">
                                        <input class="form-control" type="date"  name="end" value="{{$end}}" data-parsley-required="true"  id="end" />
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
                                    <label class="control-label col-md-12">Select Branch :</label>
                                    <div class="col-md-12">
                                        {{Form::select('fk_branch_id',$branch,$branchId,['class'=>'form-control','placeholder'=>'All Branch','onchange'=>'loadCLient(this.value)','id'=>'branch'])}}
                                    </div>
                                </div>
                                @else
                                <input type="hidden" id='branch' value="{{Auth::user()->fk_branch_id}}">
                                @endif
                                <div class="form-group col-md-3 no-padding">
                                    <label class="control-label col-md-12">Select Organization :</label>
                                    <div class="col-md-12" id="loadCLient">
                                        {{Form::select('fk_client_id',$clients,$clientId,['class'=>'form-control select','placeholder'=>'All Organization','id'=>'client'])}}
                                    </div>
                                </div>
                                <div class="form-group col-md-1 no-padding">
                                 <label class="col-md-12" for="Date">&nbsp;</label>
                                       
                                    <div class="col-sm-12 ">

                                        <button type="submit" id="submit" class="btn btn-success btn-bordred waves-effect w-md waves-light m-b-5">
                                            Submit
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
                                @if(isset($mainData))
                                <? echo $mainData; ?>
                                @endif

                            </div>
                      
                    </div>
                
                    </div>
    		    </div>
    		</div>
    	</div>
@endsection
@section('script')
<script src="{{asset('public/custom_js/printThis.js')}}"></script>
<script type="text/javascript">
    function printPage(id){
        $('#'+id).printThis();
    }
</script>
<script type="text/javascript">
    $("#submit").click(function(){
        var start = $("#start").val();
        var end = $("#end").val();
        var client = $("#client").val();
        var branch = $("#branch").val();
        window.location='{{URL::to("/inventory-daily-sales")}}?end='+end+'&start='+start+'&branch='+branch+'&client='+client;
        
    });
    function loadCLient(id){
        if(id.length==0){
            id=0;
        }
        $('#loadCLient').load('{{URL::to("inventory-client-load")}}/'+id);
    }



</script>
@endsection