
<?php $__env->startSection('content'); ?>
<style type="text/css">
    .form-group{overflow: hidden;}
    .form-control{height: 24px;padding: 5px;}
    .input-group-addon{padding: 4px 10px;}
</style>
<div id="content" class="content">
	<div class="row">
	    <div class="col-md-12">
            <div class="panel panel-inverse">
                <div class="panel-heading"> 
                    <div class="panel-heading-btn">
                        <a class="btn btn-info btn-xs" href="<?php echo e(URL::to('/pos-sales/create')); ?>">Refresh</a>
                        <a class="btn btn-info btn-xs" href="<?php echo e(URL::to('/inventory-product-sales')); ?>">View All</a>
                    </div>
                    <h4 class="panel-title"> Sales Product </h4>
                </div>
                <div class="panel-body min-padding">
                    <div class="col-md-8 no-padding-left">
                        <div class="col-md-12 no-padding">
                           <table class="table table-bordered table-hover" id="table_auto">
                                <thead>
                                    <tr class="active">
                                        <th width="15%"> Barcode </th>
                                        <th width="12%"> Product Name </th>
                                        <th width="10%"> Price </th>
                                        <th width="12%" colspan="2"> Quantity </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        
                                        <td><input type="text" autofocus="true" id="barcode" class="form-control" placeholder="Barcode" ></td>
                                        <td>
                                            <span id="product_name"></span>
                                            <input type="hidden" id="product_id">
                                            <input type="hidden" id="model">
                                        </td>

                                        <td>
                                            <span id="price"></span>
                                            <input type="hidden" id="priceInput">
                                        </td>

                                         <td><input type="number" min="0" step="any" id="quantity" class="form-control" autocomplete="off" ondrop="return false;" onpaste="return false;" placeholder="Quantity"><span class="text-danger" id="qtyAlert"></span></td>

                                        <td><span id="unit">Unit</span></td>
                                    </tr>
                                </tbody>
                            </table>
                            <hr>
                             <?php echo Form::open(array('route' => 'pos-sales.store','class'=>'form-horizontal sales-form','method'=>'POST','role'=>'form','data-parsley-validate novalidate')); ?>

                            <table class="table table-bordered table-hover" id="seassionTable">
                                <thead>
                                    <tr class="success">
                                        <th width="1%"> SL </th>
                                        <th width="12%"> Product Name </th>
                                        <th width="10%"> Unit Price </th>
                                        <th width="12%" colspan="2"> Quantity </th>
                                        <th width="10%"> Price </th>
                                        <th width="2%"> <i class="fa fa-trash"></i> </th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-md-4 posPaymentSummary">
                       
                        <div class="form-group">
                            <label class="col-md-5 control-label">Sub Total :</label>
                            <div class="input-group col-md-7">
                                <div class="input-group-addon currency">৳</div>
                                <input tabindex="-1" value="0" type="number" min="0" name="sub_total" step="any" class="form-control" id="subTotal" placeholder="Sub Total" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-5 control-label">Discount :</label>
                            <div class="input-group col-md-7">
                                <div class="input-group-addon currency">৳</div>
                                <input value="0" type="number" min="0" step="any" class="form-control changesNo" name="discount" id="discount" placeholder="Discount" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-5 control-label"><b>Total :</b></label>
                            <div class="input-group col-md-7">
                                <div class="input-group-addon currency">৳</div>
                                <input tabindex="-1" value="0" type="number" min="0" step="any" class="form-control" name="total_amount" id="total" placeholder="Total Amount" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="col-md-5 control-label">Paid Amount :</label>
                            <div class="input-group col-md-7">
                                <div class="input-group-addon currency">৳</div>
                                <input value="0" type="number" min="0" step="any" class="form-control" id="totalPaid" placeholder="Paid Amount" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="col-md-5 control-label">Change :</label>
                            <div class="input-group col-md-7">
                                <div class="input-group-addon currency">৳</div>
                                <input tabindex="-1" value="" type="number" min="0" step="any" class="form-control" id="change" placeholder="Change" readonly >
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-5 control-label">Paid :</label>
                            <div class="input-group col-md-7">
                                <div class="input-group-addon currency">৳</div>
                                <input value="0" type="number" min="0" step="any" class="form-control" name="total_paid" tabindex="-1" id="amountPaid" placeholder="Paid Amount" onkeypress="return IsNumeric(event);" readonly ondrop="return false;" onpaste="return false;">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="col-md-5 control-label">Amount Due :</label>
                            <div class="input-group col-md-7">
                                <div class="input-group-addon currency">৳</div>
                                <input tabindex="-1" value="" type="number" min="0" step="any" class="form-control amountDue" name="due"  id="amountDue" placeholder="Amount Due" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly >
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-5 control-label no-padding-right">Receive Method :</label>
                            <div class="input-group col-md-7">
                                <?php echo e(Form::select('fk_account_id',$accounts,1,['class'=>'form-control'])); ?>

                            </div>
                        </div>
                        <input type="hidden" name="fk_method_id" value="3">
                        <div class="form-group">
                            <label class="col-md-5 control-label">Trx No :</label>
                            <div class="input-group col-md-7">
                                <?php echo e(Form::text('ref_id','',['class'=>'form-control','placeholder'=>'Trx No'])); ?>

                            </div>
                        </div>
                                <?php echo e(Form::hidden('date',date('d-m-Y'))); ?>

                        <div class="form-group">
                            <label class="col-md-5 control-label">Client Name :</label>
                            <div class="input-group col-md-7">
                                <?php echo e(Form::text('client_name','',['class'=>'form-control','placeholder'=>'Client Name','id'=>'client_name','onkeypress'=>"autoCompleteClient('client_name')"])); ?>

                            </div>
                        </div>
                        <div class="form-group">
                               <button class="btn btn-primary col-md-12"><i class="fa fa-print"></i> Submit &amp; Print</button>

                        </div>
                    </div>
                    <?php echo e(Form::close()); ?>

                </div>
            </div>
        </div>
    </div>
</div>
<div id="loadPrint">a</div>

<?php $__env->stopSection(); ?>
<?php $__env->startSection('script'); ?>
<script src="<?php echo e(asset('public/custom_js/script_posSales.js')); ?>"></script> 
<?php if(isset($salesId) && $salesId!=''): ?>
<script src="<?php echo e(asset('public/custom_js/printThis.js')); ?>"></script>
<script type="text/javascript">
    
$('#loadPrint').load('<?php echo e(URL::to("pos-sales?id=$salesId")); ?>');
$('#loadPrint').printThis();
</script>
<?php endif; ?>
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
        });

    }
</script>

<?php $__env->stopSection(); ?>
<?php echo $__env->make('layout.app', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>