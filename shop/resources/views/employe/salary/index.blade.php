
	@extends('layout.app')
		@section('content')
		<!-- begin #content -->
		<div id="content" class="content">
			 
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                           
                                <a href="javascript:;" onclick="printPage('print_body')" class="printbtn btn btn-xs btn-success"><i class="fa fa-print"></i> Print</a>

                                
                            </div>
                            <h4 class="panel-title">Employee Salary</h4>
                        </div>
                        <div class="panel-body">
                            <form action="{{URL::to('employe-salary')}}" method="GET">
                                <div class="form-group col-md-3">
                                    <label class="col-md-12" for="Date">Select Section * :</label>
                                    <div class="col-md-12">
                                        {{Form::select('section',$section,'',['class'=>'form-control select','placeholder'=>'Select Section','id'=>'section'])}}
                                        <span class="help-text" id="section_error"></span>
                                    </div>
                                </div>
                            @if(Auth::user()->isRole('administrator'))
                                <div class="form-group col-md-3">
                                    <label class="col-md-12" for="Date">Select Branch * :</label>
                                    <div class="col-md-12">
                                        {{Form::select('branch',$branch,'',['class'=>'form-control select','placeholder'=>'All Branch','id'=>'branch'])}}
                                        <span class="help-text" id="section_error"></span>
                                    </div>
                                </div>
                            @endif
                                <div id="loadEmploye"><!-- Load Employee --></div>
                                <div class="form-group col-md-4">
                                    <label class="col-md-12" for="Date">Select Year and Month * :</label>
                                    <div class="col-md-5">
                                        <input class="form-control" type="number" min="2000" name="year" value="{{date('Y')}}" placeholder="year" data-parsley-required="true" id="year" />
                                    </div>
                                    <div class="col-md-7">
                                        {{Form::select('month',$month,date('n'),['class'=>'form-control select','required','id'=>'month'])}}
                                    </div>
                                </div>
                                
                                <div class="form-group col-md-2">
                                    <label class="col-md-12">Click</label>
                                    <div class="col-md-12">
                                        <button type="submit" class="btn btn-primary">Submit</button>
                                    </div>
                                </div>
                            </form>
                        <div id="print_body" style="width: 100%;overflow: hidden; padding: 10px 20px;">
                    @include('pad.header')

                            <div id="salary">
                                <h5 style="text-align: center">Salary for the moth of {{date('F')}}-{{date('Y')}} in all Section.</h5>
                                <table class="table table-bordered">
                                <tr class="active">
                                    <th>SL</th>
                                    <th>ID</th>
                                    <th>Employee Name</th>
                                    <th>Designation</th>
                                    <th>Section</th>
                                    <th>Salary</th>
                                    <th>Deduction</th>
                                    <th>Net Payable</th>
                                    <th ><span class="no-print"> Action</span> <span class="printable" >Signature</span> </th>
                                </tr>
                                <? $i=0; ?>
                                @foreach($salary as $data)
                                <? $i++; ?>
                                <tr>
                                    <td>{{$i}}</td>
                                    <td>{{$data->employe_id}}</td>
                                    <td>{{$data->employe_name}}</td>
                                    <td>{{$data->designation}}</td>
                                    <td>{{$data->section_name}}</td>
                                    <td>{{$data->total_amount}}</td>
                                    <td>{{$data->deduction}}</td>
                                    <td>{{$data->paid_amount}}</td>
                                    <td>
                                    <div class="no-print">
                                        
                                    <a href='{{URL::to("employe-salary/$data->id")}}' class="btn btn-success btn-xs"> <i class="fa fa-eye"></i></a>

                                    <a href='{{URL::to("employe-salary/$data->id/edit")}}' class="btn btn-primary btn-xs"> <i class="fa fa-pencil-square"></i></a>
                                    {!! Form::open(array('route'=> ['employe-salary.destroy',$data->id],'method'=>'DELETE')) !!}
                                        {{ Form::hidden('id',$data->id)}}
                                        <button type="submit" onclick="return confirmDelete();" class="btn btn-xs btn-danger">
                                          <i class="fa fa-trash-o"></i>
                                        </button>
                                    {!! Form::close() !!}

                                    </div>
                                    </td>
                                </tr>
                                @endforeach
                                    
                                </table>
                            </div><!-- /Salary -->
                            <div class="printFooter" style="overflow: hidden;width: 100%;">
                                @include('pad.footer')
                            </div>
                        </div><!-- /Print Body -->

                        </div>
                    </div>
			    </div>
			</div>
		</div>
		<!-- end #content -->

    @endsection
@section('script')
<script type="text/javascript">
   $(document).ready(function(){
        $('#signature3').html("Managing Director");
    })
    function salary(){
        var section=$('#section').val();
        var year=$('#year').val();
        var month=$('#month').val();
        var branch=$('#branch').val();

        $('#salary').load('{{URL::to("employe-salary-sheet")}}?section='+section+'&year='+year+'&month='+month+'&branch='+branch);
            
        
    }
</script>
<script src="{{asset('public/custom_js/printThis.js')}}"></script>
<script type="text/javascript">
    function printPage(id){
        $('#'+id).printThis();
    }
</script>
@endsection
