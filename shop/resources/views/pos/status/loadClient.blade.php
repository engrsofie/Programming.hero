
{{Form::select('fk_client_id',$clients,'',['class'=>'form-control select','placeholder'=>'All Clients','id'=>'client'])}}
<script type="text/javascript">
    $('.select').chosen("liszt:updated");
</script>
