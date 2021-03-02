
	      
//adds extra table rows
var i=$('#table_auto tr').length;
$(".addmore").on('click',function(){
	html = '<tr>';
	html += '<td><input tabindex="-1" class="case" type="checkbox"/></td>';
	html += '<td><input tabindex="-1" type="text" min="0" name="avaliable_qty[]" step="any" id="quantity_'+i+'" class="form-control changesNo avaliable_qty" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly="readonly"></td>';
	html += '<td><input type="text" data-type="product_name" name="product_name[]" id="itemName_'+i+'" class="form-control autocomplete_txt" autocomplete="off"><input type="hidden" data-type="product_name" name="fk_product_id[]" id="itemId_'+i+'" class="form-control autocomplete_txt" autocomplete="off"><input type="hidden" name="fk_model_id[]" id="model_'+i+'" class="form-control"></td>';
	html += '<td><input type="number" min="0" name="sales_qty[]" step="any" id="quantity2_'+i+'" class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" placeholder="Quantity"></td>';
	html += '<td><span id="smallUnit_'+i+'">Unit</span></td>';
	html+='<td> <button onclick="costPrice(this.id)" id="costPrice_'+i+'" data="0" type="button" class="btn btn-default form-control costPrice">Click</button> </td>';

	html += '<td><input type="text" min="0" name="product_price_amount[]" step="any" id="hidden_'+i+'" class="form-control sales_price changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" ></td>';
	html += '<td><input tabindex="-1" type="text" min="0" step="any" name="product_paid_amount[]" id="total_'+i+'" class="form-control totalLinePrice" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;"readonly="readonly"><input type="hidden" step="any" min="0" name="price[]" id="cost_'+i+'" class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" ></td>';
	html += '</tr>';
	$('#table_auto').append(html);
	$('#itemName_'+i).focus();
	i++;
});

//to check all checkboxes
$(document).on('change','#check_all',function(){
	$('input[class=case]:checkbox').prop("checked", $(this).is(':checked'));
});

//deletes the selected table rows
$(".delete").on('click', function() {
	$('.case:checkbox:checked').parents("tr").remove();
	$('#check_all').prop("checked", false); 
	calculateTotal();
});

//autocomplete script
$(document).on('focus','.autocomplete_txt',function(){
	type = $(this).data('type');
	
	if(type =='product_name')autoTypeNo=0; 	

	$(this).autocomplete({
		source: function( request, response ) {

            _token = $('input[name="_token"]').val();
            $.ajax({
                //url: "{{URL::to('inventory-product-search')}}",
                url: '../inventory-search',
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
			$('#itemName_'+id[1]).removeAttr('autofocus');
			$('#itemId_'+id[1]).val(names[1]);
			$('#model_'+id[1]).val(names[5]);
			$('#smallUnit_'+id[1]).html(names[4]);
			$('#costPrice_'+id[1]).attr('data',names[6]);
			$('#quantity_'+id[1]).val(names[3]);
			$('#quantity2_'+id[1]).val(1);
			$('#quantity2_'+id[1]).attr('max',names[3]);
			$('#cost_'+id[1]).val(names[2]);
			$('#hidden_'+id[1]).val(names[2]);
			$('#total_'+id[1]).val( 1*names[2] );

			$('#quantity2_'+id[1]).select();

			$('#quantity2_'+id[1]).focusout(function(){
					var quantity1 = $('#quantity_'+id[1]).val();
					var quantity2 = $('#quantity2_'+id[1]).val();

					if(parseInt(quantity1) < parseInt(quantity2)){
						/*alert("Your store doesn't have sufficient stock");*/
					}
			})

			calculateTotal();
		}		      	
	});
  
});

//price change
$(document).on('change keypress keyup blur','.changesNo',function(){
	id_arr = $(this).attr('id');
	var id = id_arr.split("_");
	var quantity = $('#quantity2_'+id[1]).val();
	var price = $('#hidden_'+id[1]).val();
	//var dis = $('#discount_'+id[1]).val();
	//var dis=(price/100)*discount;
	//var amount=price-dis;
	var amount=price;
	if( quantity!='' && amount !='') $('#total_'+id[1]).val( (parseFloat(amount)*parseFloat(quantity)));

	calculateTotal();
});

$(document).on('change keyup keypress blur','.changesNo',function(){
	calculateTotal();
});

//total price calculation 
function calculateTotal(){
	subTotal = 0 ; total = 0; prev=0;
	$('.totalLinePrice').each(function(){
		if($(this).val() != '' )subTotal += parseFloat( $(this).val() );
	});
	$('#subTotal').val( subTotal );
	var discount =0;
	if($('#discount').val()!=''){
		discount =parseFloat($('#discount').val());
	}
	if($('#prev_amount').val()){
		prev =  $('#prev_amount').val();
	}
	if(prev){
		$('#grandTotal').val(parseFloat(prev)+subTotal-discount);
	}
	$('#total').val( subTotal-discount );
	calculateAmountDue();
}
$(document).on('change keyup blur','#amountPaid',function(){
	calculateAmountDue();
});

//due amount calculation
function calculateAmountDue(){
	total = $('#grandTotal').val();
	amountPaid = $('#amountPaid').val();
	
	//amountPaid1 = $('#amountPaid1').val();
	if(amountPaid != '' && typeof(amountPaid) != "undefined" ){
		amountDue = parseFloat(total) - parseFloat( amountPaid );
		$('.amountDue').val( amountDue );
	}else{
		total = parseFloat(total);
		$('.amountDue').val( total);
	}

}

$(document).on('keyup blur change','.sales_price',function(){
	var id = $(this).attr('id').split('_')[1];
	var  cost = parseFloat($('#costPrice_'+id).attr('data'));
	var sales = parseFloat($(this).val());
	if(cost>sales){
		$(this).addClass('danger');

	}else{

		$(this).removeClass('danger');
	}
});


//It restrict the non-numbers
var specialKeys = new Array();
specialKeys.push(8,46); //Backspace
function IsNumeric(e) {
    var keyCode = e.which ? e.which : e.keyCode;
    //console.log( keyCode );
    var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1);
    return ret;
}
$('input').keydown(function (e) {
var keyCode = e.keyCode || e.which;
if (keyCode == 13) {
    /*var inputs = $(this).parents("form").eq(0).find(":input").not(':input.btn-not');
    console.log(inputs);
    if (inputs[inputs.index(this) + 1] != null) {                    
        inputs[inputs.index(this) + 1].focus();
    }*/
    e.preventDefault();
    return false;
}
});
$('body').keypress(function (e) {
	var keyCode = e.keyCode || e.which;
	if(keyCode==83){
		$('form.sales-form').submit();

	}
});
 $(window).on("beforeunload", function() {
    return "Are you sure? You didn't finish the form!";
});
  $("form.sales-form").on("submit", function(e) {
    $(window).off("beforeunload");
    return confirm("Are you confirm?");
});
