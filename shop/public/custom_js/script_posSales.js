$('#barcode').keydown(function (e) {
	var keyCode = e.keyCode || e.which;
	if(keyCode == 13){
	    
	    var id  = $(this).val();
	    	$.ajax({
	            url: "../pos-sales/"+id,
	            type: "GET",
	            dataType: "json",
            success: function( data ) {
            	if(jQuery.isEmptyObject(data)){
            		$('#barcode').select();
            		$('#product_name').html("<b class='text-danger'>Not Available</b>");
            	}else{
            		
            		$('#product_name').html(data['product_name']+'('+data['model_name']+')');
            		$('#product_id').val(data['fk_product_id']);
            		$('#model').val(data['fk_model_id']);
            		$('#price').html(data['sales_per_unit']);
            		$('#priceInput').val(data['sales_per_unit']);
            		$('#quantity').val(1);
            		$('#quantity').attr('max',data['available_qty']);
            		$('#unit').val(data['small_unit_name']);
            		$('#quantity').select();
            	}
			}
        });
	}
});
$('#quantity').keydown(function (e) {
	var keyCode = e.keyCode || e.which;
	if(keyCode == 13){
		var product = $('#product_name').html();
		var productId = $('#product_id').val();
		var model = $('#model').val();
		var unitPrice = $('#priceInput').val();
		var quantity = $('#quantity').val();
		var max = $('#quantity').attr('max');
		var unit = $('#unit').val();
		var price  = quantity*unitPrice;
		var i =$('#seassionTable tr').length;
		if(productId.length>0){
			if(parseFloat(quantity)>parseFloat(max) ){
				$('#qtyAlert').html('Qty is not Available');
			}else{
			var html = '<tr>';
			html += '<td>'+i+'</td>';
			html +='<td>'+product+'<input type="hidden" value="'+productId+'" name="fk_product_id[]"> <input type="hidden" value="'+model+'" name="fk_model_id[]"> </td>';
            
			html+='<td>'+unitPrice+' <input type="hidden" id="unitPrice_'+i+'" value="'+unitPrice+'" name="product_price_amount[]"> </td>';
            
			html+='<td><input type="number" min="0" tabindex="-1" step="any" class="form-control changeQty" id="qty_'+i+'" value="'+quantity+'" name="sales_qty[]"></td>';
             
			html+='<td>'+unit+'</td><td><span id="price_'+i+'">'+price+'</span> <input  id="subprice_'+i+'" class="subprice" type="hidden" value="'+price+'" name="product_paid_amount[]"> </td>';
            html +='<td> <button type="button"  tabindex="-1" class="btn btn-danger btn-xs delete"><i class="fa fa-trash"></i></button </td>';
			html += '</tr>';
			$('#seassionTable').append(html);
			$('#qtyAlert').html('');
			$('#product_name').html('');
    		$('#product_id').val('');
    		$('#model').val('');
    		$('#price').html('');
    		$('#priceInput').val('');
    		$('#quantity').val('');
    		$('#quantity').attr('max','');
    		$('#unit').val('');
			$('#barcode').val('');
			$('#barcode').select();

			i++;
			totalAmount();
			}
		}

	}
});
function totalAmount(){
	var total = 0;
	$('.subprice').each(function(){
		total+=parseFloat($(this).val());
	});
	$('#subTotal').val(total);
	totalCalculate();
}
$(document).on('change keypress keyup keydown blur focus','#discount',function(){
	totalCalculate();
});

function totalCalculate(){
	var total=parseFloat($('#subTotal').val());
	var discount=parseFloat($('#discount').val());
	$('#total').val(total-discount);
	totalDue();
}
$(document).on('change keypress keyup keydown blur focus','#totalPaid',function(){
	totalDue();
});

function totalDue(){
	var total=parseFloat($('#total').val());
	var paid1=parseFloat($('#totalPaid').val());
	var change = paid1-total;
	if(change<0){
		change = 0;
	}
	$('#change').val(change);
	$('#amountPaid').val(paid1-change);
	var paid=parseFloat($('#amountPaid').val());
	
	$('#amountDue').val(total-paid);
}
$(document).on('click','.delete',function(){
	$(this).parents("tr").remove();
	totalAmount();
	$('#barcode').select();
});
$(document).on('change keydown blur focus keyup keypress','.changeQty',function(){
	var id = $(this).attr('id').split('_')[1];
	var qty  =parseFloat($(this).val());
	var price  =parseFloat($('#unitPrice_'+id).val());
	var subPrice = qty*price;
	$('#price_'+id).html(subPrice);
	$('#subprice_'+id).val(subPrice);
	totalAmount();

});

$(window).on("beforeunload", function() {
    return "Are you sure? You didn't finish the form!";
});
  $("form.sales-form").on("submit", function(e) {
    $(window).off("beforeunload");
    return confirm("Are you confirm?");
});

    






function IsNumeric(e) {
    var keyCode = e.which ? e.which : e.keyCode;
    //console.log( keyCode );
    var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1);
    return ret;
}