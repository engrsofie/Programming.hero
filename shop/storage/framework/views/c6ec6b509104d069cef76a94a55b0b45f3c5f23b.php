	
		<?php $__env->startSection('content'); ?>
        <style type="text/css">
            form{display: inline;}
            .form-group{width: 100%;height: auto; overflow: hidden; display: block !important; margin: 5px;}
            .form-control{width: 100% !important;}
        </style>
		<!-- begin #content -->
		<div id="content" class="content">
			
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                                <a class="btn btn-info btn-xs" href="<?php echo e(URL::to('/deposit/create')); ?>">Add New Create Deposit</a>
                            </div>
                            <h4 class="panel-title">Due Deposit </h4>
                        </div>
                        <div class="panel-body">
                            <table id="data-table" class="table table-striped table-bordered nowrap" width="100%">
                                <thead>
                                    <tr>
                                        <th>Sl</th>
                                        <th>Invoice No.</th>
                                        <th>Client Name</th>
                                        <th>Date</th>
                                        <th>Total Amount</th>
                                        <th>Total Due</th>
                                        <th>Branch</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <?php $i=0; ?>
                                <?php $__currentLoopData = $getDueDeposit; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $dueDeposit): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                <?php $i++; ?>
                                    
                                    <tr class="odd gradeX">
                                        <td><?php echo e($i); ?></td>
                                        <td><?php echo e($dueDeposit->invoice_no); ?></td>
                                        <td><?php echo e($dueDeposit->client_name); ?></td>
                                        <td><?php echo e($dueDeposit->t_date); ?></td>
                                        <td><?php echo e($dueDeposit->amount); ?></td>
                                        <td><?php echo e($dueDeposit->amount-$dueDeposit->total_paid); ?></td>
                                        <td><?php echo e($dueDeposit->branch_name); ?></td>

                                        <td>
                                            <a href='<?php echo e(URL::to("due-deposit/$dueDeposit->id/edit")); ?>' class="btn btn-xs btn-danger">Due</a>

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
		<!-- end #content -->
		
    <script src="<?php echo e(asset('public/plugins/jquery/jquery-1.9.1.min.js')); ?>"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            App.init();
            TableManageResponsive.init();
        });
    </script>
    <?php $__env->stopSection(); ?>

<?php echo $__env->make('layout.app', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>