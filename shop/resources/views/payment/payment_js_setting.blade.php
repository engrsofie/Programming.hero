<script src="{{ asset('public/js/chosen.jquery.js') }}" type="text/javascript"></script> 

<script type="text/javascript">
// disable mousewheel on a input number field when in focus
// (to prevent Cromium browsers change the value when scrolling)
$('form').on('focus', 'input[type=number]', function (e) {
  $(this).on('mousewheel.disableScroll', function (e) {
    e.preventDefault()
  })
})
$('form').on('blur', 'input[type=number]', function (e) {
  $(this).off('mousewheel.disableScroll')
})
     /**
     * Site : http:www.smarttutorials.net
    //  * @author muni
    //  */
              
     //adds extra table rows
     var i=$('#table_auto tr').length;
     $(".addmore").on('click',function(){
        html = '<tr>';
        html += '<td><input class="case" type="checkbox"/></td>';
        html += '<td><select name="fk_sub_category_id[]" data-placeholder="- Select -" class="select form-control" tabindex="10" required="required"><option value="">Please choose</option><?php foreach ($subCategories as $subCategory){ ?><option value="<?php echo $subCategory->id; ?>"><?php echo $subCategory->sub_category_name; ?></option><?php } ?></select></td>';
        html += '<td><input type="text" data-type="description" name="description[]" id="description_'+i+'" class="form-control autocomplete_txt" autocomplete="off"></td>';

        html += '<td><input type="number" step="any" min="0" name="total[]" id="price_'+i+'" class="form-control onChangeAmount" onKeyPress="amount(this.value,'+i+')" onKeyUp="amount(this.value,'+i+')"></td>';

        html += '<td><input type="number" step="any" min="0" name="paid[]" id="paid_'+i+'" class="form-control onChangeAmountPaid" autocomplete="off"></td>';
        
        html += '</tr>';
        $('#table_auto').append(html);
        i++;
        $('.select').chosen("liszt:updated");

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
         //$('#testField').val(123);
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
     function amount($value,$id){
        $('#paid_'+$id).attr('max',$value);
     }
     var path=$('#rootUrl').val();
     function autoComplete(id){
        $('#'+id).autocomplete({
            source: function( request, response ) {
                $.ajax({
                    //url: "{{URL::to('inventory-product-search')}}",
                    url: path+'/payment-client',
                    type: "GET",
                    dataType: "json",
                    data: {
                        name: request.term,
                        },
                    success: function( data ) {
                        //console.log(data);
                         response( $.map( data, function( item ) {
                            var code = item.split("|");
                            return {
                                label: code[0],
                                value: code[0],
                                data:item
                            }
                        }));
                    }
                });

                
            },

            autoFocus: true ,
            minLength: 0,
            select: function( event, ui ) {
                var names = ui.item.data.split("|");
                var id = $(this).attr('id');
                $('#'+id+'_h').val(names[1]);
            }       
        });

    }

</script>