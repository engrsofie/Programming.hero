
<?php $__env->startSection('content'); ?>
<div id="content" class="content">
		
		<div class="row">
		    <div class="col-md-12">
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <h4 class="panel-title">Stock Position</h4>
                    </div>
                    <div class="panel-body print_body">
                    <div class="box-body">
		<?php echo Form::open(array('route' => 'inventory-stock-position.store','class'=>'form-horizontal','files'=>true)); ?>

		<div class="form-group <?php echo e($errors->has('position_name') ? 'has-error' : ''); ?>">
			<?php echo e(Form::label('position_name', 'Position Name', array('class' => 'col-md-2 control-label'))); ?>

			<div class="col-md-6">
				<?php echo e(Form::text('position_name','',array('class'=>'form-control','placeholder'=>'Position Name','required'))); ?>

				<?php if($errors->has('position_name')): ?>
                    <span class="help-block">
                        <strong><?php echo e($errors->first('position_name')); ?></strong>
                    </span>
	            <?php endif; ?>
			</div>
			<div class="col-md-2">
				<?php if(Auth::user()->isRole('administrator')): ?>
				<?php echo e(Form::select('fk_branch_id', $branch, Auth::user()->fk_branch_id, ['class' => 'form-control'])); ?>

				<input type="hidden" name="status" value="1">
				<?php else: ?>
				<input type="hidden" name="fk_branch_id" value="<?php echo e(Auth::user()->fk_branch_id); ?>">
				<?php echo e(Form::select('status', array('1' => 'Active', '2' => 'Inactive'), '1', ['class' => 'form-control'])); ?>

				<?php endif; ?>
			</div>
			<div class="col-md-2">
			<?php echo e(Form::submit('Submit',array('class'=>'btn btn-info'))); ?>

			</div>
		</div>
			
		<?php echo Form::close(); ?>

	</div>
	<div class="col-md-12">
		<table class="table table-striped table-hover table-bordered center_table" id="my_table">
			<thead>
				<tr>
					<th>SL</th>
					<th>Position Name</th>
					<th>Status</th>
					<th>Branch</th>
					<th>Created At</th>
					<th colspan="2">Action</th>
				</tr>
			</thead>
			<tbody>
			<? $i=1; ?>
			<?php $__currentLoopData = $allData; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $data): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
				<tr>
					<td><?php echo e($i++); ?></td>
					<td><?php echo e($data->position_name); ?></td>
					<td><i class="<?php echo e(($data->status==1)? 'fa fa-check-circle text-success' : 'fa fa-times-circle text-danger'); ?>"></i></td>
					<td><?php echo e($data->branch_name); ?></td>
					<td><?php echo e(date('d-m-Y',strtotime($data->created_at))); ?></td>
					<td><a href="#editModal<?php echo e($data->id); ?>" data-toggle="modal" class="btn btn-info btn-xs"><i class="fa fa-pencil-square"></i></a>
					<!-- Modal -->
<div class="modal fade" id="editModal<?php echo e($data->id); ?>" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-md">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Edit Position</h4>
      </div>
        <?php echo Form::open(array('route' => ['inventory-stock-position.update',$data->id],'class'=>'form-horizontal','method'=>'PUT','files'=>true)); ?>

      <div class="modal-body">
		<div class="form-group">
			<?php echo e(Form::label('position_name', 'Position Name', array('class' => 'col-md-3 control-label'))); ?>

			<div class="col-md-8">
				<?php echo e(Form::text('position_name',$data->position_name,array('class'=>'form-control','placeholder'=>'Position Name','required'))); ?>

				<?php echo e(Form::hidden('id',$data->id)); ?>

			</div>
			
			
		</div>
		<?php if(Auth::user()->isRole('administrator')): ?>
		<div class="form-group">
			<?php echo e(Form::label('Brnach', 'Branch Name', array('class' => 'col-md-3 control-label'))); ?>

			<div class="col-md-5">
				<?php echo e(Form::select('fk_branch_id', $branch, $data->fk_branch_id, ['class' => 'form-control'])); ?>

			</div>
			<div class="col-md-3">
				<?php echo e(Form::select('status', array('1' => 'Active', '2' => 'Inactive'), $data->status, ['class' => 'form-control'])); ?>

			</div>
		</div>
		<?php endif; ?>
			
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
						<?php echo e(Form::open(array('route'=>['inventory-stock-position.destroy',$data->id],'method'=>'DELETE'))); ?>

            				<button type="submit" class="btn btn-danger btn-xs" onclick="return confirmDelete();"><i class="fa fa-trash"></i></button>
        				<?php echo Form::close(); ?>

					</td>
				</tr>
			<?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
			</tbody>
		</table>
		<div class="pull-right">
		<?php echo e($allData->render()); ?>	
		</div>
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
	        TableManageResponsive.init();
	    });
	</script>
<?php $__env->stopSection(); ?>

<?php echo $__env->make('layout.app', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>