
    <?php $__env->startSection('content'); ?>
    <style type="text/css">
        .no_padding{padding: 0 !important;}
        .filter_info{display: none;}
        .invoice_top{display: block;position: fixed; top: 0;left: 0;width: 100%;}
        .print_footer{position: fixed; bottom: 0;left: 0;width: 100%;display: none;}
            .print_body{padding-bottom: 100px;}

        @media  print {
            @page  {
                    size: auto;   /* auto is the initial value */
                    margin: 5mm;  /* this affects the margin in the printer settings */
                }
            .filter_info{display: block;}
            .invoice_top{display: block;}
            .print_footer{display: block;}
            .panel-heading-btn {display: none;}
            .report_filler {display: none;}
            .panel-title {display: none;}
            .printbtn {display: none;}
            .print_body{padding-bottom: 100px;}
            .print_footer {
              font-size: 9px;
              color: #f00;
              text-align: center;
            }

           
        }
    </style>
    
    <!-- begin #content -->
    <div id="content" class="content">
        
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" onclick="printPage('print_body')" class="printbtn btn btn-xs btn-success pull-right"><i class="fa fa-print m-r-5"></i> Print</a>
                        </div>
                        <h4 class="panel-title">Receivable Due</h4>
                    </div>
                    <div class="panel-body print_body">
                        <div class="report_filler">
                            <div class="row">
                                <? 
                                $branchId='';
                                if(isset($input['branch'])){
                                    $branchId=$input['branch'];
                                }?>
                                <?php if(Auth::user()->isRole('administrator')): ?>
                                <div class="form-group col-md-3 no-padding">
                                    <label class="control-label col-md-12">Select Branch :</label>
                                    <div class="col-md-12">
                                        <?php echo e(Form::select('branch',$branch,$branchId,['class'=>'form-control','placeholder'=>'All Branch','id'=>'branch'])); ?>

                                    </div>
                                </div>
                                
                                 
                                
                                <div class="form-group col-md-1">
                                 <label class="col-md-12" for="Date">&nbsp;</label>
                                       
                                    <div class="col-sm-12 ">

                                        <button type="submit" id="submit" class="btn btn-success btn-bordred waves-effect w-md waves-light m-b-5">
                                            Confirm
                                        </button>
                                    </div>
                                </div>
                                <?php else: ?>
                                <input type="hidden" id='branch' value="<?php echo e(Auth::user()->fk_branch_id); ?>">
                                <?php endif; ?>

                            
                            </div> 
                        </div>
                        <br>
                        <div id="print_body">
                            <?php echo $__env->make('pad.header', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>
                            <style type="text/css">
                                @page  {
                                  margin-bottom: 100px;
                                }
                            </style>
                            <div class="report_result" id="load_result">
                                <?php if(isset($allData)): ?>
                                <? echo $allData; ?>
                                <?php endif; ?>
                            </div>
                      
                    </div>
                
                    </div>
                </div>
            </div>
        </div>
    <!-- end #content -->
<?php $__env->stopSection(); ?>
<?php $__env->startSection('script'); ?>
<script src="<?php echo e(asset('public/custom_js/printThis.js')); ?>"></script>
<script type="text/javascript">
    function printPage(id){
        $('#'+id).printThis();
    }
    $("#submit").click(function(){
        var branch = $("#branch").val();
        window.location='<?php echo e(URL::to("/inventory-report-receivable")); ?>?branch='+branch;
    });

</script>
<?php $__env->stopSection(); ?>
<?php echo $__env->make('layout.app', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>