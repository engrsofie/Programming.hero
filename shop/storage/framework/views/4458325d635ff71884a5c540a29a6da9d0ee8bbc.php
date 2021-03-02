<div class="invoice-content">
    <div class="table-responsive">
    
    <div class="filter_info">
        <h3 align="center">Account Cash Reports</h3>
        <table class="table table-bordered">
            <tr>
                 <td><b>Date : </b> <?php echo e($filterData['start']); ?> - <?php echo e($filterData['start']); ?></td>
                <td><b>Branch : </b> <?php echo e($filterData['branch']); ?></td>
                <td><b>User : </b> <?php echo e($filterData['user']); ?></td>
            </tr>
        </table>
    </div>
    <div class="div">
    <div class="col-md-12">
    <p>Deposit</p>
        <table class="table table-bordered padding5">
            <thead>
                <tr class="success">
                    <th>SL</th>
                    <th>Client Name</th>
                    <th>Sector Name</th>
                    <th>Total</th>
                    <th>Paid</th>
                    <th>Due</th>
                </tr>
            </thead>
            <tbody>
            <? 
            $i=1;
            $totalSales=0;
            $totalPaidSales=0;
             ?>
            <?php $__currentLoopData = $sales; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $sale): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
            <?
            $totalSales+=$sale->total_amount;
            $totalPaidSales+=$sale->paid_amount;
            ?>
                <tr>
                    <td><?php echo e($i++); ?></td>
                    <td><?php echo e($sale->client_name); ?></td>
                    <td>Product Sales</td>
                    <td><?php echo e(round($sale->total_amount,3)); ?></td>
                    <td><?php echo e(round($sale->paid_amount,3)); ?></td>
                    <td><?php echo e(round($sale->total_amount-$sale->paid_amount,3)); ?></td>
                </tr>
            <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>

            <? 
            $totalAmount=0;
            $totalPaid=0;
             ?>
            <?php $__currentLoopData = $depositReports; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $subReport): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
            <?
            $totalAmount+=$subReport->total_amount;
            $totalPaid+=$subReport->total_paid;
            ?>
                <tr>
                    <td><?php echo e($i++); ?></td>
                    <td><?php echo e($subReport->client_name); ?></td>
                    <td><?php echo e($subReport->sub_category_name); ?></td>
                    <td><?php echo e($subReport->total_amount); ?></td>
                    <td><?php echo e($subReport->total_paid); ?></td>
                    <td><?php echo e($subReport->total_amount-$subReport->total_paid); ?></td>
                </tr>
            <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
            </tbody>
            <tfoot>
                <tr class="active">
                    <th>*</th>
                    <th colspan="2" class="text-right">Total = </th>
                    <th><?php echo e(round($totalAmount+$totalSales,3)); ?></th>
                    <th><?php echo e(round($totalPaid+$totalPaidSales,3)); ?></th>
                    <th><?php echo e(round(($totalAmount-$totalPaid)+($totalSales-$totalPaidSales),3)); ?></th>
                </tr>
                
            </tfoot>
        </table>
    </div>
    <div class="col-md-12">
        <p>Payment</p>
        <table class="table table-bordered padding5">
            <thead>
                <tr class="success">
                    <th>SL</th>
                    <th>Client Name</th>
                    <th>Sector Name</th>
                    <th>Total</th>
                    <th>Paid</th>
                    <th>Due</th>
                </tr>
            </thead>
            <tbody>
                
            <? 
            $i=3;
            $totalAmount=0;
            $totalPaid=0;
             ?>
            <?php $__currentLoopData = $paymentReports; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $subReport): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
            <?
            $totalAmount+=$subReport->total_amount;
            $totalPaid+=$subReport->total_paid;
            ?>
                <tr>
                    <td><?php echo e($i++); ?></td>
                    <td><?php echo e($subReport->client_name); ?></td>
                    <td><?php echo e($subReport->sub_category_name); ?></td>
                    <td><?php echo e($subReport->total_amount); ?></td>
                    <td><?php echo e($subReport->total_paid); ?></td>
                    <td><?php echo e($subReport->total_amount-$subReport->total_paid); ?></td>
                </tr>
            <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
            <? 
            $totalSalary=0;
            $totalPaidSalary=0;
             ?>
            <?php $__currentLoopData = $salary; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $emp): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
            <?
            $totalSalary+=$emp->total_amount;
            ?>
                <tr>
                    <td><?php echo e($i++); ?></td>
                    <td><?php echo e($emp->employe_name); ?></td>
                    <td>Salary</td>
                    <td><?php echo e(round($emp->total_amount,3)); ?></td>
                    <td><?php echo e(round($emp->total_amount,3)); ?></td>
                    <td>0</td>
                </tr>
            <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
            </tbody>
            <tfoot>
                <tr class="active">
                    <th>*</th>
                    <th colspan="2" class="text-right">Total = </th>
                    <th><?php echo e(round($totalAmount+$totalSalary,3)); ?></th>
                    <th><?php echo e(round($totalPaid+$totalSalary,3)); ?></th>
                    <th><?php echo e(round($totalAmount-$totalPaid,3)); ?></th>
                </tr>
                
            </tfoot>
        </table>
    </div>
    </div>
        
    </div>
    
</div>