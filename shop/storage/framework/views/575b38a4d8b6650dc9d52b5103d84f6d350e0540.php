	
		<?php $__env->startSection('content'); ?>
        <style type="text/css">
            form{display: inline;}
            .form-group{width: 100%;height: auto; overflow: hidden; display: block !important; margin: 5px;}
            .form-control{width: 100% !important;}
        </style>
		<!-- begin #content -->
		<div id="content" class="content">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a class="btn btn-info" href="<?php echo e(URL::to('/bill/create')); ?>">Add New Bill</a></li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">Bill Page </h1>
			<!-- end page-header -->
			
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-success" data-click="panel-reload"><i class="fa fa-repeat"></i></a>
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
                            </div>
                            <h4 class="panel-title">Bill Transaction View Page</h4>
                        </div>
                        <div class="panel-body">
                            <table id="data-table" class="table table-striped table-bordered nowrap" width="100%">
                                <thead>
                                    <tr>
                                        <th>Sl</th>
                                        <th>From Account</th>
                                        <th>To Account</th>
                                        <th>Date</th>
                                        <th>Payment Method</th>
                                        <th>Amount</th>
                                        <th>Description</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <?php $i=0; ?>
                                <?php $__currentLoopData = $billTransaction; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $bill): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                <?php $i++; ?>
                                    <tr class="odd gradeX">
                                        <td><?php echo e($i); ?></td>
                                        <td><?php echo e($bill->account_name); ?></td>
                                        <td><?php echo e($bill->account1_name); ?></td>
                                        <td><?php echo e($bill->t_date); ?></td>
                                        <td><?php echo e($bill->method_name); ?></td>
                                        <td><?php echo e($bill->amount); ?></td>
                                        <td><?php echo e(str_limit($bill->description,40)); ?></td>
                                       
                                        <td>
                                        <!-- edit section -->
                                            <a href="ui_modal_notification.html#modal-dialog<?php echo $bill->id;?>" class="btn btn-sm btn-success" data-toggle="modal"><i class="fa fa-pencil-square-o" aria-hidden="true" style="font-size: 18px;"></i></a>
                                            <!-- #modal-dialog -->
                                            <div class="modal fade" id="modal-dialog<?php echo $bill->id;?>">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                    <?php echo Form::open(array('route' => ['bill.update',$bill->id],'class'=>'form-horizontal author_form','method'=>'PUT','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')); ?>

                                                        <div class="modal-header">
                                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                            <h4 class="modal-title">Modal Dialog</h4>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-4 col-sm-4" for="company_name">From Account * :</label>
                                                                <div class="col-md-8 col-sm-8">
                                                                  <select class="form-control" id="select-required" name="from_account" data-parsley-required="true">

                                                                        <?php $__currentLoopData = $getAccount; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $account): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                                                            <option value="<?php echo e($account->id); ?>" <?php if($bill->account_id == $account->id): ?><?php echo e("selected"); ?> <?php endif; ?>><?php echo e($account->account_name); ?></option>
                                                                            
                                                                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label col-md-4 col-sm-4" for="to_account">To Account * :</label>
                                                                <div class="col-md-8 col-sm-8">
                                                                    <select class="form-control" id="select-required" name="to_account" data-parsley-required="true">

                                                                     <?php $__currentLoopData = $getAccount; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $account): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                                                            <option value="<?php echo e($account->id); ?>" <?php if($bill->account1_id == $account->id): ?><?php echo e("selected"); ?> <?php endif; ?>><?php echo e($account->account_name); ?></option>
              
                                                                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                             <div class="form-group">
                                                                <label class="control-label col-md-4 col-sm-4" for="to_account">Payment Method * :</label>
                                                                <div class="col-md-8 col-sm-8">
                                                                    <select class="form-control" id="select-required" name="method" data-parsley-required="true">

                                                                     <?php $__currentLoopData = $getMethodData; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $method): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                                                            <option value="<?php echo e($account->id); ?>" <?php if($bill->method_id == $bill->id): ?><?php echo e("selected"); ?> <?php endif; ?>><?php echo e($method->method_name); ?></option>
              
                                                                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label col-md-4 col-sm-4" for="amount">Amount * :</label>
                                                                <div class="col-md-8 col-sm-8">
                                                                    <input class="form-control" type="text" id="amount" name="amount" value="<?php echo $bill->amount; ?>" data-parsley-required="true" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label col-md-4 col-sm-4">Description :</label>
                                                                
                                                                    <div class="col-md-8 col-sm-8">
                                                                       
                                                                            <textarea class="form-control"" row="6" id="address" name="description" selected><?php echo e($bill->description); ?></textarea>
                                                                        
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
                                            </div>
                                            </div>

                                                <?php echo Form::open(array('route'=> ['bill.destroy',$bill->id],'method'=>'DELETE')); ?>

                                                <?php echo e(Form::hidden('id',$bill->id)); ?>

                                                <button type="submit" onclick="return confirmDelete();" class="btn btn-danger">
                                                  <i class="fa fa-trash-o" aria-hidden="true"></i>
                                                </button>
                                            <?php echo Form::close(); ?>

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
    <?php $__env->stopSection(); ?>

<?php echo $__env->make('layout.app', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>