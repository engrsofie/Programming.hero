

var i=$('#table_auto tr').length;
$(".addmore").on('click',function(){
	html = '<tr>';
	html += '<td><input tabindex="-1" class="case" type="checkbox"/></td>';

	html += '<td><input type="text" required data-type="product_name" name="product_name[]" id="itemName_'+i+'" class="form-control autocomplete_txt" autocomplete="off"><input type="hidden" required name="fk_product_id[]" id="itemId_'+i+'" class="form-control" required ><input type="hidden" name="fk_model_id[]" id="model_'+i+'" class="form-control"></td>';

	html+='<td><input type="text" tabindex="-1" min="0" step="any" name="avaliable_qty[]" id="quantity_'+i+'" class="form-control changesNo" readonly="readonly"></td>';
    html+='<td><input type="number" min="0" name="qty[]" step="any" id="qty_'+i+'" class="form-control changesNo" autocomplete="off" required onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" placeholder="Qty"></td>';
    html+='<td><input type="number" min="0" name="cost_per_unit[]" step="any" id="cost_'+i+'" class="form-control changesNo" autocomplete="off" required onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" placeholder="Cost Per Unit"></td>';
    html+='<td><input type="number" name="sub_total[]" step="any" readonly id="subTotal_'+i+'" class="form-control subTotal" tabindex="-1" > </td>';

	html += '</tr>';
	$('#table_auto').append(html);
	$('#itemName_'+i).focus();
	i++;
});


$(".delete").on('click', function() {
	$('.case:checkbox:checked').parents("tr").remove();
	$('#check_all').prop("checked", false); 
	calculateTotal();
});

$(document).on('change keypress keyup blur','.changesNo',function(){
	id_arr = $(this).attr('id');
	var id = id_arr.split("_");
	var quantity = ($('#qty_'+id[1]).val()!='')?$('#qty_'+id[1]).val():0;
	var price = ($('#cost_'+id[1]).val()!='')?$('#cost_'+id[1]).val():0;

	if( quantity!='' && price !='') $('#subTotal_'+id[1]).val( (parseFloat(price)*parseFloat(quantity)));

	calculateTotal();
});
$('#transferFrom').on('change',function(){
    //window.location='';
    $('.subTotal').each(function(){
        var id = $(this).attr('id').split('_')[1];
        if(id>1){
            $(this).parents("tr").remove();
            calculateTotal();
        }
       $('#itemName_1').val('');
       $('#qty_1').val(0);
       $('#subTotal_1').val(0);
       $('#cost_1').val(0);
       $('#quantity_1').val(0);
       $('#total').val(0);
    });
  });
$(document).on('change keyup keypress blur','.changesNo',function(){
	calculateTotal();
});

//total price calculation 
function calculateTotal(){
	subTotal = 0 ; total = 0; prev=0;
	$('.subTotal').each(function(){
		if($(this).val() != '' )subTotal += parseFloat( $(this).val() );
	});
	$('#total').val( subTotal );
}
