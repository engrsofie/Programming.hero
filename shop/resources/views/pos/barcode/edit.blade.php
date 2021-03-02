@extends('layout.app')
@section('content')
<div id="content" class="content">
	<div class="row">
	    <div class="col-md-12">
            <div class="panel panel-inverse">
                <div class="panel-heading"> 
                    <div class="panel-heading-btn">
                            <a class="btn btn-info btn-xs" href="{{URL::to('/barcode')}}">View All</a>
                            
                        </div>
                    <h4 class="panel-title">Generate Product Barcode</h4>
                </div>
                <div class="panel-body">
                	 {!! Form::open(array('route' =>['barcode.update',$data->id],'class'=>'form-horizontal author_form','method'=>'PUT','role'=>'form','data-parsley-validate novalidate')) !!}
                    <table class="table table-bordered table-hover" id="table_auto">
                        <thead>
                            <tr>
                                <th width="20%"> Product Name </th>
                                <th width="10%"> Generate </th>
                                <th width="15%"> Barcode </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><input type="text" data-type="product_name" name="product_name" required id="itemName_1" class="form-control autocomplete_txt" value="{{$data->product_name}} ({{$data->model_name}})" autocomplete="off">
                                <input type="hidden" required name="fk_product_id" id="itemId_1" class="form-control" autocomplete="off" value="{{$data->fk_product_id}}">
                                <input type="hidden" required name="fk_model_id" id="model_1" class="form-control" value="{{$data->fk_model_id}}"></td>
                                <td><button onclick="generate(this.id)" id="generate_1" data="{{$data->fk_product_id}}{{$data->fk_model_id}}" type="button" class="btn btn-default form-control generate">Generate</button></td>
                                <td><input type="number" min="0" name="barcode" step="any" id="barcode_1" value="{{$data->barcode}}" class="form-control changesNo" autocomplete="off" required onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" placeholder="Barcode"></td>
                            </tr>
                        </tbody>
                    </table> 
                    <div class="form-group">
						<div class="col-md-8 col-sm-8">
							<button type="submit" class="btn btn-success">Update</button>
						</div>
					</div>
                    {!! Form::close(); !!}     
					<br>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
@section('script')
<script type="text/javascript">
	$(document).on('focus','.autocomplete_txt',function(){
	type = $(this).data('type');
	
	if(type =='product_name' )autoTypeNo=0; 	

	$(this).autocomplete({
		source: function( request, response ) {

            _token = $('input[name="_token"]').val();
            $.ajax({
                url: "{{URL::to('search-inventory-barcode')}}",
                type: "GET",
                dataType: "json",
                data: { _token : _token,
                    name_startsWith: request.term,
                    type: type,
                    },
                success: function( data ) {
                	//console.log(data);
					 response( $.map( data, function( item ) {
					 	var code = item.split("|");
						return {
							label: code[autoTypeNo],
							value: code[autoTypeNo],
							data : item
						}
					}));
				}
            });
		},

		autoFocus: true,	      	
		minLength: 0,
		appendTo: "#modal-fullscreen",
		select: function( event, ui ) {
			var names = ui.item.data.split("|");
			id_arr = $(this).attr('id');
	  		id = id_arr.split("_");
			$('#itemNo_'+id[1]).val(names[0]);
			$('#itemName_'+id[1]).val(names[0]);
			$('#itemId_'+id[1]).val(names[1]);
			$('#model_'+id[1]).val(names[2]);
			$('#generate_'+id[1]).attr('data',names[1]+names[2]);
			$('#barcode_'+id[1]).focus();
		}		      	
	});
  
});
function generate(id){
	i = id.split("_")[1];
    var data = $('#'+id).attr('data');
    $('#barcode_'+i).val(data);
    $('#barcode_'+i).focus();
  }
</script>

@endsection