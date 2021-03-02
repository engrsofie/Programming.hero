      
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
	html += '<td><input type="text" data-type="product_name" id="itemName_'+i+'" class="form-control autocomplete_txt" autocomplete="off"><input type="hidden" name="fk_product_id[]" id="itemId_'+i+'" class="form-control"><input type="hidden" name="fk_model_id[]" id="model_'+i+'" class="form-control"></td>';
	html += '<td><input type="number" min="0" step="any" name="qty[]" id="quantity2_'+i+'" class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;"></td>';
	html += '<td><span id="uom_'+i+'">Unit</span></td>';
	html += '</tr>';
	$('#table_auto').append(html);
	i++;
});
/*-------- Add more other expenses --------*/
var j=1;
$("#adEmpty").on('click',function(){
	var expnese ='<div class="form-group" id="empty'+j+'"> <div class="col-md-1"> <button onclick="deleteRow('+j+')" type="button" class="btn btn-danger btn-sm"><i class="fa fa-trash"></i></button> </div> <div class="col-md-7"> <input type="text" class="form-control" name="other_expense_title[]" placeholder="Other Expance details"> </div> <div class="col-md-4"> <input type="number" class="form-control" name="other_expense[]" min="0" step="any" placeholder="Expance amount"> </div> </div>';
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
	
	if(type =='product_name' )autoTypeNo=0; 	
	$(this).autocomplete({
		source: function( request, response ) {

            _token = $('input[name="_token"]').val();
            $.ajax({
                //url: "{{URL::to('inventory-product-search')}}",
                url: '../inventory-product-damage/dam',
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
	  		
			$('#itemName_'+id[1]).val(names[0]);
			$('#itemId_'+id[1]).val(names[1]);
			$('#uom_'+id[1]).html(names[3]);
			$('#quantity2_'+id[1]).val(1);
			$('#quantity2_'+id[1]).attr('max',names[2]);
			$('#model_'+id[1]).val(names[4]);

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
	if( quantity!='' && price !='' ) $('#total_'+id[1]).val( (parseFloat(price)*parseFloat(quantity)).toFixed(4) );	

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