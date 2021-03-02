
	
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
                            <h4 class="panel-title">Account report</h4>
                        </div>
                        <div class="panel-body">
                            <?php echo Form::open(array('url' => 'inventory-account-report-show','class'=>'form-horizontal author_form','method'=>'GET','data-parsley-validate novalidate')); ?>

                        	    <div class="form-group col-md-3">
                                    <label class="col-md-12" for="Date">Select Account * :</label>
                                    <div class="col-md-12">
                                    <? $id= isset($input)?$input['id']:''?>
                                        <?php echo e(Form::select('id',$accounts,$id,['class'=>'form-control select','placeholder'=>'Select account','required'])); ?>

                                    </div>
                                </div>
                                <? 
                                $branchId='';
                                if(isset($input['branch'])){
                                    $branchId=$input['branch'];
                                }
                                $clientId='';
                                if(isset($input['client'])){
                                    $clientId=$input['client'];
                                }
                                 ?>
                                <?php if(Auth::user()->isRole('administrator')): ?>
                                <div class="form-group col-md-3 no-padding">
                                    <label class="col-md-12">Select Branch :</label>
                                    <div class="col-md-12">
                                        <?php echo e(Form::select('fk_branch_id',$branch,$branchId,['class'=>'form-control','placeholder'=>'All Branch','onchange'=>'loadCLient(this.value)','id'=>'branch'])); ?>

                                    </div>
                                </div>
                                <?php else: ?>
                                <input type="hidden" name="fk_branch_id" id='branch' value="<?php echo e(Auth::user()->fk_branch_id); ?>">
                                <?php endif; ?>
                                <div class="form-group col-md-5">
                                    <label class="col-md-12" for="Date">Select Date * :</label>
                                    <div class="col-md-5 no-padding">
                                        <input class="form-control" type="date" name="start_date" value="<?php echo e(isset($input)?$input['start_date']:date('Y-m-d')); ?>" placeholder="date" data-parsley-required="true" />
                                    </div>

                                    <div class="col-md-2 no-padding"><input readonly class="form-control text-center" value="TO"></div>

                                    <div class="col-md-5 no-padding">
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
                                                <td><b>Account Name : </b> <? echo $accountInfo->account_name ?></td>
                                            </tr>
                                        </table>
                                        <div>
                                        <br>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                            <div class="invoice-content col-md-12">
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th width="5%">SL</th>
                                                <th>Date</th>
                                                <th>Invoice ID</th>
                                                <th>Particular</th>
                                                <th>Cash In</th>
                                                <th>Cash Out</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr class="active">
                                                <th>1</th>
                                                <th><?php echo e($input['start_date']); ?></th>
                                                <th>---</th>
                                                <th>Opening Balance</th>
                                                <th><?php echo e($balance); ?></th>
                                                <th></th>
                                                <!-- <td><?php if($balance>0): ?> <?php echo e($balance); ?> <?php endif; ?></td> -->
                                                <!-- <td><?php if($balance<0): ?> <?php echo e($balance); ?> <?php endif; ?></td> -->
                                            </tr>
                                        <? 
                                        $i=1; 
                                        $total=$balance;
                                        $cashOut=0;
                                        ?>
                                        <?php $__currentLoopData = $cash; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $data): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                        <? 
                                        $i++;
                                        $paid_amount=0;
                                        $total_paid=0;
                                        if(isset($data['paid_amount'])){
                                         $total+=$data['paid_amount'];
                                         $paid_amount=$data['paid_amount'];
                                        }
                                        if(isset($data['total_paid'])){
                                         $cashOut+=$data['total_paid'];
                                         $total_paid=$data['total_paid'];
                                        }
                                        ?>
                                        <tr>
                                            <td><?php echo e($i); ?></td>
                                            <td><?php echo e($data['date']); ?></td>
                                            <td>
                                            <?php if(isset($data['paid_amount'])): ?>
                                                <a href='<?php echo e(URL::to("inventory-sales-invoice/".$data['invoice_id'])); ?>' target="_blank"><?php echo e($data['invoice_id']); ?></a>
                                            <?php else: ?>
                                                <a href='<?php echo e(URL::to("inventory-product-add/".$data['invoice_id'])); ?>' target="_blank"><?php echo e($data['invoice_id']); ?></a>
                                            <?php endif; ?>
                                            </td>
                                            <td><?php if(isset($data['paid_amount'])): ?> Sales <?php else: ?> Purchase <?php endif; ?></td>
                                            <td><?php echo e(round($paid_amount,2)); ?></td>
                                            <td><?php echo e(round($total_paid,2)); ?></td>
                                        </tr>
                                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                        <? 
                                     ?>
                                    <?php $__currentLoopData = $deposit; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $dep): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                    <? 
                                    $i++;
                                    $total+=$dep->total_amount;
                                    ?>
                                        <tr>
                                            <td><?php echo e($i); ?></td>
                                            <td>---</td>
                                            <td>Deposit</td>
                                            <td><?php echo e($dep->sub_category_name); ?></td>
                                            <td><?php echo e(round($dep->total_amount,3)); ?></td>
                                            <td></td>
                                        </tr>
                                    <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                    <? 
                                        $total_payment=0;
                                        ?>
                                        <?php $__currentLoopData = $payment; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $pay): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                        <? 
                                        $i++;
                                        $cashOut+=$pay->total_amount;
                                         ?>
                                            <tr>
                                                <td><?php echo e($i); ?></td>
                                                <td>---</td>
                                                <td>Payment</td>
                                                <td><?php echo e($pay->sub_category_name); ?></td>
                                                <td></td>
                                                <td><?php echo e(round($pay->total_amount,3)); ?></td>
                                            </tr>
                                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                    <?php if($salary->total_amount>0): ?>
                                        <tr>
                                            <? $i++;
                                            $cashOut+=$salary->total_amount;
                                             ?>
                                            <td><?php echo e($i); ?></td>
                                            <td>---</td>
                                            <td>---</td>
                                            <td>Total Salary</td>
                                            <td></td>
                                            <td><?php echo e(round($salary->total_amount,3)); ?></td>
                                        </tr>
                                    <?php endif; ?>
                                        
                                        <tr class="active">
                                            <th colspan="4" style="text-align: right;">Total = </th>
                                            <th><?php echo e($total); ?></th>
                                            <th><?php echo e($cashOut); ?></th>
                                        </tr>
                                        <tr class="active">
                                            <th colspan="5" style="text-align: right;">Accoutn Balance= </th>
                                            <th><?php echo e($total-$cashOut); ?></th>
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