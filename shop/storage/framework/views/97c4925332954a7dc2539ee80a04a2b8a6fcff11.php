

	<?php $__env->startSection('content'); ?>
    <style type="text/css">
        .transition_cul_section{margin-left: 0 !important; margin-right: 0 !important;}
        .filter_info{display: none;}
        .company_header{display: none;}
        .companyFooter{display: none;}

        @media  print {
            @page  {
                    size: auto;   /* auto is the initial value */
                    margin: 5mm;  /* this affects the margin in the printer settings */
                }
            .filter_info{display: block;}
            .company_header{display: block;}
            .companyFooter{display: block;}
            .invoice_top{display: block;}
            .print_footer{display: block;}
            .panel-heading-btn {display: none;}
            .report_filler {display: none;}
            .panel-title {display: none;}
            .printbtn {display: none;}
            .print_body{padding-bottom: 100px;}
            .col-md-6{width: 50%;float: left;padding: 5px;overflow: hidden;}
            .col-md-12{width:100%;overflow: hidden;}
            .div{width: 100%;overflow: hidden;}
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
                    <button class="btn btn-xs btn-info pull-right printbtn" onclick="printPage('print_body')">Print</button>
                        <h4 class="panel-title">Account Cash Reports </h4>
                    </div>
                    <div class="panel-body">
                        <!-- <form method="post"> -->
                        	<div class="form-group">
								
								<input class="form-control" type="hidden" id="client" name="company_name" placeholder="Company Name" data-parsley-required="true" />
                                <input type="hidden" id="_token" name="_token" value="<?php echo e(csrf_token()); ?>">
                                
							</div>
							<div class="report_filler">
                                <?php echo Form::open(['url'=>'report-cash','class'=>'form-horizontals','method'=>'get']); ?>

                                <div class="row">
                                <div class="form-group col-md-2 no-padding">
                                     <label class="control-label col-md-12 no-padding-right" for="Date">Start Date* :</label>
                                    <div class="col-md-12 no-padding-right">
                                        <?php echo e(Form::text('start',date('d-m-Y'),['class'=>'form-control datepicker','placeholder'=>'Start Date','id'=>'start','required'])); ?>

                                    </div>
                                </div>
                                <div class="form-group col-md-1">
                                    <label class="col-md-12"> &nbsp; </label>
                                    <div class="col-md-12 no_padding" >
                                    <input class="form-control text-center" type="text" value="TO" readonly>
                                        <!-- <b>TO</b> -->
                                    </div>
                                </div>
                                <div class="form-group col-md-2 no-padding">
                                 <label class="control-label col-md-12 no-padding" for="Date">End Date* :</label>
                                    <div class="col-md-12 no-padding">
                                        <?php echo e(Form::text('end',date('d-m-Y'),['class'=>'form-control datepicker','placeholder'=>'End Date','id'=>'end','required'])); ?>

                                    </div>
                                </div>
                            <?php if(Auth::user()->isRole('administrator')): ?>
                                <div class="form-group col-md-3">
                                 <label class="control-label col-md-12  no-padding" for="Date">Branch :</label>
                                    <div class="col-md-12  no-padding">
                                        <?php echo e(Form::select('branch',$branch,'',['class'=>'form-control branchLoad','placeholder'=>'All Branch'])); ?>

                                    </div>
                                </div>
                            <?php endif; ?>
                            <?php if(Auth::user()->isRole('branch-admin') or Auth::user()->isRole('administrator')): ?>
                                <div class="form-group col-md-2 no-padding">
                                 <label class="control-label col-md-12  no-padding" for="Date">Users :</label>
                                    <div class="col-md-12  no-padding" id="users">
                                        <?php echo e(Form::select('user',$users,'',['class'=>'form-control select userLoad','placeholder'=>'All Users'])); ?>

                                    </div>
                                </div>
                            <?php endif; ?>
                                <div class="form-group col-md-1">
                                 <label class="col-md-12" for="Date">&nbsp;</label>
                                       
                                    <div class="col-sm-12 ">

                                        <button type="submit" id="submit" class="btn btn-success btn-bordred waves-effect w-md waves-light m-b-5">
                                            Confirm
                                        </button>
                                    </div>
                                </div>
                            </div> 
                            <?php echo Form::close(); ?>

                        </div>
                        <!-- </form> -->
                        <div id="print_body">
                            
                        <div class="company_header">
                            <?php echo $__env->make('pad.header', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>
                        </div>
                        
                            <div id="show-report">
                                <?php if(isset($reports)): ?>
                                    <? echo $reports; ?>
                                <?php endif; ?>
                            </div>
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
    $(document).on('change','.branchLoad',function(){
        var id = $(this).val();
        $.ajax({
            url:"<?php echo e(URL::to('branch-wise-user')); ?>/"+id,
            type:"GET",
            data:{},
            success: function(result){
                $('#users').html(result);
            }
        });
    });
</script>
<script src="<?php echo e(asset('public/custom_js/printThis.js')); ?>"></script>
<script type="text/javascript">
    function printPage(id){
        $('#'+id).printThis();
    }
</script>
<?php $__env->stopSection(); ?>
<?php echo $__env->make('layout.app', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>