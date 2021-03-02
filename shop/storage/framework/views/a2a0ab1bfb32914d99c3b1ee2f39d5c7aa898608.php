<div class="filter_info">
    <h3 align="center">Sales Report</h3>
    <table class="table table-bordered">
        <tr>
            <td><b>Start Date:</b> <?php echo e($filterData['start']); ?></td>
            <td><b>End Date:</b> <?php echo e($filterData['start']); ?></td>
            <td><b>Branch :</b> <?php echo e(($filterData['branch']!=null)?$total->branch_name:'All'); ?></td>
            <td><b>Client :</b> <?php echo e(($filterData['client']>0)?$total->client_name:'All'); ?></td>
        </tr>
    </table>
</div>
            <table class="table table-bordered">
                <thead>
                    <tr class="success">
                        <th>Sl</th>
                        <th>Organization Name</th>
                        <th>Total Amount</th>
                        <th>Paid Amount</th>
                        <th>Due</th>
                        <th>Discount</th>
                    </tr>
                </thead>
                <tbody>
                <? 
                $i=0;
                $paid_amount=0;
                $total_amount=0;
                $discount=0;
                ?>
                <?php $__currentLoopData = $allData; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $data): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                <? 
                $i++;
                $paid_amount=$paid_amount+$data->paid_amount;
                $total_amount=$total_amount+$data->total_amount;
                $discount=$discount+$data->discount;
                ?>
                <tr>
                    <td><?php echo e($i); ?></td>
                    <td><?php echo e($data->client_name); ?></td>
                    <td><?php echo e(round($data->total_amount,2)); ?></td>
                    <td><?php echo e(round($data->paid_amount,2)); ?></td>
                    <td><?php echo e(round($data->total_amount-$data->paid_amount,2)); ?></td>
                    <td><?php echo e(round($data->discount,2)); ?></td>
                </tr>
                <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                <tr class="active">
                    <th>*</th>
                    <th style="text-align: right">Total = </th>
                    <th><?php echo e(round($total_amount,2)); ?></th>
                    <th><?php echo e(round($paid_amount,2)); ?></th>
                    <th><?php echo e(round($total_amount-$paid_amount,2)); ?></th>
                    <th><?php echo e(round($discount,2)); ?></th>
                    
                </tr>
                </tbody>
                
            </table>
            <table class="table table-bordered">
                <tr class="warning">
                    <td><b>Total Sales Amount : </b><?php echo e(round($total->total_amount,2)); ?></td>
                    <td><b> Paid Amonut : </b><?php echo e(round($total->paid_amount,2)); ?></td>
                    <td><b> Due Amount : </b> <?php echo e(round($total->total_amount-$total->paid_amount,2)); ?></td>
                    <td><b> Discount : </b><?php echo e(round($total->discount,2)); ?></td>
                </tr>
            </table>
