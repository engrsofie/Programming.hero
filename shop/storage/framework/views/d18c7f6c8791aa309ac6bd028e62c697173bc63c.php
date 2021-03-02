
<?php $__env->startSection('content'); ?>
 <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.15/css/jquery.dataTables.min.css">
<div id="content" class="content">
	<div class="row">
	    <div class="col-md-12">
            <div class="panel panel-inverse">
                <div class="panel-heading"> 
                    <div class="panel-heading-btn">
                            <a class="btn btn-info btn-xs" href="<?php echo e(URL::to('/barcode/create')); ?>">Add New</a>
                            
                        </div>
                    <h4 class="panel-title">Generated Product Barcode</h4>
                </div>
                <div class="panel-body">
                	<table class="table table-bordered" id="all_data">
                        <thead>
                            <tr class="active">
                                <th>Barcode</th>
                                <th>Product Name</th>
                                <th>Product Model</th>
                                <th width="15%">Action</th>
                            </tr>
                        </thead>
                        
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<?php $__env->stopSection(); ?>
<?php $__env->startSection('script'); ?>
<script type="text/javascript">
    $(function() {
            $('#all_data').DataTable( {
                processing: true,
                serverSide: true,
                ajax: '<?php echo e(URL::to("allBarcode")); ?>',
                columns: [
                    { data: 'barcode'},
                    { data: 'product_name',name:'inventory_product.product_name'},
                    { data: 'model_name',name:'inventory_product_model.model_name'},
                    { data: 'action'},
                ]
            });
            
        });
</script>
<?php $__env->stopSection(); ?>
<?php echo $__env->make('layout.app', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>