@extends('layout.app')
@section('content')
<?
    if(isset($qty)){
    }else{
        
        $qty=60;
    }
?>
<div id="content" class="content">
	<div class="row">
	    <div class="col-md-12">
            <div class="panel panel-inverse">
                <div class="panel-heading"> 
                    <div class="panel-heading-btn">
                        <a href="javascript:;" onclick="printPage('print_body')" class="printbtn btn btn-xs btn-success m-b-10"><i class="fa fa-print m-r-5"></i> Print</a>
                        <a class="btn btn-info btn-xs" href="{{URL::to('/barcode')}}">View All</a>
                            
                        </div>
                    <h4 class="panel-title">Print Product Barcode</h4>
                </div>
                <div class="panel-body">
                    <table class="table table-bordered">
                        <tr>
                            <td><b>Product Name : </b> {{$data->product_name}}</td>
                            <td><b>Model Name : </b> {{$data->model_name}}</td>
                            <td><b>Barcode : </b> {{$data->barcode}}</td>
                            <td width="35%">
                                {!! Form::open(array('url' => "barcode/$data->id",'method'=>'get')) !!}
                                <div class="form-group" style="margin: 0;">
                                    <label class="control-label col-md-4">Qty:</label>
                                    <div class="col-md-6 no-padding">
                                        <input type="number" min="1" name="qty" value="{{$qty}}" class="form-control">
                                    </div>
                                    <div class="col-md-2 no-padding">
                                        <button class="bnt btn-success btn-sm">Submit</button>
                                    </div>
                                </div>
                                {!! Form::close(); !!}
                            </td>
                        </tr>
                    </table>

                    <div id="print_body">
                        <? for ($i=0; $i < $qty; $i++) { ?>
                        <div class="col-md-6" style="float: left;margin: 5px;width: 48% ;border: 1px solid #eee;min-height: 75px;max-height: 100px;">
                            <div class="barcode-img">
                                <img class="img-responsive" src='data:image/png;base64,{{DNS1D::getBarcodePNG("$data->barcode", "C39")}}' alt="{{$data->barcode}}" />
                                <p class="text-center">{{$data->barcode}}</p>
                                <p class="text-center">{{$data->product_name}}</p>
                                @if($price>0)
                                @endif
                            </div>

                            <br>
                        </div>
                       <?}?>
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
@endsection