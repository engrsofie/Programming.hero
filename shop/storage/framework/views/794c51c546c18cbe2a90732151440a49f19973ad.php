	
		<?php $__env->startSection('content'); ?>
        <style type="text/css">
            form{display: inline;}
            .form-group{width: 100%;height: auto; overflow: hidden; display: block !important; margin: 5px;}
            .form-control{width: 100% !important;}
            .all-emp{display: none;}
        </style>
		<!-- begin #content -->
		<div id="content" class="content">
			<div class="row">
			    <div class="col-md-12 no-padding">
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                                <a class="btn btn-info btn-xs" href="<?php echo e(URL::to('/employe-information/create')); ?>"> Add New Employee </a> 
                                <a href="javascript:;" onclick="printPage('print_body')" class="printbtn btn btn-xs btn-success m-b-10 pull-right"><i class="fa fa-print m-r-5"></i> Print</a>
                                
                            </div>
                            <h4 class="panel-title">All Employee</h4>
                        </div>
                        <div class="panel-body min-padding">
                             <div id="print_body" style="width: 100%;overflow: hidden;">
                

                            <?php echo $__env->make('pad.header', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>
                            <style type="text/css">
                              @media  print {
                                      @page  {
                                          size: auto;   /* auto is the initial value */
                                          margin: 5mm;  /* this affects the margin in the printer settings */
                                      }
                                      .invoice_top_left{display: block;}
                                  .btn-group {display: none;}
                                  
                                  .printbtn {display: none;}
                                  .unprint {display: none;}
                                  .unprint {display: none;}
                                  .dataTables_length {display: none;}
                                  .dataTables_filter {display: none;}
                                  .dataTables_info {display: none;}
                                  .dataTables_paginate{display: none;}
                                  .panel-title {display: none;}
                                  table.dataTable thead .sorting_asc:after {display: none;}
                                  table tr td:last-child{display: none;}
                                  .all-emp{display: block;}
                              }
                            </style>
                            <h5 align="center" class="all-emp">All Employee</h5>
                            <table id="all_data" class="table table-striped table-bordered nowrap" width="100%">
                                <thead>
                                    <tr>
                                        <th width="5%">#ID</th>
                                        <th>Employe Name</th>
                                        <th>Designation</th>
                                        <th>Section</th>
                                        <th>Mobile</th>
                                        <th>Branch</th>
                                        <th width="10%">Photo</th>
                                        <th class="no-print">Action</th>
                                    </tr>
                                </thead>
                                
                            </table>
                        </div>
                        </div>
                    </div>
			    </div>
			</div>
		</div>		
<?php $__env->stopSection(); ?>
<?php $__env->startSection('script'); ?>
<script src="<?php echo e(asset('public/custom_js/printThis.js')); ?>"></script>
<script type="text/javascript">
    function printPage(id){
        $('#'+id).printThis();
    }
</script>
<script type="text/javascript">
    $(function() {
        $('#all_data').DataTable( {
            processing: true,
            serverSide: true,
            ajax: '<?php echo URL::asset("employe-information/show"); ?>',
            columns: [
                { data: 'employe_id'},
                { data: 'employe_name'},
                { data: 'designation'},
                { data: 'section_name',name:'employe_section.section_name'},
                { data: 'mobile_number'},
                { data: 'branch_name',name:'inventory_branch.branch_name'},
                { data: 'photo'},
                { data: 'action'}
            ]
        });
    });
</script>
<?php $__env->stopSection(); ?>

<?php echo $__env->make('layout.app', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>