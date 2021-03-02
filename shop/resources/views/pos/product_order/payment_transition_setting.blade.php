<script type="text/javascript">
    
    
     total_taka=0;
     var p=$('#table_auto tr').length;
     $(".addmore").on('click',function(){
        html = '<tr>';
        html += '<td><input class="case" type="checkbox"/></td>';
        html += '<td><input id="sl_number" class="form-control" type="text" value="'+p+'" readonly/></td>';
        html += '<td><select name="fk_product_id[]" class="form-control select"><option> - select - </option>@foreach($getProductData as $product)<option value="{{$product->id}}"> {{$product->product_name}} </option>@endforeach</select></td>';
        
        
        html += '<td><input type="number" min="0" name="cost_per_unit[]" id="cost-per-unit_'+p+'" class="form-control onChangeCostPerUnit" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" value="0"></td>';
        html += '<td><input type="number" min="0" name="benefit[]" id="benefit_'+p+'" class="form-control onChangeAmountBenefit" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" value="0"></td>';
        html += '<td><input type="number" min="0" name="sales_per_unit[]" id="sales-per-unit_'+p+'" class="form-control onChangeAmountSales" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" value="0"></td>';

        html += '<td><input type="number" min="1" name="qty[]" id="qty_'+p+'" class="form-control onChangeQty" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" value="1"></td>';

        
        html += '<td><input type="number" name="paid[]" id="paid_'+p+'" class="form-control onChangeAmountPaid" value="0" autocomplete="off"></td>';
        
        html += '</tr>';
        $('#table_auto').append(html);
        
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
        // line_amount = $('#line_cost_amount').val();
        // amount = $("#total_amount").val();
        // total_taka = parseFloat(amount) - parseFloat(line_amount); 
        // if(total_taka<0){
        //     total_amount = $("#total_amount").val(0); 
        // }else{
        //     total_amount = $("#total_amount").val(total_taka); 
        // } 
         calculateTotal();
     });
     //total amount calculate
     $(document).on('change keyup blur','.onChangeAmount',function(){
         calculateTotal();
     });
    

    $(document).on('change keyup blur','.onChangeCostPerUnit',function(){
         calculateTotalCost();
    });
    function calculateTotalCost(){
         totalCost = 0;
         $('.onChangeCostPerUnit').each(function(){

             //alert(total);
             //console.log(totalCost);
            if($(this).val() != '' )totalCost += parseFloat( $(this).val() );
            cost_id = $(this).attr('id');
            costIdSplit=cost_id.split("_");
            cost = $(this).val();
            $("#total_amount").val(totalCost);
             //check sales per unit
            benefit = $("#benefit_"+costIdSplit[1]).val();
            parsentWise = parseFloat(cost)*parseFloat(benefit)/100;
            salesAmount = parseFloat(cost)+parseFloat(parsentWise);
            $("#sales-per-unit_"+costIdSplit[1]).val(salesAmount);

             // //check due
             // amount_due = parseFloat($("#total_amount").val()) - parseFloat( $("#amountPaid").val());
             // $("#total-due-amount").val(amount_due);
         });

    }
    //
    $(document).on('change keyup blur','.onChangeAmountBenefit',function(){
         calculateTotalParsent();
    });
    function calculateTotalParsent(){
        totalParsent = 0;
        $('.onChangeAmountBenefit').each(function(){
            //alert(total);
            if($(this).val() != '' )totalParsent += parseFloat( $(this).val() );
            benefit_id = $(this).attr('id');
            benefitIdSplit=cost_id.split("_");
            benefit = $(this).val();
            cost = $("#cost-per-unit_"+benefitIdSplit[1]).val();
            parsentWise = parseFloat(cost)*parseFloat(benefit)/100;
            salesAmount = parseFloat(cost)+parseFloat(parsentWise);
            $("#sales-per-unit_"+benefitIdSplit[1]).val(salesAmount);
            
         });

    }
    $(document).on('change keyup blur','.onChangeQty',function(){
         calculateQty();
    });
    function calculateQty(){
        totalQty = 0;
        $('.onChangeQty').each(function(){
            //alert(total);
            if($(this).val() != '' )totalQty += parseFloat( $(this).val() );
            qty_id = $(this).attr('id');
            qtyIdSplit=cost_id.split("_");
            qty = $(this).val();
            cost = $("#cost-per-unit_"+qtyIdSplit[1]).val();
            totalPrice = parseFloat(cost)*parseFloat(qty);
            // oldAmount = $("#total_amount").val();
            // newAmount = parseFloat(totalPrice)+parseFloat(oldAmount);
            // $("#total_amount").val(newAmount);
            // $("#total-due-amount_"+qtyIdSplit[1]).val(totalPrice);
            calculateTotal();

            
         });

    }
    //
    $(document).on('change keyup blur','.onChangeAmountPaid',function(){
         calculatePaid();
    });
    function calculatePaid(){
        totalPaid = 0;
        $('.onChangeAmountPaid').each(function(){
            //alert(total);
            if($(this).val() != '' )totalPaid += parseFloat( $(this).val() );
            paid_id = $(this).attr('id');
            paidIdSplit=cost_id.split("_");
            amount_due = parseFloat($("#total_amount").val()) - parseFloat(totalPaid);
            $("#total-due-amount").val(amount_due);
            $("#amountPaid").val(totalPaid);

            
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
