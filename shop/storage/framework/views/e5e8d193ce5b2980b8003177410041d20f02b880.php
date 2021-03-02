
	
		<?php $__env->startSection('content'); ?>
		<!-- begin #content -->
		<div id="content" class="content">
			
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                            <?php if(isset($report)): ?>
                                <a href="javascript:;" onclick="printPage('print_body')" class="btn btn-xs btn-success"><i class="fa fa-print"></i> Print</a>
                            <?php else: ?>
                                <a class="btn btn-info btn-xs" href="<?php echo e(URL::to('/inventory-supplier')); ?>">View All Supplier</a>
                            <?php endif; ?>

                                
                            </div>
                            <h4 class="panel-title">Supplier report</h4>
                        </div>
                        <div class="panel-body">
                            <?php echo Form::open(array('url' => 'inventory-supplier-report-show','class'=>'form-horizontal author_form','method'=>'GET','data-parsley-validate novalidate')); ?>

                        	    <div class="form-group col-md-4">
                                    <label class="col-md-12" for="Date">Select supplier * :</label>
                                    <div class="col-md-12">
                                    <? $id= isset($input)?$input['id']:''?>
                                        <?php echo e(Form::select('id',$supplier,$id,['class'=>'form-control select','placeholder'=>'Select supplier','required'])); ?>

                                    </div>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="col-md-12" for="Date">Select Date * :</label>
                                    <div class="col-md-5">
                                        <input class="form-control" type="date" name="start_date" value="<?php echo e(isset($input)?$input['start_date']:date('Y-m-d')); ?>" placeholder="date" data-parsley-required="true" />
                                    </div>

                                    <div class="col-md-2"><input readonly class="form-control text-center" value="TO"></div>

                                    <div class="col-md-5">
                                        <input class="form-control" type="date" name="end_date" value="<?php echo e(isset($input)?$input['end_date']:date('Y-m-d')); ?>" placeholder="date" data-parsley-required="true" />
                                    </div>
                                </div>
                                
								<div class="form-group col-md-2">
									<label class="col-md-12">Click Here</label>
									<div class="col-md-12">
										<button type="submit" class="btn btn-primary">Submit</button>
									</div>
								</div>
                            <?php echo Form::close();; ?>

                            <?php if(isset($report)): ?>
                            <div class="col-md-12">
                                <hr>
                            </div>
                            <!-- Print Body -->
                            <div id="print_body" style="width: 100%;overflow: hidden; padding: 10px 20px;">
                            <?php echo $__env->make('pad.header', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>
                            <div id="customer_info" style="padding: 0 10px;">
                                <div class="row">
                                    <div class="invoiceInfo" style="width: 100%;">
                                        <p align="center"><b>Report : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<u><?php echo e($input['start_date']); ?></u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TO  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<u><?php echo e($input['end_date']); ?></u></b></p>
                                        <table width="100%">
                                            <tr>
                                                <td><b>Company Name : </b> <? echo $supplierInfo->company_name ?></td>
                                                <td><b>Mobile : </b> <? echo $supplierInfo->mobile_no ?></td>
                                                <td><b>Address : </b> <? echo $supplierInfo->address ?></td>
                                                <td><b>Email : </b> <? echo $supplierInfo->email_id ?></td>
                                            </tr>
                                        </table>
                                        <div>
                                        <br>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                            <div class="invoice-content">
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th width="5%">SL</th>
                                                <th>Date</th>
                                                <th>Invoice ID</th>
                                                <th>Total Amount</th>
                                                <th>Paid Amount</th>
                                                <th>Due</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <? 
                                        $i=0; 
                                        $total=0;
                                        $paid=0;
                                        $due=0;
                                        ?>
                                        <?php $__currentLoopData = $report; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $data): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                        <? 
                                        $i++;
                                         $total+=$data->total_amount;
                                         $paid+=$data->total_paid;
                                         $due+=($data->total_amount-$data->total_paid);
                                        ?>
                                        <tr>
                                            <td><?php echo e($i); ?></td>
                                            <td><?php echo e($data->date); ?></td>
                                            <td><a href='<?php echo e(URL::to("inventory-product-add/$data->inventory_order_id")); ?>' target="_blank"><?php echo e($data->inventory_order_id); ?></a> </td>
                                            <td><?php echo e(round($data->total_amount,2)); ?>

                                            </td>
                                            <td><?php echo e(round($data->total_paid,2)); ?></td>
                                            <td><?php echo e(round($data->total_amount-$data->total_paid,2)); ?></td>
                                        </tr>
                                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                        <tr class="active">
                                            <td colspan="3" style="text-align: right;">Total = </td>
                                            <td><?php echo e($total); ?></td>
                                            <td><?php echo e($paid); ?></td>
                                            <td><?php echo e($due); ?></td>
                                        </tr>
                                        <?php if($prev->total_amount>0): ?>
                                        <tr>
                                            <td colspan="3" style="text-align: right;">Previous Transaction </td>
                                            <td><?php echo e(round($prev->total_amount,2)); ?></td>
                                            <td><?php echo e(round($prev->total_paid,2)); ?></td>
                                            <td><?php echo e(round($prev->total_amount-$prev->total_paid,2)); ?></td>
                                        </tr>
                                        <?php endif; ?>
                                        <?php if($next->total_amount>0): ?>
                                        <tr>
                                            <td colspan="3" style="text-align: right;">After Transaction </td>
                                            <td><?php echo e(round($next->total_amount,2)); ?></td>
                                            <td><?php echo e(round($next->total_paid,2)); ?></td>
                                            <td><?php echo e(round($next->total_amount-$next->total_paid,2)); ?></td>
                                        </tr>
                                        <?php endif; ?>
                                        <tr class="success">
                                            <th colspan="3" style="text-align: right;">Total Amount = </th>
                                            <th><?php echo e(round($prev->total_amount+$total+$next->total_amount,2)); ?></th>
                                            <th><?php echo e(round($prev->total_paid+$paid+$next->total_paid,2)); ?></th>
                                            <th><?php echo e(round($next->total_amount-$next->total_paid,2)+round($prev->total_amount-$prev->total_paid,2)+$due); ?></th>
                                        </tr>
                                        </tbody>

                                    </table>
                                </div>
                            </div>

                            <div class="printFooter" style="overflow: hidden;
                    width: 100%;position: fixed;bottom: 0;left: 0;">
                            <style type="text/css">
                                .print-footer .sign{display: none;}
                            </style>
                                   <?php echo $__env->make('pad.footer', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>
                            </div>
                            </div>
                            <!-- /Print Body -->
                            <?php endif; ?>

                        </div>
                    </div>
			    </div>
			</div>
		</div>
		<!-- end #content -->

    <?php $__env->stopSection(); ?>
<?php $__env->startSection('script'); ?>

<script src="<?php echo e(asset('public/custom_js/printThis.js')); ?>"></script>
<script type="text/javascript">
    function printPage(id){
        $('#'+id).printThis();
    }
</script>
<?php $__env->stopSection(); ?>
<?php echo $__env->make('layout.app', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>