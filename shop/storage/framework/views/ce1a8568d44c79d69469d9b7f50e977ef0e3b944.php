<? $info=DB::table('company_info')->first();
$branch=App\Models\InventoryBranch::where('status',1)->pluck('branch_name','id');
 ?>
<!DOCTYPE html>
<html lang="en">

<head>
  <title><?php echo e($info->company_name); ?></title>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta content="<?php echo e($info->company_name); ?>" name="description" />
    <meta content="<?php echo e($info->company_name); ?>" name="author" />
    <meta name="csrf-token" content="<?php echo e(csrf_token()); ?>">
    <link rel="shortcut icon" type="image/png" href='<?php echo e(asset("images/company/ico/$info->company_icon")); ?>'>
   <link href="<?php echo e(asset('public/dashboard/ui/jquery-ui.css')); ?>" rel="stylesheet">
  <!-- Bootstrap core CSS-->
  <link href="<?php echo e(asset('public/dashboard/vendor/bootstrap/css/bootstrap.min.css')); ?>" rel="stylesheet">
  <link href="<?php echo e(asset('public/dashboard/vendor/bootstrap/css/bootstrap2.min.css')); ?>" rel="stylesheet">
  <link href="<?php echo e(asset('public/dashboard/vendor/bootstrap/css/bootstrap-theme.min.css')); ?>" rel="stylesheet">
  <link href="<?php echo e(asset('public/css/chosen.css')); ?>" rel="stylesheet" />
  <link href="<?php echo e(asset('public/plugins/bootstrap-datepicker/css/bootstrap-datepicker.css')); ?>" rel="stylesheet" />
  <link href="<?php echo e(asset('public/plugins/parsley/src/parsley.css')); ?>" rel="stylesheet" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.5/sweetalert2.min.css" rel="stylesheet" />
  <!-- Custom fonts for this template-->
  <link href="<?php echo e(asset('public/dashboard/vendor/font-awesome/css/font-awesome.min.css')); ?>" rel="stylesheet" type="text/css">
  <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.15/css/jquery.dataTables.min.css">
  <!-- Page level plugin CSS-->
  <!-- Custom styles for this template-->
  <link href="<?php echo e(asset('public/dashboard/css/sb-admin.css')); ?>" rel="stylesheet">
  <link href="<?php echo e(asset('public/dashboard/css/custom.css')); ?>" rel="stylesheet">
</head>

<body class="fixed-nav sticky-footer bg-blue" id="page-top">
  <!-- Navigation-->
  <nav class="navbar navbar-expand-lg navbar-blue fixed-top" id="mainNav">
    <a href="#" class="navbar-brand"><img src='<?php echo e(asset("images/logo.png")); ?>' alt="" style="width:50%;"/></a>
    <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"><i class="fa fa-bars" aria-hidden="true"></i></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarResponsive">
     <?php echo $__env->make('_partials.sidebar', array_except(get_defined_vars(), array('__data', '__path')))->render(); ?>
      <ul class="navbar-nav navbar-right">
        <li class="top-branch">
          <?php if(Auth::user()->isAdministrator()): ?>
           <?php echo e(Form::select('branch',$branch,Auth::user()->fk_branch_id,['class'=>'form-control','id'=>'branch'])); ?>

          <?php endif; ?>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle mr-lg-2" id="messagesDropdown" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="fa fa-user"></i>
            <?php echo e(Auth::user()->name); ?>

          </a>
           <?php 
                $userId = Auth::user()->id;
            ?>
          <div class="dropdown-menu" aria-labelledby="messagesDropdown">
            <h6 class="dropdown-header"><?php echo e(Auth::user()->name); ?></h6>

            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="<?php echo e(URL::to('my-profile')); ?>">
              <strong>View Profile</strong>
            </a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href='<?php echo e(URL::to("my-profile/$userId/edit")); ?>'>
            <strong>Edit Profile</strong>
            </a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="<?php echo e(URL::to('/change-my-password')); ?>">
            <strong>Change Password</strong>
            </a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="#" data-toggle="modal" data-target="#exampleModal">
            <strong><i class="fa fa-fw fa-sign-out"></i>Logout</strong>
            
            </a>
          </div>
        </li>
        <li class="nav-item">
          
            
        </li>
      </ul>
    </div>
  </nav>
<!-- Logout Modal-->
  <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
          <a class="btn btn-primary" href="<?php echo e(route('logout')); ?>"
              onclick="event.preventDefault();
                       document.getElementById('logout-form').submit();">
              Logout
          </a>

          <form id="logout-form" action="<?php echo e(route('logout')); ?>" method="POST" style="display: none;">
              <?php echo e(csrf_field()); ?>

          </form>
        </div>
      </div>
    </div>
  </div>