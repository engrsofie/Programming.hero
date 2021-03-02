<script type="text/javascript">
     /**
     * Site : http:www.smarttutorials.net
    //  * @author muni
    //  */
              
     //adds extra table rows
    <?php 
    for ($m=1; $m<=12; $m++) {
        $month_n[$m] = date('F', mktime(0,0,0,$m, 1, date('Y')));
        }
    ?>
    
     total_taka=0;
     var p=$('#table_auto tr').length;
     $(".addmore").on('click',function(){
        html = '<tr>';
        html += '<td><input class="case" type="checkbox"/></td>';
        html += '<td><input id="sl_number" class="form-control" type="text" value="'+p+'" readonly/></td>';
        
        html += '<td><input type="number" data-type="year" name="year[]" id="year_'+p+'" class="form-control autocomplete_txt" autocomplete="off" required="required" value="<?php echo date("Y"); ?>"></td>';

        html += '<td>{{Form::select("month[]",$month_n,date("m"),["class"=>"form-control","id"=>"select'+p+'","required"])}}</td>';
        html += '<td><input type="text" name="paid[]" id="paid_'+p+'" class="form-control onChangeAmountPaid" value="0" autocomplete="off"></td>';
        
        html += '</tr>';
        $('#table_auto').append(html);
        line_amount = $('#line_cost_amount').val();
        amount = $("#total_amount").val();
        total_taka = parseFloat(amount) + parseFloat(line_amount);  
        total_amount = $("#total_amount").val(total_taka); 
        console.log(total_amount);
        p++;

     });




      //to check all checkboxes
     $(document).on('change','#check_all',function(){
        $('input[class=case]:checkbox').prop("checked", $(this).is(':checked'));
     });

     //deletes the selected table rows
     $(".delete").on('click', function() {
        $('.case:checkbox:checked').parents("tr").remove();
        $('#check_all').prop("checked", false);
        line_amount = $('#line_cost_amount').val();
        amount = $("#total_amount").val();
        total_taka = parseFloat(amount) - parseFloat(line_amount); 
        if(total_taka<0){
            total_amount = $("#total_amount").val(0); 
        }else{
            total_amount = $("#total_amount").val(total_taka); 
        } 
         calculateTotal();
     });
     //total amount calculate
     $(document).on('change keyup blur','.onChangeAmount',function(){
         calculateTotal();
     });
    

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
    //
    $(document).on('change keyup blur','.onChangeQty',function(){
         calculateQty();
    });
    function calculateQty(){
         productQty = 0;
         $('.onChangeQty').each(function(){

             //alert(total);
            if($(this).val() != '' )productQty += parseFloat( $(this).val());
            qty_id = $(this).attr('id');
            qtyIdSplit=qty_id.split("_");
            salesPrice = $("#sales_price_"+qtyIdSplit[1]).val();

            salesParsent = $("#productDiscount_"+qtyIdSplit[1]).val();
            parsentWise = parseFloat(salesPrice)*parseFloat(salesParsent)/100;
            salesAmount = parseFloat(salesPrice)-parseFloat(parsentWise);

            productSalesAmount = parseFloat(salesAmount)*parseFloat(productQty);
            $("#productAmount_"+qtyIdSplit[1]).val(productSalesAmount);
            $("#total_amount").val(productSalesAmount);
            $("#total-due-amount").val(productSalesAmount);

            // parsentWise = parseFloat(salesPrice)*parseFloat(productQty)/100;
            // salesAmount = parseFloat(salesPrice)+parseFloat(parsentWise);
            // $("#productAmount_"+qtyIdSplit[1]).val(salesAmount);
         });

    }

    //
    $(document).on('change keyup blur','.onChangeProductDiscount',function(){
         calculateProductDiscount();
    });
    function calculateProductDiscount(){
         productDiscount = 0;
         $('.onChangeProductDiscount').each(function(){

             //alert(total);
            if($(this).val() != '' )productDiscount += parseFloat( $(this).val());
            discount_id = $(this).attr('id');
            console.log(discount_id);
            discountIdSplit=discount_id.split("_");
            salesPrice = $("#sales_price_"+discountIdSplit[1]).val();
            
            parsentWise = parseFloat(salesPrice)*parseFloat(productDiscount)/100;
            salesAmount = parseFloat(salesPrice)-parseFloat(parsentWise);

            productSalesAmount = parseFloat(salesAmount)*parseFloat(productQty);
            $("#productAmount_"+qtyIdSplit[1]).val(productSalesAmount);
            $("#total_amount").val(productSalesAmount);
            $("#total-due-amount").val(productSalesAmount);
         });

    }
    //
    $(document).on('change keyup blur','.onChangeAmountDiscount',function(){
         calculateTotalDiscount();
    });
    function calculateTotalDiscount(){
        totalDiscount = 0;
        $('.onChangeAmountDiscount').each(function(){
            //alert(total);
            if($(this).val() != '' )totalDiscount += parseFloat( $(this).val() );
            $("#discount").val(totalDiscount);
            
            totalPlaymentDiscount = parseFloat($("#amountPaid").val()) + parseFloat($("#discount").val());
            amount_due = parseFloat($("#total_amount").val()) - totalPlaymentDiscount;
            $("#total-due-amount").val(amount_due);
         });

    }

</script>
