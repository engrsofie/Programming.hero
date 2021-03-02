
<?php $__env->startSection('content'); ?>
<div id="content" class="content">
	<div class="row">
	    <div class="col-md-12">
            <div class="panel panel-inverse">
                <div class="panel-heading"> 
                    <div class="panel-heading-btn">
                            <a class="btn btn-info btn-xs" href="<?php echo e(URL::to('/inventory-transfer')); ?>">View All</a>
                            
                        </div>
                    <h4 class="panel-title">Product Transfer</h4>
                </div>
                <div class="panel-body">
                	 <?php echo Form::open(array('route' => 'inventory-transfer.store','class'=>'form-horizontal author_form','method'=>'POST','role'=>'form','data-parsley-validate novalidate')); ?>

                     <div class="col-md-12 no-padding">
                         <div class="form-group col-md-4">
                             <label class="col-md-12">Transfer From :</label>
                             <div class="col-md-12">
                                <?php if(Auth::user()->isRole('administrator')): ?>
                                 <?php echo e(Form::select('transfer_from',$branch,Auth::user()->fk_branch_id,['class'=>'form-control','id'=>'transferFrom','required'])); ?>

                                <?php else: ?>
                                    <span class="form-control"><?php echo e($ownBranch->branch_name); ?></span>
                                    <input type="hidden" name="transfer_from" value="<?php echo e($ownBranch->id); ?>">
                                <?php endif; ?>
                             </div>
                         </div>
                         <div class="form-group col-md-4">
                             <label class="col-md-12">Transfer To :</label>
                             <div class="col-md-12">
                                 <?php echo e(Form::select('transfer_to',$branch,'',['class'=>'form-control','id'=>'transferTo','required','placeholder'=>'Select Branch'])); ?>

                             </div>
                         </div>
                         <div class="form-group col-md-4">
                             <label class="col-md-12">Date :</label>
                             <div class="col-md-12">
                                 <input type="text" name="date" placeholder="Date" class="form-control datepicker" value="<?php echo e(date('d-m-Y')); ?>">
                             </div>
                             
                         </div>
                     </div>
                    <table class="table table-bordered table-hover" id="table_auto">
                        <thead>
                            <tr>
                                <th width="1%"></th>
                                <th width="20%"> Product Name </th>
                                <th width="10%"> Available </th>
                                <th width="10%"> Qty </th>
                                <th width="15%"> Cost Per Unit </th>
                                <th width="12%"> Sub Total </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><input tabindex="-1" class="case" type="checkbox"/></td>
                                <td><input type="text" data-type="product_name" name="product_name[]" required id="itemName_1" class="form-control autocomplete_txt" autocomplete="off">
                                <input type="hidden" required name="fk_product_id[]" id="itemId_1" class="form-control" autocomplete="off">
                                <input type="hidden" required name="fk_model_id[]" id="model_1" class="form-control"></td>

                                <td><input type="text" tabindex="-1" min="0" step="any" name="avaliable_qty[]" id="quantity_1" class="form-control changesNo" readonly="readonly"></td>    
                                <td><input type="number" min="0" name="qty[]" step="any" id="qty_1" class="form-control changesNo" autocomplete="off" required onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" placeholder="Qty"></td>
                                <td><input type="number" min="0" name="cost_per_unit[]" step="any" id="cost_1" class="form-control changesNo" autocomplete="off" required onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" placeholder="Cost Per Unit"></td>
                                <td>
                                    <input type="number" name="sub_total[]" step="any" readonly id="subTotal_1" tabindex="-1" class="form-control subTotal" >
                                </td>

                            </tr>
                        </tbody>
                    </table> 
                    <div class='row'>
                        <div class='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
                            <button class="btn btn-success addmore" type="button">+ Add More</button>
                            <button class="btn btn-danger delete" type="button">- Delete</button>
                        </div>
                    </div><br> 
                     <div class='row'>   
                        <div class='col-xs-12 col-sm-7 col-md-7 col-lg-7'>
                            <div class="form-group">
                                <label class="col-md-3 control-label">Comments :</label>
                                  <div class="col-md-9">
                                    <textarea tabindex="-1" name="details" rows="2" class="form-control" placeholder="Write something about transfer."></textarea>
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
                                            <input tabindex="-1" value="" type="number" min="0" step="any" class="form-control" name="total_amount" id="total" placeholder="Sub Total" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly>
                                        </div>
                                    </div>
                                
                            </span>
                        </div>
                    </div>
                    <div class="form-group">
						<label class="control-label col-md-2 col-sm-2"></label>
						<div class="col-md-8 col-sm-8">
                        
							<button type="submit" class="btn btn-primary" style="width: 100%;">Confirm</button>
						</div>
                        <label class="control-label col-md-2 col-sm-2"></label>
					</div>
                    <?php echo Form::close();; ?>     
					<br>
                </div>
            </div>
        </div>
    </div>
</div>
<?php $__env->stopSection(); ?>
<?php $__env->startSection('script'); ?>
<script src="<?php echo e(asset('public/custom_js/transfer.js')); ?>"></script>

<script type="text/javascript">
    $(document).on('focus','.autocomplete_txt',function(){
     type = $(this).data('type');
    
    if(type =='product_name')autoTypeNo=0;  
    var branch = $('#transferFrom').val();
    $(this).autocomplete({
        source: function( request, response ) {

            _token = $('input[name="_token"]').val();
            $.ajax({
                url: "<?php echo e(URL::to('branch-wise-search')); ?>",
                type: "GET",
                dataType: "json",
                data: { _token : _token,
                    name_startsWith: request.term,
                    type: type,
                    branch: branch,
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
            $('#model_'+id[1]).val(names[2]);
            $('#quantity_'+id[1]).val(names[3]);
            $('#cost_'+id[1]).val(names[4]);
            $('#qty_'+id[1]).val(1);
            $('#qty_'+id[1]).attr('max',names[3]);
            $('#subTotal_'+id[1]).val( 1*names[4] );
            $('#qty_'+id[1]).focus();
            calculateTotal();
        }               
    });
  
});

</script>
<?php $__env->stopSection(); ?>
<?php echo $__env->make('layout.app', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>