	
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
                                <a class="btn btn-info btn-xs" href="<?php echo e(URL::to('account-money-transfer/create')); ?>">New Transfer</a>
                            </div>
                            <h4 class="panel-title">All Transferd</h4>
                        </div>
                        <div class="panel-body">
                            <table id="data-table" class="table table-striped table-bordered nowrap" width="100%">
                                <thead>
                                    <tr>
                                        <th>Sl</th>
                                        <th>Transfer From</th>
                                        <th>Transfer To</th>
                                        <th>Date</th>
                                        <th>Method</th>
                                        <th>Amount</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <?php $i=0; ?>
                                <?php $__currentLoopData = $allData; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $data): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                <?php $i++; ?>
                                    <tr class="odd gradeX">
                                        <td><?php echo e($i); ?></td>
                                        <td><b><?php echo e($data->branch_one); ?></b><hr class="min"><?php echo e($data->account_name); ?></td>
                                        <td><b><?php echo e($data->branch_two); ?></b><hr class="min"><?php echo e($data->account1_name); ?></td>
                                        <td><?php echo e($data->date); ?></td>
                                        <td><?php echo e($data->method_name); ?></td>
                                        <td><?php echo e($data->amount); ?></td>
                                        <td>
                                            <a href='<?php echo e(URL::to("account-money-transfer/$data->id/edit")); ?>' class="btn btn-info btn-xs"><i class="fa fa-pencil-square"></i></a>
                                            <?php echo Form::open(array('route'=> ['account-money-transfer.destroy',$data->id],'method'=>'DELETE')); ?>

                                                <?php echo e(Form::hidden('id',$data->id)); ?>

                                                <button type="submit" onclick="return confirmDelete();" class="btn btn-danger btn-xs">
                                                  <i class="fa fa-trash-o" aria-hidden="true"></i>
                                                </button>
                                            <?php echo Form::close(); ?>

                                        </td>
                                    </tr>
                                <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                </tbody>
                            </table>
                            <?php echo e($allData->render()); ?>

                        </div>
                    </div>
			    </div>
			</div>
		</div>
		<!-- end #content -->
    <?php $__env->stopSection(); ?>

<?php echo $__env->make('layout.app', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>