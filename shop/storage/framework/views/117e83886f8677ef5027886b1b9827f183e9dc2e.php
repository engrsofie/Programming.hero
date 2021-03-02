<footer class="sticky-footer">
  <div class="container">
    <div class="text-center">
      <div class="powered">
            <span>Powered By: </span><b> Code Planners</b>
        </div>
    </div>
  </div>
</footer>
<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top">
  <i class="fa fa-angle-up"></i>
</a>
     <input type="hidden" value="<?php echo e(URL::to('')); ?>" id="rootUrl">
    <!-- Bootstrap core JavaScript-->
    <script src="<?php echo e(asset('public/plugins/jquery/jquery-1.9.1.min.js')); ?>"></script>
    <script src="<?php echo e(asset('public/dashboard/ui/jquery-ui.js')); ?>"></script>
    <script src="<?php echo e(asset('public/dashboard/vendor/popper/popper.min.js')); ?>"></script>
    <script src="<?php echo e(asset('public/dashboard/vendor/bootstrap/js/bootstrap2.min.js')); ?>"></script>
    <!-- Core plugin JavaScript-->
    <script src="<?php echo e(asset('public/dashboard/vendor/jquery-easing/jquery.easing.min.js')); ?>"></script>
    <!-- Page level plugin JavaScript-->
    <!-- <script src="<?php echo e(asset('public/dashboard/vendor/chart.js/Chart.min.js')); ?>"></script> -->
    <script src="<?php echo e(asset('public/dashboard/vendor/datatables/jquery.dataTables.js')); ?>"></script>
    <script src="<?php echo e(asset('public/dashboard/vendor/datatables/dataTables.bootstrap4.js')); ?>"></script>
    <!-- Custom scripts for all pages-->
    <script src="<?php echo e(asset('public/dashboard/js/sb-admin.min.js')); ?>"></script>
    <?php if(Request::path()=='dashboard'): ?>
    <script src="<?php echo e(asset('public/dashboard/vendor/chart.js/Chart.min.js')); ?>"></script>
    <script src="<?php echo e(asset('public/dashboard/js/sb-admin-charts.min.js')); ?>"></script>
    <?php endif; ?>
    <!-- Custom scripts for this page-->
    <script src="<?php echo e(asset('public/dashboard/js/sb-admin-datatables.min.js')); ?>"></script>
    <script src="<?php echo e(asset('public/plugins/parsley/dist/parsley.js')); ?>"></script>
    <script src="<?php echo e(asset('public/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js')); ?>"></script>
    <script src="<?php echo e(asset('public/js/chosen.jquery.js')); ?>" type="text/javascript"></script> 
    <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.5/sweetalert2.all.js" type="text/javascript"></script> 
    
    <!-- tinymce editor -->
    <script src="<?php echo e(asset('public/tinymce/js/tinymce/tinymce.min.js')); ?>"></script>
    <script type="text/javascript">
        tinymce.init({
          selector: '.textEditor',  // change this value according to your HTML
          plugin: 'a_tinymce_plugin',
          a_plugin_option: true,
          a_configuration_option: 400
        });
    </script>
    <script type="text/javascript">
        $('.select').chosen("liszt:updated");
        
        function confirmDelete(){
            return confirm("Do You Sure Want To Delete This Data ?");
        }
        $('form').on('focus', 'input[type=number]', function (e) {
          $(this).on('mousewheel.disableScroll', function (e) {
            e.preventDefault()
          })
        })
        $('form').on('blur', 'input[type=number]', function (e) {
          $(this).off('mousewheel.disableScroll')
        })
        $('.datepicker').datepicker({
            format: "dd-mm-yyyy",
            autoclose: true
        });
        $(document).ready(function(){
            $('a').attr('tabindex','-1');
        });
    </script>
    <!-- <script src="<?php echo e(asset('public/dashboard/js/sb-admin-charts.min.js')); ?>"></script> -->


<?php if(Session::has('success')): ?>
    <script type="text/javascript">
        swal({
          type: 'success',
          title: '<?php echo e(Session::get("success")); ?>',
          showConfirmButton: false,
          timer: 1500
        })
    </script>
    <?php endif; ?>
    <?php if(Session::has('error')): ?>
    <script type="text/javascript">
        swal({
          type: 'error',
          title: '<?php echo e(Session::get("error")); ?>',
          showConfirmButton: true
        })
    </script>
    <?php endif; ?>
    <script type="text/javascript">
        function deleteConfirm(id){
            swal({
              title: 'Are you sure?',
              text: "You won't be able to revert this!",
              type: 'warning',
              showCancelButton: true,
              confirmButtonColor: '#3085d6',
              cancelButtonColor: '#d33',
              confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
              if (result.value) {
                $("#"+id).submit();
              }
            })
        }
        $('#branch').on('change',function(){
        var id = $(this).val();
        window.location='<?php echo e(URL::to("/branch-change")); ?>/'+id;
      });
    </script>