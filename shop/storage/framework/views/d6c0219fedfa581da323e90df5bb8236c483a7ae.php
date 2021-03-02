
<?php $__env->startSection('content'); ?>


<h3 class="box_title">Edit Menu
 <a href="<?php echo e(route('menu.index')); ?>" class="btn btn-default pull-right"> <i class="ion ion-navicon-round"></i> View All </a></h3>
    <?php echo Form::open(array('route' => ['menu.update', $data->id],'method'=>'PUT','class'=>'form-horizontal','files'=>true)); ?>

        <div class="form-group   <?php echo e($errors->has('name') ? 'has-error' : ''); ?>">
            <?php echo e(Form::label('name', ' Name', array('class' => 'col-md-3 control-label'))); ?>

            <div class="col-md-8">
                <?php echo e(Form::text('name',$data->name,array('class'=>'form-control','placeholder'=>'Name','required'))); ?>

            </div>
        </div>
         <div class="form-group  <?php echo e($errors->has('url') ? 'has-error' : ''); ?>">
            
            <?php echo e(Form::label('url', 'URL', array('class' => 'col-md-3 control-label'))); ?>

            <div class="col-md-8">
                <div class="input-group">
                    <div class="input-group-addon"><?php echo e(URL::to('/')); ?>/</div>
                    <?php echo e(Form::text('url',$data->url,array('class'=>'form-control','placeholder'=>'URL','required'))); ?>

                </div>
                <?php if($errors->has('url')): ?>
                    <span class="help-block">
                        <strong><?php echo e($errors->first('url')); ?></strong>
                    </span>
                <?php endif; ?>
            </div>
        </div>
        <div class="form-group">
            <?php echo e(Form::label('serial_num', 'Serial', array('class' => 'col-md-3 control-label'))); ?>

            <div class="col-md-8">
            <? $max=$max_serial+1; ?>
                <?php echo e(Form::number('serial_num',$data->serial_num,array('class'=>'form-control','placeholder'=>'Serial Number','max'=>"$max",'min'=>'0'))); ?>

            </div>
        </div>
        <div class="form-group">
            <?php echo e(Form::label('status', 'Status', array('class' => 'col-md-3 control-label'))); ?>


            <div class="col-md-8">
                <?php echo e(Form::select('status', array('1' => 'Active', '2' => 'Inactive'),$data->status, ['class' => 'form-control'])); ?>

            </div>
        </div>
            <?php echo e(Form::hidden('id',$data->id)); ?>

        <div class="form-group">
            <div class="col-md-9 col-md-offset-3">
                <button type="submit" class="btn btn-primary">Submit</button>
            </div>
        </div>
      
	<?php echo Form::close(); ?>


<?php $__env->stopSection(); ?>


<?php echo $__env->make('layout.app', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>