	<?php $__env->startSection('content'); ?>
    <style type="text/css">
        .modal-dialog{width: 900px;}
        .invoice-note {margin-top: 35px;}
        .printable {display: none;}
        .customerInfo p{margin-bottom: 2px;}
        .customerInfo, .invoiceInfo{float: left;padding: 0 10px;}
        .table{margin-bottom: 0px;}
        .invoice>div:not(.invoice-footer){margin-bottom: 5px;}
        @media  print {
            .col-md-6{width: 50%;float: left;}
            .alert {display: none;}
            .reflink {display: none;}
            .refId {display: inline-block;}
            .table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th{padding: 2px;}
          @page  {
              size: auto;   /* auto is the initial value */
              margin: 5mm;  /* this affects the margin in the printer settings */
            }
        }
    </style>
    <script type="text/javascript" src="<?php echo e(asset('public/js/inWords.js')); ?>"></script>
		<!-- begin #content -->
		<div id="content" class="content">
			
			<!-- begin invoice -->
			<div class="invoice">
                <div class="invoice-company">
                    <span class="pull-right hidden-print">
                   <a href="javascript:;" onclick="printPage('print_body')" class="printbtn btn btn-sm btn-success m-b-10"><i class="fa fa-print m-r-5"></i> Print</a>
                    </span>
                </div>
                <div id="print_body" style="width: 100%;overflow: hidden; padding: 10px 20px;">
                    <?php echo $__env->make('pad.header', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>
                    <div id="customer_info" style="padding: 0 10px;">
                        <div class="row">
                            <div class="invoiceInfo" style="width: 100%;">
                                <p align="center">Salary for the month of <?php echo e(date('F',strtotime("$data->year-$data->month-01"))); ?> - <?php echo e($data->year); ?></p>
                                <table border="0" style="width: 40%;margin: 0;padding: 0;border: 0;">
                                    <tr>
                                        <td><b>Name : </b></td>
                                        <td> <? echo $data->employe_name ?></td>
                                    </tr>
                                    <tr>
                                        <td><b>Employe ID : </b></td>
                                        <td> <? echo $data->employe_id ?></td>
                                    </tr>
                                    <tr>
                                        <td><b>Designation : </b></td>
                                        <td> <? echo $data->designation ?></td>
                                    </tr>
                                    <tr>
                                        <td><b>Section : </b></td>
                                        <td> <? echo $data->section_name ?></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div> 
                    <div class="invoice-content">
                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="info">
                                        <th width="5%">SL</th>
                                        <th>Details</th>
                                        <th>Amount (Tk.)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td>Basic Pay</td>
                                        <td><?php echo e($data->basic_pay); ?></td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>House Rent</td>
                                        <td><?php echo e($data->house_rent); ?></td>
                                    </tr>
                                    <tr>
                                        <td>3</td>
                                        <td>Medical Allowance</td>
                                        <td><?php echo e($data->medical_allowance); ?></td>
                                    </tr>
                                    <tr class="active">
                                        <th>*</th>
                                        <th>(A) Gross Salary </th>
                                        <th>
                                        <? $mainSalary=$data->basic_pay+$data->house_rent+$data->medical_allowance;
                                        echo $mainSalary; ?>

                                        </th>
                                    </tr>
                                    
                                    <? $i=3;
                                    $totalAllowance=0; ?>
                                    <?php $__currentLoopData = $allowance; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $all): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                    <? $i++;
                                        $totalAllowance+=$all->value;
                                     ?>
                                        <tr>
                                            <td><?php echo e($i); ?></td>
                                            <td><?php echo e($all->title); ?></td>
                                            <td><?php echo e($all->value); ?></td>
                                        </tr>
                                    <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                    <tr class="active">
                                        <th>*</th>
                                        <th>(B) Others Allowance </th>
                                        <th><?php echo e($totalAllowance); ?></th>
                                    </tr>
                                    <tr class="info">
                                        <th>*</th>
                                        <th>(A+B) Salary &amp; Benefits </th>
                                        <th><?php echo e($mainSalary+$totalAllowance); ?></th>
                                    </tr>
                                    <tr class="warning">
                                        <th colspan="3">Deduction</th>
                                    </tr>
                                    <?
                                    $totalDeduction=0; ?>
                                    <?php $__currentLoopData = $deduction; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $ded): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                    <? $i++;
                                        $totalDeduction+=$ded->value;
                                     ?>
                                        <tr>
                                            <td><?php echo e($i); ?></td>
                                            <td><?php echo e($ded->title); ?></td>
                                            <td><?php echo e($ded->value); ?></td>
                                        </tr>
                                    <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                    <tr class="danger">
                                        <th>*</th>
                                        <th>(C) Deduction Amount </th>
                                        <th><?php echo e($totalDeduction); ?></th>
                                    </tr>
                                    <tr><td colspan="3"></td></tr>
                                    <tr class="success">
                                        <th>*</th>
                                        <th>(A+B-C) Net Payable Amount </th>
                                        <th><?php echo e($mainSalary+$totalAllowance-$totalDeduction); ?></th>
                                    </tr>

                                </tbody>

                            </table>
                        </div>
                    </div>

                    <div class="printFooter" style="overflow: hidden;width: 100%;">
                       <?php echo $__env->make('pad.footer', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>
                   </div>

                </div>
                
            </div>

			<!-- end invoice -->
		</div>
		<!-- end #content -->

		
	</script>
    
<?php $__env->stopSection(); ?>
<?php $__env->startSection('script'); ?>

<script src="<?php echo e(asset('public/custom_js/printThis.js')); ?>"></script>
<script type="text/javascript">
     $(document).ready(function(){
        $('#signature1').html("Preared By <br> <?php echo e($data->user->name); ?>");
        $('#signature3').html("Received By <br> <?php echo e($data->employe_name); ?>");
    })
    function printPage(id){
        $('#'+id).printThis();
    }
</script>
<?php $__env->stopSection(); ?>
<?php echo $__env->make('layout.app', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>