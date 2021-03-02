<?php echo e(Form::select('user',$users,'',['class'=>'form-control select userLoad','placeholder'=>'All Users'])); ?>

 <script src="<?php echo e(asset('public/plugins/jquery/jquery-1.9.1.min.js')); ?>"></script>
 <script src="<?php echo e(asset('public/js/chosen.jquery.js')); ?>" type="text/javascript"></script> 
 <script type="text/javascript">
 	$('.select').chosen("liszt:updated");
 </script>