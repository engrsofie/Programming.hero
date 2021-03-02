<div class="col-md-12">
	
 <table class="table table-bordered">
    <tr>
        <td><b>Mobile : </b> <? echo $client->mobile_no ?></td>
        <td><b>Company : </b> <? echo $client->company_name ?></td>
        <td><b>Address : </b> <? echo $client->address ?></td>
        <td><b>Email : </b> <? echo $client->email_id ?></td>
    </tr>
</table>
<div class="form-group">
    <label class="col-md-3 control-label">Shipping Address :</label>
    <div class="col-md-8">
    	 @if($client->shipping_address1!=null or $client->shipping_address2!=null or $client->address!=null)
        <select class="form-control" name="shipping_address">
        @if($client->shipping_address1!=null)
            <option value="{{$client->shipping_address1}}" selected>{{$client->shipping_address1}}</option>
        @endif
        @if($client->shipping_address2!=null)
            <option value="{{$client->shipping_address2}}">{{$client->shipping_address2}}</option>
        @endif
        @if($client->address!=null)
            <option value="{{$client->address}}">{{$client->address}}</option>
        @endif

        </select>
        @else
        <input type="text" class="form-control" name="shipping_address" placeholder="Shipping Address">
        @endif
    </div>
</div>
</div>
