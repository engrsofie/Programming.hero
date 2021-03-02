<div class="form-group col-md-3">
    <label class="col-md-12" for="Date">Select employe * :</label>
    <div class="col-md-12">
        <?php echo e(Form::select('fk_employe_id',$employe,'',['class'=>'form-control selectCustomer','placeholder'=>'Select employe','required','id'=>'employe'])); ?>

    </div>
</div>
<script src="<?php echo e(asset('public/plugins/jquery/jquery-1.9.1.min.js')); ?>"></script>  
<script src="<?php echo e(asset('public/js/chosen.jquery.js')); ?>" type="text/javascript"></script> 
<script type="text/javascript">
    $('.selectCustomer').chosen("liszt:updated");
</script>