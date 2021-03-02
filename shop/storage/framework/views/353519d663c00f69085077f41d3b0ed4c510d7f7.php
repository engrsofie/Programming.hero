	
		<?php $__env->startSection('content'); ?>
		<!-- begin #content -->
		<div id="content" class="content">
			 
			<div class="row">
			    <div class="col-md-12">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                           
                                <a href="javascript:;" onclick="printPage('print_body')" class="printbtn btn btn-xs btn-success"><i class="fa fa-print"></i> Print</a>

                                
                            </div>
                            <h4 class="panel-title">Employee Salary</h4>
                        </div>
                        <div class="panel-body">
                            <form action="<?php echo e(URL::to('employe-salary')); ?>" method="GET">
                                <div class="form-group col-md-3">
                                    <label class="col-md-12" for="Date">Select Section * :</label>
                                    <div class="col-md-12">
                                        <?php echo e(Form::select('section',$section,'',['class'=>'form-control select','placeholder'=>'Select Section','id'=>'section'])); ?>

                                        <span class="help-text" id="section_error"></span>
                                    </div>
                                </div>
                            <?php if(Auth::user()->isRole('administrator')): ?>
                                <div class="form-group col-md-3">
                                    <label class="col-md-12" for="Date">Select Branch * :</label>
                                    <div class="col-md-12">
                                        <?php echo e(Form::select('branch',$branch,'',['class'=>'form-control select','placeholder'=>'All Branch','id'=>'branch'])); ?>

                                        <span class="help-text" id="section_error"></span>
                                    </div>
                                </div>
                            <?php endif; ?>
                                <div id="loadEmploye"><!-- Load Employee --></div>
                                <div class="form-group col-md-4">
                                    <label class="col-md-12" for="Date">Select Year and Month * :</label>
                                    <div class="col-md-5">
                                        <input class="form-control" type="number" min="2000" name="year" value="<?php echo e(date('Y')); ?>" placeholder="year" data-parsley-required="true" id="year" />
                                    </div>
                                    <div class="col-md-7">
                                        <?php echo e(Form::select('month',$month,date('n'),['class'=>'form-control select','required','id'=>'month'])); ?>

                                    </div>
                                </div>
                                
                                <div class="form-group col-md-2">
                                    <label class="col-md-12">Click</label>
                                    <div class="col-md-12">
                                        <button type="submit" class="btn btn-primary">Submit</button>
                                    </div>
                                </div>
                            </form>
                        <div id="print_body" style="width: 100%;overflow: hidden; padding: 10px 20px;">
                    <?php echo $__env->make('pad.header', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>

                            <div id="salary">
                                <h5 style="text-align: center">Salary for the moth of <?php echo e(date('F')); ?>-<?php echo e(date('Y')); ?> in all Section.</h5>
                                <table class="table table-bordered">
                                <tr class="active">
                                    <th>SL</th>
                                    <th>ID</th>
                                    <th>Employee Name</th>
                                    <th>Designation</th>
                                    <th>Section</th>
                                    <th>Salary</th>
                                    <th>Deduction</th>
                                    <th>Net Payable</th>
                                    <th ><span class="no-print"> Action</span> <span class="printable" >Signature</span> </th>
                                </tr>
                                <? $i=0; ?>
                                <?php $__currentLoopData = $salary; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $data): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                <? $i++; ?>
                                <tr>
                                    <td><?php echo e($i); ?></td>
                                    <td><?php echo e($data->employe_id); ?></td>
                                    <td><?php echo e($data->employe_name); ?></td>
                                    <td><?php echo e($data->designation); ?></td>
                                    <td><?php echo e($data->section_name); ?></td>
                                    <td><?php echo e($data->total_amount); ?></td>
                                    <td><?php echo e($data->deduction); ?></td>
                                    <td><?php echo e($data->paid_amount); ?></td>
                                    <td>
                                    <div class="no-print">
                                        
                                    <a href='<?php echo e(URL::to("employe-salary/$data->id")); ?>' class="btn btn-success btn-xs"> <i class="fa fa-eye"></i></a>

                                    <a href='<?php echo e(URL::to("employe-salary/$data->id/edit")); ?>' class="btn btn-primary btn-xs"> <i class="fa fa-pencil-square"></i></a>
                                    <?php echo Form::open(array('route'=> ['employe-salary.destroy',$data->id],'method'=>'DELETE')); ?>

                                        <?php echo e(Form::hidden('id',$data->id)); ?>

                                        <button type="submit" onclick="return confirmDelete();" class="btn btn-xs btn-danger">
                                          <i class="fa fa-trash-o"></i>
                                        </button>
                                    <?php echo Form::close(); ?>


                                    </div>
                                    </td>
                                </tr>
                                <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                    
                                </table>
                            </div><!-- /Salary -->
                            <div class="printFooter" style="overflow: hidden;width: 100%;">
                                <?php echo $__env->make('pad.footer', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>
                            </div>
                        </div><!-- /Print Body -->

                        </div>
                    </div>
			    </div>
			</div>
		</div>
		<!-- end #content -->

    <?php $__env->stopSection(); ?>
<?php $__env->startSection('script'); ?>
<script type="text/javascript">
   $(document).ready(function(){
        $('#signature3').html("Managing Director");
    })
    function salary(){
        var section=$('#section').val();
        var year=$('#year').val();
        var month=$('#month').val();
        var branch=$('#branch').val();

        $('#salary').load('<?php echo e(URL::to("employe-salary-sheet")); ?>?section='+section+'&year='+year+'&month='+month+'&branch='+branch);
            
        
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