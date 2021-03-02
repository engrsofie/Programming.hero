<?php echo $__env->make('_partials.header', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>
  <div class="content-wrapper">
    <div class="container-fluid">
		<!-- Breadcrumbs-->
	      
		<?php echo $__env->yieldContent('content'); ?>
	 </div>
  </div>
<?php echo $__env->make('_partials.footer', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>
<?php echo $__env->yieldContent('script'); ?>
</body>
</html>