
	@extends('layout.app')
		@section('content')
		<!-- begin #content -->
		<div id="content" class="content">
			
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                            @if(isset($reports))
                                <a href="javascript:;" onclick="printPage('print_body')" class="btn btn-xs btn-success"><i class="fa fa-print"></i> Print</a>
                            @else
                            	<a class="btn btn-info btn-xs" href="{{URL::to('/inventory-client')}}">View All Clients</a>
                            @endif
                                
                            </div>
                            <h4 class="panel-title">Organization Account Report</h4>
                        </div>
                        <div class="panel-body">
                            {!! Form::open(array('url' => 'inventory-client-account','class'=>'form-horizontal author_form','method'=>'GET','data-parsley-validate novalidate')) !!}
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
                                    <label class="col-md-12" for="Date">Select Organization * :</label>
                                    <div class="col-md-12" id="loadCLient">
                                    <? $id= isset($input['id'])?$input['id']:''?>
                                        {{Form::select('id',$clients,$id,['class'=>'form-control select','placeholder'=>'Select Organization','required'])}}
                                    </div>
                                </div>
                                <div class="form-group col-md-6 no-padding">
                                    <label class="col-md-12" for="Date">Select Date * :</label>
                                    <div class="col-md-5">
                                        <input class="form-control" type="date" name="start_date" value="{{isset($input['start_date'])?$input['start_date']:date('Y-m-d')}}" placeholder="date" data-parsley-required="true" />
                                    </div>

                                    <div class="col-md-2 no-padding"><input readonly class="form-control text-center" value="TO"></div>

                                    <div class="col-md-5">
                                        <input class="form-control" type="date" name="end_date" value="{{isset($input['end_date'])?$input['end_date']:date('Y-m-d')}}" placeholder="date" data-parsley-required="true" />
                                    </div>
                                </div>
                                
                                <div class="form-group col-md-1">
                                    <label class="col-md-12">&nbsp;</label>
                                    <div class="col-md-12">
                                        <button type="submit" class="btn btn-primary">Submit</button>
                                    </div>
                                </div>
                            {!! Form::close(); !!}

                             @if(isset($reports))
                            <div class="col-md-12">
                                <hr>
                            </div>
                            <!-- Print Body -->
                            <div id="print_body" style="width: 100%;overflow: hidden; padding: 10px 20px;">
                            @include('pad.header')
                                <? echo $reports; ?>

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
