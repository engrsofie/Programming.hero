      
//adds extra table rows
var i=$('#table_auto tr').length;
var d = new Date();
var month = d.getMonth()+1;
var day = d.getDate();
var date = (day<10 ? '0' : '') + day + '-' +
    (month<10 ? '0' : '') + month  +'-'+d.getFullYear();

$(".addmore").on('click',function(){
	html = '<tr>';
	html += '<td><input class="case" type="checkbox"/></td>';
	html += '<td><input type="text" data-type="product_name" id="itemName_'+i+'" class="form-control autocomplete_txt" autocomplete="off"><input type="hidden" data-type="product_name" name="fk_product_id[]" id="itemId_'+i+'" class="form-control autocomplete_txt" autocomplete="off"></td>';
	html += '<td><input type="number" min="0" step="any" name="foreign_amount[]" id="cost_'+i+'" class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" placeholder="Cost per unit"> </td>';
	html +='<td><input type="text" name="currency_name[]" class="form-control" placeholder="Currency"></td>';
	html +=' <td> <input type="number" min="0" step="any" name="bdt_rates[]" class="form-control changesNo" id="rates_'+i+'" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;"></td>';

	html += '<td><input type="number" min="0" step="any" name="qty[]" id="quantity2_'+i+'" class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;"></td>';
	html += '<td><span id="uom_'+i+'">Unit</span></td>';
	html += '<td> <input type="number" min="0" step="any" name="free_of_cost[]" class="form-control" placeholder="Free"></td>';

	html += '<td><input type="number" min="0" step="any" name="amount[]" id="total_'+i+'" class="form-control totalLinePrice" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;"></td>';

	html += '</tr>';
	$('#table_auto').append(html);
	i++;
});
/*-------- Add more other expenses --------*/
var j=1;
$("#adEmpty").on('click',function(){
	var expnese ='<div class="form-group" id="empty'+j+'"> <div class="col-md-1"> <button onclick="deleteRow('+j+')" type="button" class="btn btn-danger btn-sm"><i class="fa fa-trash"></i></button> </div> <div class="col-md-7"> <input type="text" class="form-control" name="other_expense_title[]" placeholder="Other Expance details"> </div> <div class="col-md-4"> <input type="number" class="form-control otherExpensesAmount" name="other_expense[]" min="0" step="any" placeholder="Expance amount"> </div> </div>';
	$('#other_expenses').append(expnese);
	j++;

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
	rates = $('#rates_'+id[1]).val();
	if( quantity!='' && price !='' ) $('#total_'+id[1]).val( (parseFloat(price)*parseFloat(quantity)*parseFloat(rates)).toFixed(4) );	

    benefit = $("#benefit_"+id[1]).val();
    parsentWise = parseFloat(price)+parseFloat(benefit)/100;
    salesAmount = parseFloat(price)+parseFloat(benefit);
    $("#sales_"+id[1]).val(salesAmount);

	calculateTotal();
});

$(document).on('change keyup blur','.otherExpensesAmount',function(){
	calculateTotal();
});

//total price calculation 
function calculateTotal(){
	subTotal = 0 ; total = 0; expense = 0;
	$('.totalLinePrice').each(function(){
		if($(this).val() != '' )subTotal += parseFloat( $(this).val() );
	});
	$('#subTotal').val( subTotal.toFixed(4) );

	$('.otherExpensesAmount').each(function(){
		if($(this).val() != '' )expense += parseFloat( $(this).val() );
	});
	total=subTotal+expense;
	$('#totalWithExpenses').val( total.toFixed(4) );
	
	


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
	total = $('#totalWithExpenses').val();
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

//datepicker 

$(document).on('click', '.datepicker1', function(){
   $(this).datepicker({
      format: "dd-mm-yyyy",
        autoclose: true
   }).focus();
   $(this).removeClass('datepicker1'); 
});

function deleteRow(id){
	$('#empty'+id).remove();
}