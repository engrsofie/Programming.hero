<? $info=DB::table('company_info')->first(); ?>
<!DOCTYPE html>
<html lang="<?php echo e(app()->getLocale()); ?>">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSRF Token -->
    <meta name="csrf-token" content="<?php echo e(csrf_token()); ?>">
     <meta content="<?php echo e($info->company_name); ?>" name="description" />
    <meta content="<?php echo e($info->company_name); ?>" name="author" />
    <link rel="shortcut icon" type="image/png" href='<?php echo e(asset("images/company/ico/$info->company_icon")); ?>'>
    <title>Smart Account | <?php echo e($info->company_name); ?></title>
    <link rel="stylesheet" type="text/css" href="<?php echo e(asset('public/css/app.css')); ?>">

    <!-- Styles -->

    <style type="text/css">
        body{background:#d2f5ff}
        .login-section{padding-top: 50px;overflow: hidden;}
        .login-content{background: linear-gradient(#fff, rgba(1, 200, 255, 1));padding: 20px 0;padding-bottom: 30px;}
        .brand img{width: 150px;height: auto;margin-bottom: 30px;margin-top: 10px;}
        a.btn-link,p,span{color: #fff;}
    </style>
</head>
<body>
    <div id="app">
        <div class="login-section">
            <div class="container">
                <div class="row">
                    <div class="col-md-4 col-md-offset-4">
                        <div class="panel panel-default login-content">

                            <div class="panel-body">
                                <div class="brand text-center">
                                    <img src='<?php echo e(asset("images/logo.png")); ?>' alt="Smart Account">
                                </div>
                                <form class="form-horizontal" method="POST" action="<?php echo e(route('login')); ?>">
                                    <?php echo e(csrf_field()); ?>


                                    <div class="form-group<?php echo e($errors->has('email') ? ' has-error' : ''); ?>">

                                        <div class="col-md-12">
                                            <input id="email" type="email" class="form-control" name="email" value="<?php echo e(old('email')); ?>" required autofocus>

                                            <?php if($errors->has('email')): ?>
                                                <span class="help-block">
                                                    <strong><?php echo e($errors->first('email')); ?></strong>
                                                </span>
                                            <?php endif; ?>
                                        </div>
                                    </div>

                                    <div class="form-group<?php echo e($errors->has('password') ? ' has-error' : ''); ?>">

                                        <div class="col-md-12">
                                            <input id="password" type="password" class="form-control" name="password" required>

                                            <?php if($errors->has('password')): ?>
                                                <span class="help-block">
                                                    <strong><?php echo e($errors->first('password')); ?></strong>
                                                </span>
                                            <?php endif; ?>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-md-12">
                                           <a class="btn btn-link" href="<?php echo e(route('password.request')); ?>">
                                                Forgot Your Password?
                                            </a>
                                            <button type="submit" class="btn btn-primary pull-right">
                                                Login
                                            </button>

                                            
                                        </div>
                                    </div>
                                </form>
                                <div class="col-md-12 text-center">
                                    <hr>
                                    <p class="text">Helpline : 01811951215</p>
                                    <div class="powered">
                                        <span>Powered By: </span>
                                        <b> Code Planners</b>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="<?php echo e(asset('public/js/app.js')); ?>"></script>
</body>
</html>


