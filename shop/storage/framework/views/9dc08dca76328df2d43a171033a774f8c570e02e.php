
	
		<?php $__env->startSection('content'); ?>
		<!-- begin #content -->
		<div id="content" class="content">
			
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                                
                            </div>
                            <h4 class="panel-title">Brand </h4>
                        </div>
                        <div class="panel-body">
                        	<div class="create_button">
                        		<a href="ui_modal_notification.html#modal-dialog" class="btn btn-sm btn-success" data-toggle="modal">Add New Brand</a>
                        	</div>
                            <!-- #modal-dialog -->
                            <div class="modal fade" id="modal-dialog">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                    <?php echo Form::open(array('route' => 'inventory-brand.store','class'=>'form-horizontal author_form','method'=>'POST','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')); ?>

                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                            <h4 class="modal-title">Brand</h4>
                                        </div>
                                        <div class="modal-body">
                                        	<div class="form-group">
												<label class="control-label col-md-4 col-sm-4">Brand status :</label>
												<div class="col-md-2 col-sm-2">
													<div class="radio">
														<label>
															<input type="radio" name="status" value="1" id="radio-required" data-parsley-required="true" checked /> Active
														</label>
													</div>
												</div>
												<div class="col-md-4 col-sm-4">
													<div class="radio">
														<label>
															<input type="radio" name="status" id="radio-required2" value="0" /> Inactive
														</label>
													</div>
												</div> 
											</div>
                                            <div class="form-group">
			                                    <label class="control-label col-md-4 col-sm-4">Brand Name *:</label>
			                                    <div class="col-md-8 col-sm-8">
			                                     	<input type="text" class="form-control" name="brand_name" value="" placeholder="Enter Brand Name">
			                                    </div>
			                                </div>
			                                   
                                        </div>
                                        <div class="modal-footer">
                                            <a href="javascript:;" class="btn btn-sm btn-white" data-dismiss="modal">Close</a>
                                            <button type="submit" class="btn btn-sm btn-success">Confirm</button>
                                        </div>
                                    <?php echo Form::close();; ?>

                                    </div>
                                </div>
                            </div>    
                        </div>
                        <!--  -->
                        <div class="view_brand_set">
                        	<div class="panel-body">
	                            <table id="data-table" class="table table-striped table-bordered nowrap" width="100%">
	                                <thead>
	                                    <tr>
	                                        <th width="10%">Sl</th>
	                                        <th width="65%">Brand Name</th>
	                                        <th width="10%">status</th>
	                                        <th width="15%">Action</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <?php $i=0; ?>
	                                <?php $__currentLoopData = $getBrandData; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $brand): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
	                                <?php $i++; ?>
	                                    <tr class="odd gradeX">
	                                        <td><?php echo e($i); ?></td>
	                                        <td><?php echo e($brand->brand_name); ?></td>
	                                        <td>
	                                        	<?php if($brand->status=="1"): ?>
	                                        		<?php echo e("Active"); ?>

	                                        	<?php else: ?>
	                                        		<?php echo e("Inactive"); ?>

	                                        	<?php endif; ?>
	                                        </td>
	                                        <td>
	                                        <!-- edit section -->
	                                            <a href="ui_modal_notification.html#modal-dialog<?php echo $brand->id;?>" class="btn btn-sm btn-success" data-toggle="modal"><i class="fa fa-pencil-square-o" aria-hidden="true" style="font-size: 18px;"></i></a>
	                                            <!-- #modal-dialog -->
	                                            <div class="modal fade" id="modal-dialog<?php echo $brand->id;?>">
	                                                <div class="modal-dialog">
	                                                    <div class="modal-content">
	                                                    <?php echo Form::open(array('route' => ['inventory-brand.update',$brand->id],'class'=>'form-horizontal author_form','method'=>'PUT','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')); ?>

	                                                        <div class="modal-header">
	                                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                                                            <h4 class="modal-title">Modal Dialog</h4>
	                                                        </div>
	                                                        <div class="modal-body">
	                                                            
	                                                            <div class="form-group">
	                                                                <label class="control-label col-md-4 col-sm-4" for="brand_name">Brand Name * :</label>
	                                                                <div class="col-md-8 col-sm-8">
	                                                                    <input class="form-control" type="text" id="brand_name" name="brand_name" value="<?php echo $brand->brand_name; ?>" data-parsley-required="true" />
	                                                                </div>
	                                                            </div>
	                                                            
	                                                            <div class="form-group">
	                                                                <label class="control-label col-md-4 col-sm-4">Brand status :</label>
	                                                                <div class="col-md-3 col-sm-3">
	                                                                    <div class="radio">
	                                                                        <label>
	                                                                            <input type="radio" name="status" value="1" id="radio-required" data-parsley-required="true" <?php if($brand->status=="1"): ?><?php echo e("checked"); ?><?php endif; ?>> Active
	                                                                        </label>
	                                                                    </div>
	                                                                </div>
	                                                                <div class="col-md-4 col-sm-4">
	                                                                    <div class="radio">
	                                                                        <label>
	                                                                            <input type="radio" name="status" id="radio-required2" value="0" <?php if($brand->status=="0"): ?><?php echo e("checked"); ?><?php endif; ?>> Inactive
	                                                                        </label>
	                                                                    </div>
	                                                                </div> 
	                                                            </div>
	                                                           
	                                                        </div>
	                                                        
	                                                        <div class="modal-footer">
	                                                            <a href="javascript:;" class="btn btn-sm btn-white" data-dismiss="modal">Close</a>
	                                                            <button type="submit" class="btn btn-sm btn-success">Update</button>
	                                                        </div>
	                                                    <?php echo Form::close();; ?>

	                                                    </div>
	                                                </div>
	                                            </div>
	                                            <!-- end edit section -->

	                                            <!-- delete section -->
	                                            <?php echo Form::open(array('route'=> ['inventory-brand.destroy',$brand->id],'method'=>'DELETE')); ?>

	                                                <?php echo e(Form::hidden('id',$brand->id)); ?>

	                                                <button type="submit" onclick="return confirmDelete();" class="btn btn-danger">
	                                                  <i class="fa fa-trash-o" aria-hidden="true"></i>
	                                                </button>
	                                            <?php echo Form::close(); ?>

	                                            <!-- delete section end -->
	                                        </td>
	                                    </tr>
	                                <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
	                                </tbody>
	                            </table>
	                        </div>	
                        </div>
                    </div>
			    </div>
			</div>
		</div>
		<!-- end #content -->
		
    <script src="<?php echo e(asset('public/plugins/jquery/jquery-1.9.1.min.js')); ?>"></script>        
    <script type="text/javascript">
    	$(document).ready(function() {
	        App.init();
	        DashboardV2.init();
	        //
	    });
    </script>
    <?php $__env->stopSection(); ?>

<?php echo $__env->make('layout.app', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>