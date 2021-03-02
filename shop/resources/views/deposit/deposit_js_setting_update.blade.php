
<script type="text/javascript">

     //adds extra table rows
     var i=0;
     var selectItemId= new Array();
     $(".addmore").on('click',function(){
        html = '<tr>';
        html += '<td><input class="case" type="checkbox"/></td>';
        html += '<td><select name="fk_sub_category_id_new[]" data-placeholder="- Select -" class="chosen-select-category'+i+' form-control" tabindex="10" required="required"><option value="">Please choose</option><?php foreach ($subCategories as $subCategory){ ?>@if($subCategory->sub_category_type=="Deposit")<option value="<?php echo $subCategory->id; ?>"><?php echo $subCategory->sub_category_name; ?></option>@endif<?php } ?></select></td>';
        html += '<td><input type="text" data-type="description_new" name="description_new[]" id="description_'+i+'" class="form-control autocomplete_txt" autocomplete="off"></td>';

        html += '<td><input type="number" min="0" name="total_new[]" id="price_'+i+'" class="form-control onChangeAmount" onKeyPress="amount()" onKeyUp="amount()"></td>';

        html += '<td><input type="text" name="paid_new[]" id="paid_'+i+'" class="form-control onChangeAmountPaid" autocomplete="off"></td>';
        
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
         var selectItemId=$('.case:checkbox:checked').parents("tr").find(".deposit_item_old_id");
        console.log(selectItemId);
         for (var i = 0; i < selectItemId.length; i++) {
             var allItemSet = selectItemId[i];
             var itemId = $(allItemSet).attr('id');
             $('<input name="deleteItem[]" type="hidden" />').appendTo(".deleteItemList").val(itemId);
         }
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

</script>