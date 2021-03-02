@include('_partials.header')
  <div class="content-wrapper">
    <div class="container-fluid">
		<!-- Breadcrumbs-->
	      
		@yield('content')
	 </div>
  </div>
@include('_partials.footer')
@yield('script')
</body>
</html>