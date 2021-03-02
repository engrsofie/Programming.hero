	
		<?php $__env->startSection('content'); ?>
		<!-- begin #content -->
		<div id="content" class="content">
			 <?php echo Form::open(array('route' => 'employe-salary.store','class'=>'form-horizontal author_form','method'=>'POST','id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')); ?>

			<div class="row">
			    <div class="col-md-12 no-padding">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                           
                                <a class="btn btn-info btn-xs" href="<?php echo e(URL::to('/employe-salary')); ?>">Prepared Salary</a>

                                
                            </div>
                            <h4 class="panel-title">Employee Salary Prepare</h4>
                        </div>
                        <div class="panel-body">
                        	    <div class="form-group col-md-3">
                                    <label class="col-md-12 no-padding" for="Date">Select Section * :</label>
                                    <div class="col-md-12 no-padding">
                                        <?php echo e(Form::select('section',$section,'',['class'=>'form-control select','placeholder'=>'Select Section','required','id'=>'section','onchange'=>"loadEmploye(this.value)"])); ?>

                                        <span class="help-text" id="section_error"></span>
                                    </div>
                                </div>
                            
                                <div id="loadEmploye"><!-- Load Employee --></div>
                                <div class="form-group col-md-4">
                                    <label class="col-md-12" for="Date"> Select Year and Month * :</label>
                                    <div class="col-md-5">
                                        <input class="form-control" type="number" min="2000" name="year" value="<?php echo e(date('Y')); ?>" placeholder="year" data-parsley-required="true" id="year" />
                                    </div>
                                    <div class="col-md-7 no-padding">
                                        <?php echo e(Form::select('month',$month,date('n'),['class'=>'form-control select','required','id'=>'month'])); ?>

                                    </div>
                                </div>
                                
								<div class="form-group col-md-1">
									<label class="col-md-12">Click</label>
									<div class="col-md-12">
										<button type="button" class="btn btn-primary" onclick="salary()">Submit</button>
									</div>
								</div>
                            <div id="salary">
                                
                            </div>

                        </div>
                    </div>
			    </div>
			</div>
		</div>
		<!-- end #content -->
		
   
    <?php $__env->stopSection(); ?>
<?php $__env->startSection('script'); ?>
<script type="text/javascript">
    function loadEmploye(section){
        $('#loadEmploye').load('<?php echo e(URL::to("employe-section-wise-load")); ?>/'+section);
    }
    function salary(){
        var employe=$('#employe').val();
        var year=$('#year').val();
        var month=$('#month').val();
                
        if(employe>0){

        $('#salary').load('<?php echo e(URL::to("employe-salary-sheet-load")); ?>?id='+employe+'&year='+year+'&month='+month);
            
        }else{
          alert('Please select section and employee!');  
        }
    }
    
</script>
<script src="<?php echo e(asset('public/custom_js/printThis.js')); ?>"></script>
<script type="text/javascript">
    function printPage(id){
        $('#'+id).printThis();
    }
</script>
<?php $__env->stopSection(); ?>
<?php echo $__env->make('layout.app', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>