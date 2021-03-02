
<?php $__env->startSection('content'); ?>
<div id="content" class="content">
	<div class="row">
	    <div class="col-md-12">
            <div class="panel panel-inverse">
                <div class="panel-heading"> 
                    <div class="panel-heading-btn">
                            <a class="btn btn-info btn-xs" href="<?php echo e(URL::to('/barcode')); ?>">View All</a>
                            
                        </div>
                    <h4 class="panel-title">Generate Product Barcode</h4>
                </div>
                <div class="panel-body">
                	 <?php echo Form::open(array('route' => 'barcode.store','class'=>'form-horizontal author_form','method'=>'POST','role'=>'form','data-parsley-validate novalidate')); ?>

                    <table class="table table-bordered table-hover" id="table_auto">
                        <thead>
                            <tr>
                                <th width="1%"></th>
                                <th width="20%"> Product Name </th>
                                <th width="10%"> Generate </th>
                                <th width="15%"> Barcode </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><input class="case" type="checkbox"/></td>
                                <td><input type="text" data-type="product_name" name="product_name[]" required id="itemName_1" class="form-control autocomplete_txt" autocomplete="off">
                                <input type="hidden" required name="fk_product_id[]" id="itemId_1" class="form-control" autocomplete="off">
                                <input type="hidden" required name="fk_model_id[]" id="model_1" class="form-control"></td>

                                <td><button onclick="generate(this.id)" id="generate_1" data="" type="button" class="btn btn-default form-control generate">Generate</button></td>
                                        
                                <td><input type="number" min="0" name="barcode[]" step="any" id="barcode_1" class="form-control changesNo" autocomplete="off" required onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" placeholder="Barcode"></td>
                            </tr>
                        </tbody>
                    </table> 
                    <div class='row'>
                        <div class='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
                            <button class="btn btn-success addmore" type="button">+ Add More</button>
                            <button class="btn btn-danger delete" type="button">- Delete</button>
                        </div>
                    </div><br> 
                    <div class="form-group">
						<label class="control-label col-md-2 col-sm-2"></label>
						<div class="col-md-8 col-sm-8">
                        
							<button type="submit" class="btn btn-primary" style="width: 100%;">Confirm</button>
						</div>
                        <label class="control-label col-md-2 col-sm-2"></label>
					</div>
                    <?php echo Form::close();; ?>     
					<br>
                </div>
            </div>
        </div>
    </div>
</div>
<?php $__env->stopSection(); ?>
<?php $__env->startSection('script'); ?>
<script type="text/javascript">
    var i=$('#table_auto tr').length;
$(".addmore").on('click',function(){
	i++;
    html = '<tr>';
    html += '<td><input class="case" type="checkbox"/></td>';

    html += '<td><input type="text" required data-type="product_name" name="product_name[]" id="itemName_'+i+'" class="form-control autocomplete_txt" autocomplete="off"><input type="hidden" required name="fk_product_id[]" id="itemId_'+i+'" class="form-control autocomplete_txt" required autocomplete="off"><input type="hidden" name="fk_model_id[]" id="model_'+i+'" class="form-control"></td>';

    html+='<td> <button onclick="generate(this.id)" id="generate_'+i+'" data="" type="button" class="btn btn-default form-control generate">Generate</button> </td>'
    html += '<td><input type="number" required min="0" name="barcode[]" step="any" id="barcode_'+i+'" class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" placeholder="Barcode"></td>';

    html += '</tr>';
    $('#table_auto').append(html);
    $('#itemName_'+i).focus();
});
	$(".delete").on('click', function() {
		$('.case:checkbox:checked').parents("tr").remove();
		$('#check_all').prop("checked", false); 
		calculateTotal();
	});

	$(document).on('focus','.autocomplete_txt',function(){
	type = $(this).data('type');
	
	if(type =='product_name' )autoTypeNo=0; 	

	$(this).autocomplete({
		source: function( request, response ) {

            _token = $('input[name="_token"]').val();
            $.ajax({
                url: "<?php echo e(URL::to('search-inventory-barcode')); ?>",
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

<?php $__env->stopSection(); ?>
<?php echo $__env->make('layout.app', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>