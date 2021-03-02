    <?php $__env->startSection('content'); ?>
    <?php if($errors->has('email')): ?>
        <div class="col-md-12">
            <div class="alert alert-danger alert-dismissable">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                <b><?php echo e($errors->first('email')); ?></b> 
           </div>
        </div>
    <?php endif; ?>
<div id="content" class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-inverse">
                <div class="panel-heading">
                    <div class="panel-heading-btn">
                        <a href="<?php echo e(route('users.create')); ?>" class="btn btn-default btn-xs pull-right"> <i class="ion ion-navicon-round"></i> Add new user</a>
                        
                    </div>
                    <h4 class="panel-title">View All User </h4>
                </div>
                <div class="panel-body">
                    <table id="datatable" class="table table-striped table-bordered">
                        <thead>
                            <tr>
                                <th>SL</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Branch</th>
                                <th>Mobile</th>
                                <th width="3%">Status</th>
                                <th width="10%">Created At</th>
                                <th colspan="2" width="5%">Action</th>
                            </tr>
                        </thead>

                        <tbody>
                        <? $i=1; ?>
                    <?php $__currentLoopData = $allUsers; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $data): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                            <tr>
                        <td><?php echo e($i++); ?></td>
                        <td> <a href="<?php echo e(route('users.show',$data->id)); ?>" class="btn btn-xs btn-link"><?php echo e($data->name); ?></a></td>
                        <td><?php echo e($data->email); ?></td>
                        <td><?php echo e($data->type_name); ?></td>
                        <td><?php echo e($data->branch_name); ?></td>
                        <td><?php echo e($data->phone_number); ?></td>
                        <td><i class="<?php echo e(($data->status==1)? 'fa fa-check-circle text-success' : 'fa fa-times-circle text-danger'); ?>"></i></td>
                        <td><?php echo e(date('d-M-Y',strtotime($data->created_at))); ?></td>
                        <td><a href="#editModal<?php echo e($data->id); ?>" data-toggle="modal" class="btn btn-xs btn-info"><i class="fa fa-pencil-square"></i></a>
                        <!-- Modal -->
    <div class="modal fade" id="editModal<?php echo e($data->id); ?>" tabindex="-1" role="dialog">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title"><?php echo e($data->name); ?></h4>
          </div>
            <?php echo Form::open(array('route' => ['users.update',$data->id],'class'=>'form-horizontal','method'=>'PUT')); ?>

          <div class="modal-body">
            <div class="form-group">
                <?php echo e(Form::label('name', 'Name', array('class' => 'col-md-4 control-label'))); ?>

                <div class="col-md-8">
                    <?php echo e(Form::text('name',$data->name,array('class'=>'form-control','placeholder'=>'Name','required'))); ?>

                </div>
            </div>
            <div class="form-group">
                <?php echo e(Form::label('email', 'Email', array('class' => 'col-md-4 control-label'))); ?>

                <div class="col-md-8">
                    <?php echo e(Form::email('email',$data->email,array('class'=>'form-control','placeholder'=>'Email','required'))); ?>

                </div>
            </div>
            <div class="form-group">
                <?php echo e(Form::label('phone_number', 'Mobile', array('class' => 'col-md-4 control-label'))); ?>

                <div class="col-md-8">
                    <?php echo e(Form::text('phone_number',$data->phone_number,array('class'=>'form-control','placeholder'=>'Mobile','required'))); ?>

                </div>
            </div>
            <div class="form-group">
                <?php echo e(Form::label('address', 'Address', array('class' => 'col-md-4 control-label'))); ?>

                <div class="col-md-8">
                    <?php echo e(Form::text('address',$data->address,array('class'=>'form-control','placeholder'=>'Address','required'))); ?>

                </div>
            </div>
                <?php echo e(Form::hidden('id',$data->id)); ?>

                
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <?php echo e(Form::submit('Save changes',array('class'=>'btn btn-info'))); ?>

          </div>
            <?php echo Form::close(); ?>

        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

                        </td>
                        <td>
                    <?php echo Form::open(array('route' => ['users.destroy',$data->id],'method'=>'DELETE')); ?>

                        <button type="submit" class="btn btn-xs btn-danger" onclick="return confirmDelete();"><i class="fa fa-trash"></i></button>
                    <?php echo Form::close(); ?>

                                </td>

                            </tr>
                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                                       
                        </tbody>
                    </table>
                    <div class="pull-right">
                    <?php echo e($allUsers->render()); ?> 
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
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