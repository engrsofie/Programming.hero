@if($i==1)
{{Form::select('transfer_from',$accounts,'',['class'=>'form-control account','id'=>'accountOne','placeholder'=>'Select Account','required'])}}
@else
{{Form::select('transfer_to',$accounts,'',['class'=>'form-control account','id'=>'accountTwo','placeholder'=>'Select Account','required'])}}
@endif
<script src="{{asset('public/plugins/jquery/jquery-1.9.1.min.js')}}"></script>        
    <script type="text/javascript">
        $('#accountOne').on('change',function(){
            var id =$(this).val();
            $.ajax({
                url: "{{URL::to('account-money-transfer')}}/"+id,
                type: "GET",
                data:'',
                success: function(response){
                $('#amount').attr('max',response);
                $('#balanceOne').val(response);
                        
                }
            });
        });
        $('#accountTwo').on('change',function(){
            var id =$(this).val();
            $.ajax({
                url: "{{URL::to('account-money-transfer')}}/"+id,
                type: "GET",
                data:'',
                success: function(response){
                $('#balanceTwo').val(response);
                        
                }
            });
        });
    </script>