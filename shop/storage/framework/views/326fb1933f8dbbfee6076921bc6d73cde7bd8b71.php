 <? $url=Request::path(); 
    $menus=DB::table('menu')->where('status',1)->orderBy('serial_num','ASC')->get();
    $allUrl=array();
 ?>
 <ul class="navbar-nav navbar-sidenav" id="exampleAccordion">

            <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Dashboard">
              <a class="nav-link" href="<?php echo e(URL::to('/dashboard')); ?>">
                <i class="fa fa-fw fa-dashboard"></i>
                <span class="nav-link-text">Dashboard</span>
              </a>
            </li>
            <?php $__currentLoopData = $menus; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $menu): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
            <?
            $subMenus=DB::table('sub_menu')->where('status',1)->where('fk_menu_id',$menu->id)->orderBy('serial_num','ASC')->get();
            $allUrl1 = App\Models\SubMenu::where('status',1)->where('fk_menu_id',$menu->id)->where('url','!=','#')->orderBy('serial_num','ASC')->pluck('url')->toArray();
            $allUrl2 = App\Models\SubSubMenu::where('fk_menu_id',$menu->id)->where('status',1)->where('url','!=','#')->orderBy('serial_num','ASC')->pluck('url')->toArray();
            $allUrl = array_merge($allUrl1,$allUrl2);
            ?>
            <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check($menu->slug)): ?>
            <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Inventory-Sales">
                <a class="nav-link nav-link-collapse <?php echo e((in_array($url,$allUrl)?'':'collapsed')); ?>" data-toggle="collapse" href="#<?php echo e($menu->slug); ?>" data-parent="#exampleAccordion">
                  <i class="fa fa-folder"></i>
                  <span class="nav-link-text"><?php echo e($menu->name); ?></span>
                </a>
                <ul class="sidenav-second-level collapse <?php echo e((in_array($url,$allUrl)?'in':'')); ?>" id="<?php echo e($menu->slug); ?>">
                <?php $__currentLoopData = $subMenus; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $subMenu): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                <? $subSubMenu=DB::table('sub_sub_menu')->where('status',1)->where('fk_sub_menu_id',$subMenu->id)->orderBy('serial_num','ASC')->get();
                    $allUrl = App\Models\SubSubMenu::where('fk_sub_menu_id',$subMenu->id)->where('status',1)->where('url','!=','#')->orderBy('serial_num','ASC')->pluck('url')->toArray();
                 ?>
                <?php if(count($subSubMenu)>0): ?>
                <li>
                    <a class="nav-link-collapse <?php echo e((in_array($url,$allUrl)?'':'collapsed')); ?>" data-toggle="collapse" href="#<?php echo e($subMenu->slug); ?>"><i class="fa fa-folder-o"></i> <?php echo e($subMenu->name); ?></a>
                    <ul class="sidenav-third-level collapse <?php echo e((in_array($url,$allUrl)?'in':'')); ?>" id="<?php echo e($subMenu->slug); ?>">
                        <?php $__currentLoopData = $subSubMenu; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $ssMenu): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                        <li><a class="<?php echo e(($url==$ssMenu->url)?'active':''); ?>" href='<?php echo e(URL::to("$ssMenu->url")); ?>'><?php echo e($ssMenu->name); ?></a></li>
                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                    </ul>
                </li>
                <?php else: ?>

                <?
                $permission = DB::table('permissions')->where('slug',$subMenu->slug)->first();
                ?>
                <?php if($permission!=null): ?>
                <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check($subMenu->slug)): ?>
                <li><a class="<?php echo e(($url==$subMenu->url)?'active':''); ?>" href='<?php echo e(URL::to("$subMenu->url")); ?>'><i class="fa fa-folder-o"></i><?php echo e($subMenu->name); ?></a></li>
                <?php endif; ?>
                <?php else: ?>
                <li><a class="<?php echo e(($url==$subMenu->url)?'active':''); ?>" href='<?php echo e(URL::to("$subMenu->url")); ?>'><i class="fa fa-folder-o"></i><?php echo e($subMenu->name); ?></a></li>
                <?php endif; ?>
                <?php endif; ?>
                <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>

                </ul>
            </li>
            <?php endif; ?>
            <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
            <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Logout">
              <a class="nav-link" href="<?php echo e(URL::to('logout')); ?>">
              <i class="fa fa-sign-out" aria-hidden="true"></i>
                <span class="nav-link-text">Logout</span>
              </a>
            </li>
            <!-- end sidebar minify button -->
      </ul>
      <ul class="navbar-nav sidenav-toggler navbar-blue">
        <li class="nav-item">
          <a class="nav-link text-center" id="sidenavToggler">
            <i class="fa fa-fw fa-angle-left"></i>
          </a>
        </li>
      </ul>