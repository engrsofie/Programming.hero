
	
		<?php $__env->startSection('content'); ?>
		<!-- begin #content -->
		<div id="content" class="content">
			
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                            <?php if(isset($client)): ?>
                                <a href="javascript:;" onclick="printPage('print_body')" class="btn btn-xs btn-success"><i class="fa fa-print"></i> Print</a>
                            <?php endif; ?>
                                <a class="btn btn-info btn-xs" href="<?php echo e(URL::to('/inventory-sales-payment')); ?>">View All</a>
                                
                            </div>
                            <h4 class="panel-title">Client wise Payment</h4>
                        </div>
                        <div class="panel-body">
                            
                                <div class="col-md-7 col-md-offset-3">
                            	    <div class="form-group">
                                        <label class="col-md-4 control-label" for="Date">Select Client * :</label>
                                        <div class="col-md-8">
                                        <? $id= isset($client)?$client->id:''?>
                                            <?php echo e(Form::select('id',$clients,$id,['class'=>'form-control select','placeholder'=>'Select Client','required' ,'onchange'=>'loadDue(this.value)'])); ?>

                                        </div>
                                    </div>                                    
                                </div>
                            <div class="col-md-12">
                                <hr>
                            </div>
                        <?php if(isset($client)): ?>
                        <?php if(count($allDue)>0): ?>
                        <?php echo Form::open(array('route' => 'inventory-sales-payment.store','class'=>'form-horizontal author_form','method'=>'POST','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')); ?>

                        <div id="print_body" style="width: 100%;overflow: hidden; padding: 10px 20px;">
                          <?php echo $__env->make('pad.header', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>
                            <table width="100%">
                                <tr>
                                    <td><b>Organization Name : </b> <? echo $client->company_name ?></td>
                                    <td><b>Mobile : </b> <? echo $client->mobile_no ?></td>
                                    <td><b>Address : </b> <? echo $client->address ?></td>
                                    <td><b>Email : </b> <? echo $client->email_id ?></td>
                                </tr>
                            </table>
                            <br>
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="success">
                                        <th width="5%">SL</th>
                                        <th>Invoice ID</th>
                                        <th>Date</th>
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
                                <?php $__currentLoopData = $allDue; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $data): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                <? 
                                $i++;
                                 $total+=$data->total_amount;
                                 $paid+=$data->paid_amount;
                                 $due+=($data->total_amount-$data->paid_amount);
                                ?>
                                <tr>
                                    <td><?php echo e($i); ?></td>
                                    <td> <a href='<?php echo e(URL::to("inventory-sales-invoice/$data->invoice_id")); ?>'><?php echo e($data->invoice_id); ?></a> </td>
                                    <td><?php echo e($data->date); ?></td>
                                    <td><?php echo e(round($data->total_amount,3)); ?>

                                    </td>
                                    <td><?php echo e(round($data->paid_amount,3)); ?></td>
                                    <td><?php echo e(round($data->total_amount-$data->paid_amount,3)); ?></td>
                                </tr>
                                <input type="hidden" name="fk_sales_id[]" value="<?php echo e($data->id); ?>">
                                <input type="hidden" name="sales_last_due[]" value="<?php echo e($data->total_amount-$data->paid_amount); ?>">
                                <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                <tr class="active">
                                    <th colspan="3" style="text-align: right;">Total = </th>
                                    <th><?php echo e(round($total,2)); ?></th>
                                    <th><?php echo e(round($paid,2)); ?></th>
                                    <th><?php echo e(round($due,2)); ?></td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="printFooter" style="overflow: hidden;width: 100%;">
                           <?php echo $__env->make('pad.footer', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>
                        </div>
                        </div><!-- / print-body -->
                      
                        <input type="hidden" name="fk_client_id" value="<?php echo e($client->id); ?>">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="control-label col-md-4">Select Account : </label>
                                <div class="col-md-8">
                                <?php echo e(Form::select('fk_account_id',$account,'1',['class'=>'form-control'])); ?>

                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4">Select Method : </label>
                                <div class="col-md-8">
                                    <?php echo e(Form::select('fk_method_id',$method,'3',['class'=>'form-control'])); ?>

                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4">Ref ID : </label>
                                <div class="col-md-8">
                                    <input type="text" class="form-control" name="ref_id" placeholder="Ref ID">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group aside_system">
                            <input type="hidden" name="total_amount" value="<?php echo e(round($total,2)); ?>">
                                <label class="col-md-4">Payable Amount :</label>
                                <div class="input-group col-md-8">
                                    <div class="input-group-addon currency">৳</div>
                                    <input value="<?php echo e(round($due,2)); ?>" class="form-control" name="last_due" id="subTotal" placeholder="Total Amount" readonly>
                                </div>
                            </div>
                            <div class="form-group aside_system">
                                <label class="col-md-4">Paid Amount :</label>
                                <div class="input-group col-md-8">
                                    <div class="input-group-addon currency">৳</div>
                                    <input value="0" type="number" min="0" step="any" class="form-control" name="paid" id="amountPaid" placeholder="Paid Amount" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;">
                                </div>
                            </div>
                            
                            <div class="form-group aside_system">
                                <label class="col-md-4">Amount Due :</label>
                                <div class="input-group col-md-8">
                                    <div class="input-group-addon currency">৳</div>
                                    <input value="<?php echo e(round($due,2)); ?>" type="number" min="0" step="any" class="form-control amountDue"  id="amountDue" placeholder="Amount Due" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly >
                                </div>
                            </div>
                            <div class="form-group aside_system">
                                <label class=" col-md-4">Payment Date :</label>
                                <div class="input-group col-md-8">
                                   <input type="text" name="payment_date" class="form-control datepicker" value="<?php echo e(date('d-m-Y')); ?>" required>
                                </div>
                            </div>
                            <div class="form-group aside_system">
                                <div class="input-group col-md-12">
                                  <button type="submit" class="btn btn-info pull-right">Submit Payment</button>
                                </div>
                            </div>
                            
                        </div>
                        <?php echo e(Form::close()); ?>

                        <?php else: ?>
                        <table width="100%">
                            <tr>
                                <td><b>Name : </b> <? echo $client->client_name ?></td>
                                <td><b>Mobile : </b> <? echo $client->mobile_no ?></td>
                                <td><b>Address : </b> <? echo $client->address ?></td>
                                <td><b>Email : </b> <? echo $client->email_id ?></td>
                            </tr>
                        </table>
                        <h2 class="text-center text-success">This client has no due.</h2>
                        <?php endif; ?>
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
    $('#amountPaid').on('change keyup blur',function(){
        var total=$('#subTotal').val();
        var paid =$(this).val();
        $('#amountDue').val(total-paid);
    })
    function printPage(id){
        $('#'+id).printThis();
    }
    function loadDue(id){
        window.location='<?php echo e(URL::to("/inventory-sales-payment")); ?>/'+id;
    }
</script>
<?php $__env->stopSection(); ?>

<?php echo $__env->make('layout.app', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>