
	
		<?php $__env->startSection('content'); ?>
		<!-- begin #content -->
		<div id="content" class="content">
			
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                                <a class="btn btn-xs btn-info" href="<?php echo e(URL::to('/bill')); ?>">Transfer List</a>
                            </div>
                            <h4 class="panel-title">Balance Transfer </h4>
                        </div>
                        <div class="panel-body">
                            <?php echo Form::open(array('route' => 'bill.store','class'=>'form-horizontal author_form','method'=>'POST','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')); ?>

                            	<div class="form-group">
									<label class="control-label col-md-4 col-sm-4" for="Date">Date * :</label>
									<div class="col-md-6 col-sm-6">
										<input class="form-control" type="date" id="Date" name="t_date" placeholder="t_date" data-parsley-required="true" value="<?php echo date('Y-m-d'); ?>" />
									</div>
								</div>
								<div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4" for="from_account">From Account * :</label>
                                <div class="col-md-6 col-sm-6">
                                       <select onchange="loadAmount(this.value)" name="from_account" class="form-control" required>
                                 <option value="">Select Account</option>
                                 <?php $__currentLoopData = $getAccount; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $account): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                 <option value="<?php echo e($account->id); ?>"><?php echo e($account->account_name); ?></option>
                                 <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                 </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4" for="to_account">To Account * :</label>
                                    <div class="col-md-6 col-sm-6">
                                       <select name="to_account" class="form-control" required >
                                 <option value="">Select Account</option>
                                 <?php $__currentLoopData = $getAccount; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $account): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                 <option value ="<?php echo e($account->id); ?>"><?php echo e($account->account_name); ?></option>
                                 <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                 </select>
                                    </div>
                                </div>

                              <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4" for="to_account">Payment Method * :</label>
                                    <div class="col-md-6 col-sm-6">
                                       <select name="method" class="form-control" rows = "8" >
                                 <option>Select Method</option>
                                 <?php $__currentLoopData = $getMethodData; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $payment): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                 <option value="<?php echo e($payment->id); ?>"><?php echo e($payment->method_name); ?></option>
                                 <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                 </select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="control-label col-md-4 col-sm-4" for="account_name">Amount * :</label>
                                    <div class="col-md-6 col-sm-6">
                                        <input class="form-control" type="number" id="amount" name="amount" step="any" min="0" placeholder="Amount">
                                        <small>Balance : <span id="balance"></span></small>
                                    </div>
                                </div> 
                                <div class="form-group">
									<label class="control-label col-md-4 col-sm-4" for="account_name">Bill Description * :</label>
									<div class="col-md-6 col-sm-6">
										<textarea class="form-control" id="address" name="description" rows="4"  placeholder="Description"></textarea>
									</div>
								</div>

								<div class="form-group">
									<label class="control-label col-md-4 col-sm-4"></label>
									<div class="col-md-6 col-sm-6">
										<button type="submit" class="btn btn-primary">Submit</button>
									</div>
								</div>
                            <?php echo Form::close();; ?>

                        </div>
                    </div>
			    </div>
			</div>
		</div>
		<!-- end #content -->
		
        
    <script src="<?php echo e(asset('public/plugins/jquery/jquery-1.9.1.min.js')); ?>"></script>        
    <script type="text/javascript">
        function loadAmount($id){

           $.ajax({
                url: "<?php echo e(URL::to('bill')); ?>/"+$id,
                type: "GET",
                data:'',
                success: function(response){
                $('#amount').attr('max',response);
                $('#balance').html(response);
                        
                }
            });
        }
    </script>
    <?php $__env->stopSection(); ?>

<?php echo $__env->make('layout.app', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>