	
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
                                <a class="btn btn-warning btn-xs" href="<?php echo e(URL::to('/client/create')); ?>">Add New Client</a>
                            </div>
                            <h4 class="panel-title">All Clients</h4>
                        </div>
                        <div class="panel-body">
                            <table id="data-table" class="table table-striped table-bordered nowrap" width="100%">
                                <thead>
                                    <tr>
                                        <th>Sl</th>
                                        <th>Client Id</th>
                                        <th>Client Name</th>
                                        <th>Client Phone</th>
                                        <th>Client Email</th>
                                        <th>Status</th>
                                        <th>Branch</th>
                                        <th width="8%">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <?php $i=0; ?>
                                <?php $__currentLoopData = $getClientData; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $client): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                <?php $i++; ?>
                                    <tr class="odd gradeX">
                                        <td><?php echo e($i); ?></td>
                                        <td><?php echo e($client->client_id); ?></td>
                                        <td><?php echo e($client->client_name); ?></td>
                                        <td><?php echo e($client->mobile_no); ?></td>
                                        <td><?php echo e($client->email_id); ?></td>
                                        <td><?php echo e(($client->client_status==1)?'Active':'Inactive'); ?></td>
                                        <td><?php echo e($client->branch_name); ?></td>
                                        <td>
                                        <!-- edit section -->
                                            <a href="ui_modal_notification.html#modal-dialog<?php echo $client->id;?>" class="btn btn-xs btn-success" data-toggle="modal"><i class="fa fa-pencil-square-o" aria-hidden="true" ></i></a>
                                            <!-- #modal-dialog -->
                                            <div class="modal fade" id="modal-dialog<?php echo $client->id;?>">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                    <?php echo Form::open(array('route' => ['client.update',$client->id],'class'=>'form-horizontal author_form','method'=>'PUT','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')); ?>

                                                        <div class="modal-header">
                                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                            <h4 class="modal-title">Edit Client Information</h4>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-4 col-sm-4" for="company_name">Company Name</label>
                                                                <div class="col-md-8 col-sm-8">
                                                                    <input class="form-control" type="text" id="company_name" name="company_name" value="<?php echo $client->company_name; ?>" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label col-md-4 col-sm-4" for="client_name">Client Name * :</label>
                                                                <div class="col-md-8 col-sm-8">
                                                                    <input class="form-control" type="text" id="client_name" name="client_name" value="<?php echo $client->client_name; ?>" data-parsley-required="true" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label col-md-4 col-sm-4" for="client_name">Client Email * :</label>
                                                                <div class="col-md-8 col-sm-8">
                                                                    <input class="form-control" type="text" id="email" name="email_id" data-parsley-type="email" value="<?php echo $client->email_id ?>"  />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label col-md-4 col-sm-4" for="client_name">Client Address * :</label>
                                                                <div class="col-md-8 col-sm-8">
                                                                    <textarea class="form-control" id="address" name="address" rows="4"><?php echo $client->address; ?></textarea>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label col-md-4 col-sm-4" for="client_name">Client Mobile No. * :</label>
                                                                <div class="col-md-8 col-sm-8">
                                                                    <input class="form-control" type="text" id="number" name="mobile_no" data-parsley-type="number" value="<?php echo $client->mobile_no; ?>" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label col-md-4 col-sm-4">Client Status :</label>
                                                                <div class="col-md-3 col-sm-3">
                                                                    <div class="radio">
                                                                        <label>
                                                                            <input type="radio" name="client_status" value="1" id="radio-required" data-parsley-required="true" <?php if($client->client_status=="1"): ?><?php echo e("checked"); ?><?php endif; ?>> Active
                                                                        </label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4 col-sm-4">
                                                                    <div class="radio">
                                                                        <label>
                                                                            <input type="radio" name="client_status" id="radio-required2" value="0" <?php if($client->client_status=="0"): ?><?php echo e("checked"); ?><?php endif; ?>> Inactive
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
                                            <?php echo Form::open(array('route'=> ['client.destroy',$client->id],'method'=>'DELETE')); ?>

                                                <?php echo e(Form::hidden('id',$client->id)); ?>

                                                <button type="submit" onclick="return confirmDelete();" class="btn btn-danger btn-xs">
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