<?
$month=$input['month'];
$year=$input['year'];
?>
<h5 style="text-align: center">Salary for the moth of {{date('F',strtotime("$year-$month-01"))}}-{{$year}} in {{($input['section']!=null)?$input['section']:'all Section'}} .</h5>
<table class="table table-bordered">
    <tr class="active">
        <th>SL</th>
        <th>ID</th>
        <th>Employe Name</th>
        <th>Designation</th>
        <th>Section</th>
        <th>Salary</th>
        <th>Deduction</th>
        <th>Net Palyable</th>
        <th  class="no-print">Action</th>
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
        <td class="no-print"><a href='{{URL::to("employe-salary/$data->id")}}' class="btn btn-success btn-xs"> <i class="fa fa-eye"></i></a>

        <a href='{{URL::to("employe-salary/$data->id/edit")}}' class="btn btn-primary btn-xs"> <i class="fa fa-pencil-square"></i></a>
        {!! Form::open(array('route'=> ['employe-salary.destroy',$data->id],'method'=>'DELETE')) !!}
                    {{ Form::hidden('id',$data->id)}}
                    <button type="submit" onclick="return confirmDelete();" class="btn btn-xs btn-danger">
                      <i class="fa fa-trash-o"></i>
                    </button>
                {!! Form::close() !!}
        </td>
    </tr>
    @endforeach
        
    </table>