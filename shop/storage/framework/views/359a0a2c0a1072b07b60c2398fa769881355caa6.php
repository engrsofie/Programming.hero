 <table class="table table-bordered">
     <tr>
         <td>Name: <?php echo e($employe->employe_name); ?></td>
         <td>ID: <?php echo e($employe->employe_id); ?></td>
         <td>Desg: <?php echo e($employe->designation); ?></td>
         <td>Section: <?php echo e($employe->section_name); ?></td>
     </tr>
 </table>
	<div class="form-group col-md-3">
        <label class="col-md-12" for="basic_pay">Basic Pay :</label>
        <div class="col-md-12">
            <input class="form-control salary allowance" type="number" min="0" step="any" id="basic_pay" name="basic_pay" placeholder="Basic Pay" value="<?php echo e($employe->basic_pay); ?>" required />
        </div>
    </div>
    <div class="form-group col-md-3">
        <label class="col-md-12" for="house_rent">House Rent :</label>
        <div class="col-md-12">
            <input class="form-control salary allowance" type="number" min="0" step="any" id="house_rent" name="house_rent" placeholder="House Rent" value="<?php echo e($employe->house_rent); ?>" />
        </div>
    </div>
    <div class="form-group col-md-3">
        <label class="col-md-12" for="medical_allowance">Medical Allowance :</label>
        <div class="col-md-12">
            <input class="form-control salary allowance" type="number" min="0" step="any" id="medical_allowance" name="medical_allowance" placeholder="Medical Allowance" value="<?php echo e($employe->medical_allowance); ?>" />
        </div>
    </div>
    <div class="form-group col-md-3">
        <label class="col-md-12" for="medical_allowance">Select Date :</label>
        <div class="col-md-12">
            <input class="form-control" type="date" id="date" name="date" placeholder="Date" value="<?php echo e(date('Y-m-d')); ?>" />
        </div>
    </div>
    <div class="col-md-6">
        <h4><u>Others Allowance</u></h4>
    <?php $__currentLoopData = $allowance; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $all): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
        <div class="form-group">
            <label class="col-md-12" for="medical_allowance"><?php echo e($all->title); ?> :</label>
            <div class="col-md-12">
                <input type="hidden" name="allowance_id[]" value="<?php echo e($all->id); ?>">
                <input class="form-control salary allowance" type="number" min="0" step="any" id="medical_allowance" name="allowance[]" />
            </div>
        </div>
    <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
    </div>
    <div class="col-md-6">
        <h4><u>Deduction</u></h4>
    <?php $__currentLoopData = $deduction; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $ded): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
        <div class="form-group">
            <label class="col-md-12" for="medical_allowance"><?php echo e($ded->title); ?> :</label>
            <div class="col-md-12">
                <input type="hidden" name="allowance_id[]" value="<?php echo e($ded->id); ?>">
                <input class="form-control salary deduction " type="number" min="0" step="any" id="medical_allowance" name="allowance[]" />
            </div>
        </div>
    <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>


    </div>
    <div class="col-md-6">
        <h4><u>Payment Method</u></h4>
        <div class="form-group">
            <label class="col-md-12">Select Account :</label>
            <div class="col-md-12">
                <?php echo e(Form::select('fk_account_id',$account,1,['class'=>'form-control','placeholder'=>'Select Account','required'])); ?>

            </div>
        </div>
        <div class="form-group">
            <label class="col-md-12">Select Method :</label>
            <div class="col-md-12">
                <?php echo e(Form::select('fk_method_id',$method,3,['class'=>'form-control','placeholder'=>'Select Method','required'])); ?>

            </div>
        </div>
        <div class="form-group">
            <label class="col-md-12">Ref ID # :</label>
            <div class="col-md-12">
                <input type="text" name="ref_id" class="form-control" placeholder="Ref ID">
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <h4><u>Total Amount</u></h4>
        <? $total=$employe->basic_pay+$employe->house_rent+$employe->medical_allowance; ?>
        <div class="form-group">
            <label class="col-md-12">Salary &amp; Benefits :</label>
            <div class="col-md-12">
                <input type="number" name="total_amount" class="form-control" id="total" readonly value="<?php echo e($total); ?>">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-12">Deduction Amount :</label>
            <div class="col-md-12">
                <input type="number" name="deduction" class="form-control" id="deduction" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-12">Net Payable Amount :</label>
            <div class="col-md-12">
                <input type="number" min="0" step="any" name="paid_amount" class="form-control" id="paid" required value="<?php echo e($total); ?>">
            </div>
        </div>
        
        
        <div class="form-group">
            <div class="col-md-12">
                <button type="submit" class="btn btn-success pull-right">Prepare</button>
            </div>
        </div>
    </div>
    
<?php echo Form::close();; ?>


<script src="<?php echo e(asset('public/plugins/jquery/jquery-1.9.1.min.js')); ?>"></script>
<script type="text/javascript">
   $(document).on('change keyup blur','.salary',function(){
    var alloweance = 0;
    var deduction = 0;
    var total = 0;
    $('.allowance').each(function(){
        if($(this).val() != '' )alloweance += parseFloat( $(this).val() );
    });
    $('.deduction').each(function(){
        if($(this).val() != '' )deduction += parseFloat( $(this).val() );
    });
    total=alloweance-deduction;
    $('#deduction').val(deduction);
    $('#total').val( alloweance );
    $('#paid').val( total );
    });

</script>