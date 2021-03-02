
<select name="fk_permission_id[]" data-placeholder="Type to view" style="width:350px;" multiple class="chosen-select-no-results" tabindex="11">
  <option value=""></option>
  

<?php

foreach($getPermissionData as $permissionData){

$flag=0;
$counter=0;
foreach($roleWisePermissions as $p){
  ++$counter;

  if($permissionData->id == $p->fk_permission_id){
    ?>
    <option class="uncheck" value="<?php echo $permissionData->id; ?>"selected> <?php echo $permissionData->permission_name; ?></option>
    
  <?php
    $flag=0;
    break;
    
  }else{
    $flag++;
    continue;
  }
}
if($flag>0 || $counter==0 ){
  ?>
  <option value="<?php echo $permissionData->id; ?>"><?php echo $permissionData->permission_name; ?></option>
  
  <?php
}

}

?>
</select>
<div id="loadDelete"></div>
<!-- adds type away permission -->
    <script src="{{asset('public/plugins/jquery/jquery-1.9.1.min.js')}}"></script>  
    <script src="{{ asset('public/js/chosen.jquery.js') }}" type="text/javascript"></script> 


      <!-- article type condition -->
      <script type="text/javascript">
        /*chosen select option start*/
         $(".chosen-select-no-results").chosen({width:"100%"}); 
      </script>
      <script type="text/javascript">
        function roleWisePermission(value){
          //alert(value);
          $("#roleWisePermission").load("{{ URL::to('role-wise-permission')}}"+'/'+value);
          if(value === -1){
            $("#roleWisePermission").hide();
          }
          //alert(value);
        }
      </script>
      <script type="text/javascript">


       $('.search-choice-close').click(function() {
        var exist_val = $(this).attr('data-option-array-index');
        //alert(exist_val);
        $('<input name="permission[]" type="hidden" />').appendTo('#loadDelete').val(exist_val);

        });

      </script>
      <script type="text/javascript">
      $(document).ready(function() {
          App.init();
          DashboardV2.init();
          //
      });
    </script>
      
