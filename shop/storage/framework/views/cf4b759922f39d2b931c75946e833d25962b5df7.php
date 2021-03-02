
	
		<?php $__env->startSection('content'); ?>
		<!-- begin #content -->
		<div id="content" class="content">
			
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                                 <a class="btn btn-info btn-xs" href="<?php echo e(URL::to('sms/create')); ?>"> Branch wise sms send</a>
                                 <button class="btn btn-warning btn-xs" type="button">
		                          Credit <span class="badge"><?php echo e($quantity); ?></span>
		                        </button>
                            </div>
                            <h4 class="panel-title">Manually send new sms</h4>
                        </div>
                        <div class="panel-body">
                        	<?php echo Form::open(array('url' => 'new-sms','class'=>'form-horizontal author_form','method'=>'POST', 'id'=>'commentForm','role'=>'form','data-toggle'=>'validator')); ?>

                            	<div class="form-group">
									<label class="control-label col-md-2" for="mobile_number">TO :</label>
									<div class="col-md-9">
										<input class="form-control" type="text" id="mobile_number" name="number" placeholder="8801xxxxxxx,8801xxxxxxx" required />
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-md-2" for="message">Message :</label>
									<div class="col-md-9">
										<textarea class="form-control" id="message" name="message" placeholder="Type your message here." rows="3" maxlength="640" required></textarea>
										<p class="text-right"><small><span id="smsLenght">0</span> / 640</small></p>
										<input type="hidden" name="length" id="inputLenght">
									</div>
								</div>
								
								<div class="form-group">
									<label class="control-label col-md-2"></label>
									<div class="col-md-9">
										<button type="submit" class="btn btn-primary">Send</button>
									</div>
								</div>
                            <?php echo Form::close();; ?>

                        </div>
                    </div>
			    </div>
			</div>
		</div>
		<!-- end #content -->
		
    
    <?php $__env->stopSection(); ?>
<?php $__env->startSection('script'); ?>
<script type="text/javascript">

$(document).on('keypress blur keyup keydown','#message',function(){
	var value = $(this).val().length;
	$('#smsLenght').html(value);
	$('#inputLenght').val(value);
})
$("textarea#message[maxlength]").on("propertychange input", function() {
        if (this.value.length > this.maxlength) {
            this.value = this.value.substring(0, this.maxlength);
        }  
    });
</script>
<?php $__env->stopSection(); ?>
<?php echo $__env->make('layout.app', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>