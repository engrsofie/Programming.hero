
	<?php $__env->startSection('content'); ?>
    <style type="text/css">

    </style>
	<!-- begin #content -->
	<div id="content" class="content">
		<div class="row">
		    <div class="col-md-12">
                <div class="panel panel-inverse">
                    <div class="panel-heading"> 
                        <div class="panel-heading-btn">
                                <a class="btn btn-info btn-xs" href="<?php echo e(URL::to('/inventory-product-add')); ?>">All Added Product</a>
                                
                            </div>
                        <h4 class="panel-title">Add Product</h4>
                    </div>
                    <div class="panel-body no-padding">
                        <?php echo Form::open(array('route' => 'inventory-product-add.store','class'=>'form-horizontal purchase-form','method'=>'POST','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')); ?>

                            <div class="col-md-12">
                                
                                <input type="hidden" name="created_by" value="<?php echo e(Auth::user()->id); ?>">
                                <!-- transition -->
                                <div class="view_center_folwchart">
                                <div class='row'>
                                    <div class="col-md-12">
                                        <br>
                                        <div class="form-group col-md-4 no-padding">
                                            <label class=" col-md-12">Company Name :</label>
                                            <div class="col-md-12">
                                                <input type="text" name="supplier_name" id="supplier_name" autofocus onkeypress="autoCompleteSupplier(this.id)" class="form-control" required>
                                                 <input type="hidden" name="supplierId" id="supplier_name_h">
                                            </div>
                                        </div>
                                        <div class="form-group col-md-5">
                                            <label class="col-md-12">Challan Id :</label>
                                            <div class="col-md-12">
                                                <input type="text" tabindex="-1" class="form-control" name="challan_id" value="<?php echo e($invoice); ?>">
                                            </div>
                                        </div>

                                        <div class="form-group col-md-4 pull-right">
                                            <label class="col-md-12">Date :</label>
                                            <div class="col-md-12">
                                                <input type="text" name="date" value="<?php echo e(date('d-m-Y')); ?>" class="form-control datepicker">
                                            </div>
                                        </div>
                                    </div>
                                    <div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
                                        <table class="table table-bordered table-hover" id="table_auto">
                                            <thead>
                                                <tr>
                                                    <th width="2%"><input tabindex="-1" id="check_all" class="formcontrol" type="checkbox"/></th>
                                                    <th width="15%">Product Name</th>
                                                    <th>Product Model</th>
                                                    <th colspan="2" width="15%">Quantity</th>
                                                    <th>Cost Per Unit</th>
                                                    <th>Sales Per Unit</th>
                                                    <th width="15%">Sub Total</th>
                                                    <th width="15%">Branch</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td><input tabindex="-1" class="case" type="checkbox"/></td>
                                                    
                                                    <td> 
                                                    <input type="text" data-type="product_name" id="itemName_1" class="form-control autocomplete_txt" autocomplete="off">
                                                        <input type="hidden" data-type="product_name" name="fk_product_id[]" id="itemId_1" class="form-control autocomplete_txt" autocomplete="off" placeholder="Cost per unit">
                                                        
                                                    </td>
                                                    <td>
                                                        <input type="text" name="product_model[]" id="productModel_1" class="form-control" placeholder="Model">
                                                    </td>
                                                    <td>
                                                        <input type="number" min="0" step="any" name="qty[]" id="quantity2_1" class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" placeholder="Quantity">
                                                        
                                                    </td>
                                                    <td><span id="uom_1">Unit</span> </td>
                                                    <td>
                                                        <input type="number" min="0" step="any" name="cost_per_unit[]" id="cost_1" class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" placeholder="Unit Price" > 
                                                    </td>
                                                    <td>
                                                        <input tabindex="-1" type="number" min="0" step="any" name="sales_per_unit[]" class="form-control" placeholder=" Sales Price" > 
                                                    </td>
                                                    
                                                    
                                                    <td>
                                                        <input placeholder="Sub Total" type="number" min="0" step="any" name="amount[]" id="total_1" class="form-control totalLinePrice" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly tabindex="-1">
                                                        
                                                    </td>
                                                    <td>
                                                        <div id="stockPosition-1">
                                                        <?php if(Auth::user()->isRole('administrator')): ?>
                                                            <?php echo e(Form::select('fk_branch_id[]',$branch,Auth::user()->fk_branch_id,['class'=>'form-control branchSelect','required'])); ?>

                                                        <?php else: ?>
                                                            <span><?php echo e($ownBranch->branch_name); ?></span>
                                                            <input type="hidden" name="fk_branch_id[]" value="<?php echo e($ownBranch->id); ?>">
                                                        <?php endif; ?>
                                                        </div>
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
                                        <div class="form-group">
                                            <label class="col-md-3 control-label">Comments :</label>
                                              <div class="col-md-9">
                                                <textarea tabindex="-1" name="summary" rows="2" class="form-control " placeholder="Write something about order."></textarea>
                                              </div>
                                        </div>
                                        <div>
                                      </div>
                                        
                                    </div>
                                    <div class='col-xs-12 col-sm-5 col-md-5 col-lg-5'>
                                        <span class="form-inlines">
                                                <div class="form-group aside_system">
                                                    <label class="col-md-4">Total Amount :</label>
                                                    <div class="input-group col-md-8">
                                                        <div class="input-group-addon currency">৳</div>
                                                        <input tabindex="-1" value="" type="number" min="0" step="any" class="form-control" name="total_amount" id="subTotal" placeholder="Sub Total" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly>
                                                    </div>
                                                </div>
                                                <div class="form-group aside_system">
                                                    <label class="col-md-4">Total Paid :</label>
                                                    <div class="input-group col-md-8">
                                                        <div class="input-group-addon currency">৳</div>
                                                        <input value="" type="number" min="0" step="any" class="form-control" name="total_paid" id="subTotal" placeholder="Total Paid">
                                                    </div>
                                                </div>
                                            
                                        </span>
                                    </div>
                                </div>

                            </div>
                            </div>

                            <div class="form-group col-md-12">
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
	
<script src="<?php echo e(asset('public/plugins/jquery/jquery-1.9.1.min.js')); ?>"></script>
<script src="<?php echo e(asset('public/custom_js/script_add_product.js')); ?>"></script>

<?php $__env->stopSection(); ?>
<?php $__env->startSection('script'); ?>
<script type="text/javascript">
    var path=$('#rootUrl').val();
    function autoCompleteSupplier(id){
        $('#'+id).autocomplete({
            source: function( request, response ) {
                $.ajax({
                    //url: "<?php echo e(URL::to('inventory-product-search')); ?>",
                    url: path+'/search-supplier/',
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
    $(document).on('mousedown keypress','.branchSelect',function(){
        var id = $(this).parent().attr('id');
        $('#'+id+' .branchSelect option').removeAttr('selected');
    });
    $(document).on('change','.branchSelect',function(){
        var val = $(this).val();
        var id = $(this).parent().attr('id');
        $('#'+id+' .branchSelect option[value='+val+']').attr('selected','selected');
    });
</script>
<?php $__env->stopSection(); ?>

<?php echo $__env->make('layout.app', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>