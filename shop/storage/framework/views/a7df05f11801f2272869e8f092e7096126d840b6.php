

	<?php $__env->startSection('content'); ?>
	<!-- begin #content -->
	<div id="content" class="content min-form" style="min-height: 700px;">
		<div class="row">
		    <div class="col-md-12">
                <div class="panel panel-inverse">
                    <div class="panel-heading"> 
                        <h4 class="panel-title">Item Sales</h4>
                    </div>
                    <!-- <input type="text" style="border:0;border-color: #fff;outline: 0;height: 1px;color: #fff"> -->
                    <div class="panel-body" id="tabArea">
                        <?php echo Form::open(array('route' => 'inventory-product-sales.store','class'=>'form-horizontal sales-form','method'=>'POST','role'=>'form','data-parsley-validate novalidate')); ?>

							
                            <div class="">
                                <!-- info -->
                                <div class="row">
                                    <div class="form-group col-md-5">
                                        <label class=" col-md-12" >Organization Name :</label>
                                            <div class="col-md-10">
                                                <input type="text" name="client_name" class="form-control" autofocus id="client_name" onkeypress="autoCompleteClient('client_name')" required>
                                                <span class="text-danger" id="client_help"></span>
                                            </div>
                                    </div>
                                    <div class="form-group col-md-3">
                                        <label class=" col-md-12" for="Date">Date * :</label>
                                        <div class="col-md-12">
                                            <input class="form-control datepicker" type="text" name="date" value="<?php echo date('d-m-Y'); ?>" placeholder="t_date" data-parsley-required="true" />
                                        </div>
                                    </div>
                                    <div class="form-group col-md-3">
                                        <label class=" col-md-12" for="Date"> Order ID :</label>
                                        <div class="col-md-12">
                                            <input class="form-control" type="text" name="order_id" value="" placeholder=" Order ID" />
                                        </div>
                                    </div>
                                    
                                     
                                </div>
                                <input type="hidden" name="created_by" value="<?php echo e(Auth::user()->id); ?>">
                                <!-- transition -->
                                <div class="view_center_folwchart">
                                <div class='row'>
                                    <div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
                                        <table class="table table-bordered table-hover" id="table_auto">
                                            <thead>
                                                <tr>
                                                    <th width="1%"><input tabindex="-1" id="check_all" type="checkbox"/></th>
                                                    <th width="10%"> Available Qty </th>
                                                    <th width="18%"> Product Name </th>
                                                    <th width="15%" colspan="2"> Quantity </th>
                                                    <th width="10%"> Cost Price </th>
                                                    <th width="10%"> Sales Price </th>
                                                    <th width="15%"> Price </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td><input tabindex="-1" class="case" type="checkbox"/></td>
                                                    <td><input type="text" tabindex="-1" min="0" step="any" name="avaliable_qty[]" id="quantity_1" class="form-control changesNo avaliable_qty" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly="readonly"></td>

                                                    <td><input type="text" data-type="product_name" name="product_name[]" id="itemName_1" required class="form-control autocomplete_txt" autocomplete="off">
                                                    <input type="hidden" data-type="product_name" name="fk_product_id[]" id="itemId_1" class="form-control" autocomplete="off">
                                                    <input type="hidden" name="fk_model_id[]" id="model_1" class="form-control"></td>
                                                     <td><input type="number" min="0" name="sales_qty[]" step="any" id="quantity2_1" class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" placeholder="Quantity"></td>

                                                    <td><span id="smallUnit_1">Unit</span></td>
                                                    <td>
                                                    <button onclick="costPrice(this.id)" id="costPrice_1" data="0" type="button" class="btn btn-default form-control costPrice">Click</button>
                                                    </td>
                                                    <td><input type="text" name="product_price_amount[]" id="hidden_1" class="form-control sales_price changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;"></td>

                                                    <td><input tabindex="-1" type="number" min="0" step="any" name="product_paid_amount[]" id="total_1" class="form-control totalLinePrice" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly="readonly">

                                                    <input type="hidden" min="0" step="any" name="price[]" id="cost_1" class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" >
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class='row'>
                                    <div class='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
                                        <button class="btn btn-success addmore" type="button">+ Add More</button>
                                        <button class="btn btn-danger delete" type="button">- Delete</button>
                                    </div>
                                </div>
                                <br>
                                <div class='row'>   
                                    <div class='col-xs-12 col-sm-7 col-md-7 col-lg-7'>
                                        <input type="hidden" name="fk_user_id" value="<?php echo e(Auth::user()->id); ?>">
                                        <div class="form-group">
                                            <label class="col-md-4 control-label">Sales or Order :</label>
                                            <div class="col-md-8">
                                               <label><input tabindex="-1" type="radio" value="1" name="sales_type" checked required> Sales</label>
                                               <label><input tabindex="-1" type="radio" value="0" name="sales_type" required> Order</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class='col-xs-12 col-sm-5 col-md-5 col-lg-5'>
                                        <span class="form-inlines">
                                            <div class="form-group">
                                                <label class="col-md-4 control-label">Sub Total :</label>
                                                <div class="input-group col-md-8">
                                                    <div class="input-group-addon currency">৳</div>
                                                    <input tabindex="-1" value="0" type="number" min="0" name="sub_total" step="any" class="form-control" id="subTotal" placeholder="Sub Total" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-4 control-label">Discount :</label>
                                                <div class="input-group col-md-8">
                                                    <div class="input-group-addon currency">৳</div>
                                                    <input value="0" type="number" min="0" step="any" class="form-control changesNo" name="discount" id="discount" placeholder="Discount" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-4 control-label"><b>Total :</b></label>
                                                <div class="input-group col-md-8">
                                                    <div class="input-group-addon currency">৳</div>
                                                    <input tabindex="-1" value="0" type="number" min="0" step="any" class="form-control" name="total_amount" id="total" placeholder="Total Amount" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly>
                                                </div>
                                            </div>
                                        <div id="clientPrev">
                                         <div class="form-group">
                                            <label class="col-md-4 control-label">Previous Due :</label>
                                            <div class="input-group col-md-8">
                                                <div class="input-group-addon currency">৳</div>
                                                <input tabindex="-1" value="0" type="number" min="0" step="any" class="form-control" name="prev_amount" id="prev_amount" placeholder="Previous Amount" readonly>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-md-4 control-label"><b> Grand Total: </b></label>
                                            <div class="input-group col-md-8">
                                                <div class="input-group-addon currency">৳</div>
                                                <input tabindex="-1" value="" type="number" min="0" step="any" class="form-control" name="grand_total" id="grandTotal" placeholder="Total Amount" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly>
                                            </div>
                                        </div>
                                        </div>
                                        <div id="payment">
                                            
                                            <div class="form-group aside_system">
                                                <label class="col-md-4">Paid Amount :</label>
                                                <div class="input-group col-md-8">
                                                    <div class="input-group-addon currency">৳</div>
                                                    <input value="0" type="number" min="0" step="any" class="form-control" name="total_paid" id="amountPaid" placeholder="Paid Amount" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;">
                                                </div>
                                            </div>
                                            
                                            <div class="form-group aside_system">
                                                <label class="col-md-4">Amount Due :</label>
                                                <div class="input-group col-md-8">
                                                    <div class="input-group-addon currency">৳</div>
                                                    <input tabindex="-1" value="" type="number" min="0" step="any" class="form-control amountDue" name="due"  id="amountDue" placeholder="Amount Due" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly >
                                                </div>
                                            </div>
                                            <input type="hidden" name="fk_account_id" value="1">
                                            <input type="hidden" name="fk_method_id" value="3">
                                        </div>
                                            
                                        </span>
                                    </div>
                                </div>

                            </div>
                            </div>

							<div class="form-group">
								<label class="control-label col-md-2 col-sm-2"></label>
								<div class="col-md-8 col-sm-8">
                                <br>
									<button type="submit" class="btn btn-primary" style="width: 100%;">Confirm</button>
								</div>
                                <label class="control-label col-md-2 col-sm-2"></label>
							</div>
                        <?php echo Form::close();; ?>

                    </div>
                </div>
		    </div>
		</div>
	</div>
	<!-- end #content -->
<?php $__env->stopSection(); ?>
<?php $__env->startSection('script'); ?>
<script src="<?php echo e(asset('public/custom_js/script_sales.js')); ?>"></script> 

<script type="text/javascript">
    function client_info($id){
        var total = $('#grandTotal').val();
        $('#clientPrev').load("<?php echo e(URL::to('loadClientPrev')); ?>/"+$id+"/"+total);
    }

  function costPrice(id){

    var data = $('#'+id).attr('data');
    var html = $('#'+id).html();
    if(html==='Click'){
        $('#'+id).html(data);
    }else{
        $('#'+id).html('Click');
    }
  }
</script>
<script type="text/javascript">
    var path=$('#rootUrl').val();
    function autoCompleteClient(id){
        $('#'+id).autocomplete({
            source: function( request, response ) {
                $.ajax({
                    //url: "<?php echo e(URL::to('inventory-product-search')); ?>",
                    url: path+'/search-client/',
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
                var total = parseFloat($('#total').val());
                $('#prev_amount').val(names[1]);
                $('#grandTotal').val(parseFloat(names[1])+total);
                calculateAmountDue();
            }       
        });

    }
    
</script>
<?php $__env->stopSection(); ?>
<?php echo $__env->make('layout.app', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>