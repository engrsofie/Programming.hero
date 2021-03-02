 /**
 * Site : http:www.smarttutorials.net
//  * @author muni
//  */
	      
 //adds extra table rows
 var i=$('#table_auto tr').length;
 $(".addmore").on('click',function(){
 	html = '<tr>';
 	html += '<td><input class="case" type="checkbox"/></td>';
 	html += '<td><input type="text" data-type="fk_sub_category_id" name="fk_sub_category_id[]" id="fk_sub_category_id_'+i+'" class="form-control autocomplete_txt" autocomplete="off"></td>';
 	html += '<td><input type="text" data-type="description" name="description[]" id="description_'+i+'" class="form-control autocomplete_txt" autocomplete="off"></td>';

 	html += '<td><input type="number" min="0" name="total[]" id="price_'+i+'" class="form-control onChangeAmount" onKeyPress="amount()" onKeyUp="amount()"></td>';

 	html += '<td><input type="text" name="paid[]" id="paid_'+i+'" class="form-control onChangeAmountPaid" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;"></td>';
 	
 	html += '</tr>';
 	$('#table_auto').append(html);
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
 //total amount calculate
 $(document).on('change keyup blur','.onChangeAmount',function(){
     calculateTotal();
 });
 function calculateTotal(){
     total = 0;
     $('.onChangeAmount').each(function(){

         //alert(total);
         if($(this).val() != '' )total += parseFloat( $(this).val() );
         $("#total_amount").val(total);

         $("#total-due-amount").val(total);
     });
     calculateTotalPaid();
 }

 //total amount paid calculate
 $(document).on('change keyup blur','.onChangeAmountPaid',function(){
     calculateTotalPaid();
 });
 function calculateTotalPaid(){
     totalPaid = 0;
     $('.onChangeAmountPaid').each(function(){

         //alert(total);
         if($(this).val() != '' )totalPaid += parseFloat( $(this).val() );
         $("#amountPaid").val(totalPaid);
		 //check due
		 amount_due = parseFloat($("#total_amount").val()) - parseFloat( $("#amountPaid").val());
         $("#total-due-amount").val(amount_due);
     });

 }


