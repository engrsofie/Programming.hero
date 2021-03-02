   
	      
//adds extra table rows
var i=$('#table_auto tr').length;
console.log(i);
$(".addmore").on('click',function(){
	var x=i-1;
	html = '<tr>';
	html += '<td><input tabindex="-1" class="case" type="checkbox"/></td>';

	html +='<td><input type="text" data-type="product_name" name="product_name[]" id="itemName_'+i+'" class="form-control autocomplete_txt" autocomplete="off"><input type="hidden" data-type="product_name" name="fk_product_id[]" id="itemId_'+i+'" class="form-control autocomplete_txt" autocomplete="off"></td>';

	html+='<td><input type="text" name="product_model[]" id="productModel_'+i+'" class="form-control" placeholder="Model"></td>';
	html += '<td><input type="number" min="0" step="any" name="qty[]" id="quantity2_'+i+'" class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" placeholder="Qty"></td>';
	html += '<td><span id="uom_'+i+'">Unit</span></td>';
	html += '<td><input type="number" min="0" step="any" name="cost_per_unit[]" id="cost_'+i+'" class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" placeholder="Unit Price" > </td>';

	html += '<td><input type="number" min="0" step="any" name="sales_per_unit[]" class="form-control" tabindex="-1" placeholder="Sales Price"></td>';


	html += '<td><input type="number" min="0" step="any" name="amount[]" id="total_'+i+'" class="form-control totalLinePrice" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" placeholder="Sub Total"  readonly tabindex="-1"></td>';
	if($("#stockPosition-"+x).html()){
		var stock=$("#stockPosition-"+x).html();
	}else{
		
		var stock=$("#stockPosition-1").html();
	}
	html += '<td><div id="stockPosition-'+i+'">'+stock+'</div></td>';
	html += '</tr>';
	$('#table_auto').append(html);
	$('#itemName_'+i).focus();
	i++;
	console.log(i);
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
	
	if(type =='barcode' )autoTypeNo=0;
	if(type =='product_name' )autoTypeNo=1; 	
	
	$(this).autocomplete({
		source: function( request, response ) {

            _token = $('input[name="_token"]').val();
            $.ajax({
                //url: "{{URL::to('inventory-product-search')}}",
                url: '../inventory-product-search',
                type: "GET",
                dataType: "json",
                data: { _token : _token,
                    name_startsWith: request.term,
                    type: type
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
	  		console.log(names, id);
	  		
			$('#itemNo_'+id[1]).val(names[0]);
			$('#itemName_'+id[1]).val(names[1]);
			$('#itemId_'+id[1]).val(names[2]);
			$('#uom_'+id[1]).html(names[3]);
			$('#cost_'+id[1]).val(names[4]);
			$('#quantity_'+id[1]).val(names[5]);
			$('#quantity2_'+id[1]).val(1);
			$('#benefit_'+id[1]).val(0);
			
			//$('#price1_'+id[1]).val(names[4]);

			$('#total_'+id[1]).val( 1*names[4
				] );

			$('#quantity2_'+id[1]).change(function(){
				var quantity1 = $('#quantity_'+id[1]).val();
				var quantity2 = $('#quantity2_'+id[1]).val();
				$('#quantity2_'+id[1]).attr({'max':quantity1,'min':0});
			})

			$('#quantity2_'+id[1]).focusout(function(){
					var quantity1 = $('#quantity_'+id[1]).val();
					var quantity2 = $('#quantity2_'+id[1]).val();

					if(parseInt(quantity1) < parseInt(quantity2)){
						alert("Your store doesn't have sufficient stock");
					}
			})

			calculateTotal();
		}		      	
	});
});

//price change
$(document).on('change keyup blur','.changesNo',function(){
	id_arr = $(this).attr('id');
	id = id_arr.split("_");
	quantity = $('#quantity2_'+id[1]).val();
	price = $('#cost_'+id[1]).val();
	if( quantity!='' && price !='' ) $('#total_'+id[1]).val( (parseFloat(price)*parseFloat(quantity)).toFixed(2) );	

    benefit = $("#benefit_"+id[1]).val();
    parsentWise = parseFloat(price)+parseFloat(benefit)/100;
    salesAmount = parseFloat(price)+parseFloat(benefit);
    $("#sales_"+id[1]).val(salesAmount);

	calculateTotal();
});

$(document).on('change keyup blur','#tax',function(){
	calculateTotal();
});

//total price calculation 
function calculateTotal(){
	subTotal = 0 ; total = 0; 
	$('.totalLinePrice').each(function(){
		if($(this).val() != '' )subTotal += parseFloat( $(this).val() );
	});
	$('#subTotal').val( subTotal.toFixed(4) );
	
	tax = $('#tax').val();
	if(tax != '' && typeof(tax) != "undefined" ){
		taxAmount = subTotal * ( parseFloat(tax) /100 );
		$('#taxAmount').val(taxAmount.toFixed(4));
		total = subTotal + taxAmount;
	}else{
		$('#taxAmount').val(0);
		total = subTotal;
	}
	$('#totalAftertax').val( total.toFixed(4) );


	calculateAmountDue();
}

$(document).on('change keyup blur','#amountPaid1',function(){
	calculateAmountDiscount();
});

//due amount calculation
function calculateAmountDiscount(){
	amountPaid1 = $('#amountPaid1').val();
	total = $('#subTotal').val();
	console.log(total);
	
	amountDue = parseFloat(total) - parseFloat( amountPaid1 );
	$('#amountDue').val( amountDue);
//$('#totalAftertax').val( total.toFixed(4) );
	calculateAmountDue();
}

$(document).on('change keyup blur','#amountPaid',function(){
	calculateAmountDue();
});

//due amount calculation
function calculateAmountDue(){
	total = $('#subTotal').val();
	amountPaid = $('#amountPaid').val();
	
	//amountPaid1 = $('#amountPaid1').val();
	if(amountPaid != '' && typeof(amountPaid) != "undefined" ){
		amountDue = parseFloat(total) - parseFloat( amountPaid );
		$('.amountDue').val( amountDue.toFixed(4) );
	}else{
		total = parseFloat(total).toFixed(4);
		$('.amountDue').val( total);
	}

	//calculatePaid();
}


//It restrict the non-numbers
var specialKeys = new Array();
specialKeys.push(8,46); //Backspace
function IsNumeric(e) {
    var keyCode = e.which ? e.which : e.keyCode;
    console.log( keyCode );
    var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1);
    return ret;
}


$('body').keypress(function (e) {
	var keyCode = e.keyCode || e.which;
	if(keyCode==83){
		$('form.purchase-form').submit();
	}
});
$(window).on("beforeunload", function() {
    return "Are you sure? You didn't finish the form!";
});

$("form.purchase-form").on("submit", function(e) {
    $(window).off("beforeunload");
    return confirm("Are you confirm?");
});