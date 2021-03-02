<div class="filter_info">
    <h3 align="center">Receivable Due</h3>
    <table class="table table-bordered">
        <tr>
            <td><b>Branch:</b> <?php echo e(($filterData['branch']!=null)?$filterData['branch']:'ALL'); ?></td>
        </tr>
    </table>
</div>
            <table class="table table-bordered">
                <thead>
                    <tr class="success">
                       <th>Sl</th>
                        <th>Organization Name</th>
                        <th>Mobile</th>
                        <th>Address</th>
                        <th>Total Amount</th>
                        <th>Paid Amount</th>
                        <th>Total Due</th>
                    </tr>
                </thead>
                <tbody>
                    
                <? 
                    $i=0;
                    $total_due=0;
                    $total_amount=0;
                    $paid=0;
                    ?>
                    <?php $__currentLoopData = $allData; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $data): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                    <? 
                    $i++;
                    $due=$data->total_amount-$data->paid_amount;
                    $paid+=$data->paid_amount;
                    $total_due=$total_due+$due;
                    $total_amount=$total_amount+$data->total_amount;

                ?>
                    <tr>
                        <td><?php echo e($i); ?></td>
                        <td><?php echo e($data->client_name); ?></td>
                        <td><?php echo e($data->mobile_no); ?></td>
                        <td><?php echo e($data->address); ?></td>
                        <td><?php echo e(round($data->total_amount,3)); ?></td>
                        <td><?php echo e(round($data->paid_amount,3)); ?></td>
                        <td><?php echo e(round($due,3)); ?></td>
                    </tr>
                    <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                    <tr class="active">
                        <th style="text-align: right" colspan="4">Total = </th>
                        <th><?php echo e(round($total_amount,3)); ?></th>
                        <th><?php echo e(round($paid,3)); ?></th>
                        <th><?php echo e(round($total_due,3)); ?></th>
                        
                    </tr>
                                
                </tbody>
                
            </table>