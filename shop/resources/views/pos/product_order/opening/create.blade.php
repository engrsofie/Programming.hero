@extends('layout.app')
	@section('content')
    <style type="text/css">

    </style>
	<!-- begin #content -->
	<div id="content" class="content">
		<div class="row">
		    <div class="col-md-12">
                <div class="panel panel-inverse">
                    <div class="panel-heading"> 
                        <div class="panel-heading-btn">
                                <a class="btn btn-info btn-xs" href="{{URL::to('/inventory-product-opening')}}">All Opening Item</a>
                                
                            </div>
                        <h4 class="panel-title">Opening Item</h4>
                    </div>
                    <div class="panel-body no-padding">
                        {!! Form::open(array('route' => 'inventory-product-opening.store','class'=>'form-horizontal author_form','method'=>'POST','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                            <div class="col-md-12">
                                <input type="hidden" name="created_by" value="{{ Auth::user()->id }}">
                                <!-- transition -->
                                <div class="view_center_folwchart">
                                <div class='row'>
                                    <div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
                                        <table class="table table-bordered table-hover" id="table_auto">
                                            <thead>
                                                <tr>
                                                    <th width="2%"><input id="check_all" class="formcontrol" type="checkbox"/></th>
                                                    <th width="20%">Product Name</th>
                                                    <th>Cost Per Unit</th>
                                                    <th>Sales Per Unit</th>
                                                    <th colspan="2" width="15%">Quantity</th>
                                                    <th width="18%">Total</th>
                                                    <th width="20%">Stock Position</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td><input class="case" type="checkbox"/></td>
                                                    
                                                    <td> 
                                                        <input type="text" data-type="product_name" id="itemName_1" class="form-control autocomplete_txt" autocomplete="off">
                                                        <input type="hidden" data-type="product_name" name="fk_product_id[]" id="itemId_1" class="form-control autocomplete_txt" autocomplete="off" placeholder="Cost per unit">
                                                    </td>

                                                    <td>
                                                        <input type="number" min="0" step="any" name="cost_per_unit[]" class="form-control changesNo" id="cost_1" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;">
                                                    </td>
                                                    <td>
                                                        <input type="number" min="0" step="any" name="sales_per_unit[]" class="form-control">
                                                    </td>
                                                    <td>
                                                        <input type="number" min="0" step="any" name="qty[]" id="quantity2_1" class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" placeholder="Quantity">
                                                    </td>
                                                    <td><span id="uom_1">Unit</span></td>
                                                    <td>
                                                        <input type="number" min="0" step="any" name="amount[]" id="total_1" class="form-control totalLinePrice" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;">
                                                    </td>
                                                    <td>
                                                    <div id="stockPosition">
                                                        
                                                        {{Form::select('fk_stock_position_id[]',$stockPosition,'1',['class'=>'form-control','placeholder'=>'Select Position','required'])}}
                                                    </div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class='row'>
                                    <div class='col-xs-12 col-sm-4 col-md-4 col-lg-4'>
                                        <button class="btn btn-danger delete" type="button">- Delete</button>
                                        <button class="btn btn-success addmore" type="button">+ Add More</button>
                                    </div>
                                </div>
                                <br>
                                <div class='row'>   
                                    <div class='col-xs-12 col-sm-7 col-md-7 col-lg-7'>
                                        <div class="form-group">
                                            <label class="col-md-3 control-label">Comments :</label>
                                              <div class="col-md-9">
                                                <textarea name="summary" rows="2" class="form-control " placeholder="Write something about order."></textarea>
                                              </div>
                                        </div>
                                        
                                    </div>
                                    <div class='col-xs-12 col-sm-5 col-md-5 col-lg-5'>
                                        <span class="form-inlines">
                                                <div class="form-group aside_system">
                                                    <label class="col-md-4">Total Amount :</label>
                                                    <div class="input-group col-md-8">
                                                        <div class="input-group-addon currency">৳</div>
                                                        <input value="" type="number" min="0" step="any" class="form-control" name="total_amount" id="subTotal" placeholder="Total Amount" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly>
                                                    </div>
                                                </div>
                                        </span>
                                    </div>
                                </div>

                            </div>
                            </div>

                            <div class="form-group col-md-12">
                                <label class="control-label col-md-2 col-sm-2"></label>
                                <div class="col-md-8 col-sm-8">
                                    <br>
                                    <button type="submit" class="btn btn-primary" style="width: 100%;">Confirm</button>
								</div>
                                <label class="control-label col-md-2 col-sm-2"></label>
							</div>
                        {!! Form::close(); !!}
                    </div>
                </div>
		    </div>
		</div>
	</div>
	<!-- end #content -->
@endsection
@section('script')
<script src="{{asset('public/custom_js/script_opening.js')}}"></script>
@endsection