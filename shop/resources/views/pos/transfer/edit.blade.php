@extends('layout.app')
@section('content')
<div id="content" class="content">
	<div class="row">
	    <div class="col-md-12">
            <div class="panel panel-inverse">
                <div class="panel-heading"> 
                    <div class="panel-heading-btn">
                            <a class="btn btn-info btn-xs" href="{{URL::to('/barcode')}}">View All</a>
                            
                        </div>
                    <h4 class="panel-title">Product Transfer</h4>
                </div>
                <div class="panel-body">
                	 {!! Form::open(array('route' =>['inventory-transfer.update',$data->id],'class'=>'form-horizontal author_form','method'=>'PUT','role'=>'form','data-parsley-validate novalidate')) !!}
                     <div class="col-md-12 no-padding">
                         <div class="form-group col-md-4">
                             <label class="col-md-12">Transfer From :</label>
                             <div class="col-md-12">
                                <span class="form-control">{{$data->branch_one}}</span>
                             </div>
                         </div>
                         <div class="form-group col-md-4">
                             <label class="col-md-12">Transfer To :</label>
                             <div class="col-md-12">
                                <span class="form-control">{{$data->branch_two}}</span>
                             </div>
                         </div>
                         <div class="form-group col-md-4">
                             <label class="col-md-12">Date :</label>
                             <div class="col-md-12">
                                 <input type="text" name="date" placeholder="Date" class="form-control datepicker" value="{{date('d-m-Y',strtotime($data->date))}}">
                             </div>
                             
                         </div>
                     </div>
                    <table class="table table-bordered table-hover" id="table_auto">
                        <thead>
                            <tr>
                                <th width="1%"></th>
                                <th width="20%"> Product Name </th>
                                <th width="10%"> Qty </th>
                                <th width="15%"> Cost Per Unit </th>
                                <th width="12%"> Sub Total </th>
                            </tr>
                        </thead>
                        <tbody>
                            <? $i=0; ?>
                        @foreach($items as $item)
                            <? $i++; ?>
                            <tr>
                                <td>{{$i}}</td>
                                <td>{{$item->product_name}} ({{$item->model_name}})
                                    <input type="hidden" name="item_id[]" value="{{$item->id}}">
                                </td>
   
                                <td><input type="number" min="0" name="qty[]" step="any" id="qty_{{$i}}" class="form-control changesNo" autocomplete="off" required onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" value="{{$item->qty}}" placeholder="Qty"></td>
                                <td><input type="number" min="0" name="cost_per_unit[]" step="any" id="cost_{{$i}}" class="form-control changesNo" autocomplete="off" value="{{$item->cost_per_unit}}" required onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" placeholder="Cost Per Unit"></td>
                                <td>
                                    <input type="number" name="sub_total[]" step="any" readonly id="subTotal_{{$i}}" value="{{$item->qty*$item->cost_per_unit}}" tabindex="-1" class="form-control subTotal" >
                                </td>

                            </tr>
                        @endforeach
                        </tbody>
                    </table> 
                    <div class='row'>
                        <div class='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
                            <button class="btn btn-success addmore" type="button">+ Add More</button>
                            <button class="btn btn-danger delete" type="button">- Delete</button>
                        </div>
                    </div><br> 
                     <div class='row'>   
                        <div class='col-xs-12 col-sm-7 col-md-7 col-lg-7'>
                            <div class="form-group">
                                <label class="col-md-3 control-label">Comments :</label>
                                  <div class="col-md-9">
                                    <textarea tabindex="-1" name="details" rows="2" class="form-control" placeholder="Write something about transfer."></textarea>
                                  </div>
                            </div>
                            <div>
                          </div>
                            
                        </div>
                        <div class='col-xs-12 col-sm-5 col-md-5 col-lg-5'>
                            <span class="form-inlines">
                                    <div class="form-group aside_system">
                                        <label class="col-md-4">Total Amount :</label>
                                        <div class="input-group col-md-8">
                                            <div class="input-group-addon currency">৳</div>
                                            <input tabindex="-1" value="{{$data->total_amount}}" type="number" min="0" step="any" class="form-control" name="total_amount" id="total" placeholder="Sub Total" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly>
                                        </div>
                                    </div>
                                
                            </span>
                        </div>
                    </div>
                    <div class="form-group">
						<label class="control-label col-md-2 col-sm-2"></label>
						<div class="col-md-8 col-sm-8">
                        
							<button type="submit" class="btn btn-primary" style="width: 100%;">Confirm</button>
						</div>
                        <label class="control-label col-md-2 col-sm-2"></label>
					</div>
                    {!! Form::close(); !!}     
					<br>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
@section('script')
<script src="{{asset('public/custom_js/transfer.js')}}"></script>
@stop