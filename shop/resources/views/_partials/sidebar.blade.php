 <?php $url=Request::path();
    $menus=DB::table('menu')->where('status',1)->orderBy('serial_num','ASC')->get();
    $allUrl=array();
 ?>
 <ul class="navbar-nav navbar-sidenav" id="exampleAccordion">

            <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Dashboard">
              <a class="nav-link" href="{{URL::to('/dashboard')}}">
                <i class="fa fa-fw fa-dashboard"></i>
                <span class="nav-link-text">Dashboard</span>
              </a>
            </li>
            @foreach($menus as $menu)
            <?php
            $subMenus=DB::table('sub_menu')->where('status',1)->where('fk_menu_id',$menu->id)->orderBy('serial_num','ASC')->get();
            $allUrl1 = App\Models\SubMenu::where('status',1)->where('fk_menu_id',$menu->id)->where('url','!=','#')->orderBy('serial_num','ASC')->pluck('url')->toArray();
            $allUrl2 = App\Models\SubSubMenu::where('fk_menu_id',$menu->id)->where('status',1)->where('url','!=','#')->orderBy('serial_num','ASC')->pluck('url')->toArray();
            $allUrl = array_merge($allUrl1,$allUrl2);
            ?>
            @can($menu->slug)
            <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Inventory-Sales">
                <a class="nav-link nav-link-collapse {{(in_array($url,$allUrl)?'':'collapsed')}}" data-toggle="collapse" href="#{{$menu->slug}}" data-parent="#exampleAccordion">
                  <i class="fa fa-folder"></i>
                  <span class="nav-link-text">{{$menu->name}}</span>
                </a>
                <ul class="sidenav-second-level collapse {{(in_array($url,$allUrl)?'in':'')}}" id="{{$menu->slug}}">
                @foreach($subMenus as $subMenu)
                <?php $subSubMenu=DB::table('sub_sub_menu')->where('status',1)->where('fk_sub_menu_id',$subMenu->id)->orderBy('serial_num','ASC')->get();
                    $allUrl = App\Models\SubSubMenu::where('fk_sub_menu_id',$subMenu->id)->where('status',1)->where('url','!=','#')->orderBy('serial_num','ASC')->pluck('url')->toArray();
                 ?>
                @if(count($subSubMenu)>0)
                <li>
                    <a class="nav-link-collapse {{(in_array($url,$allUrl)?'':'collapsed')}}" data-toggle="collapse" href="#{{$subMenu->slug}}"><i class="fa fa-folder-o"></i> {{$subMenu->name}}</a>
                    <ul class="sidenav-third-level collapse {{(in_array($url,$allUrl)?'in':'')}}" id="{{$subMenu->slug}}">
                        @foreach($subSubMenu as $ssMenu)
                        <li><a class="{{($url==$ssMenu->url)?'active':''}}" href='{{URL::to("$ssMenu->url")}}'>{{$ssMenu->name}}</a></li>
                        @endforeach
                    </ul>
                </li>
                @else

                <?php
                $permission = DB::table('permissions')->where('slug',$subMenu->slug)->first();
                ?>
                @if($permission!=null)
                @can($subMenu->slug)
                <li><a class="{{($url==$subMenu->url)?'active':''}}" href='{{URL::to("$subMenu->url")}}'><i class="fa fa-folder-o"></i>{{$subMenu->name}}</a></li>
                @endcan
                @else
                <li><a class="{{($url==$subMenu->url)?'active':''}}" href='{{URL::to("$subMenu->url")}}'><i class="fa fa-folder-o"></i>{{$subMenu->name}}</a></li>
                @endif
                @endif
                @endforeach

                </ul>
            </li>
            @endcan
            @endforeach
            <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Logout">
              <a class="nav-link" href="{{ URL::to('logout') }}">
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