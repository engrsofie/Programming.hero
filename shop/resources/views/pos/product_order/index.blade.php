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
                                <a class="btn btn-info btn-xs" href="{{URL::to('/inventory-product-order')}}">All Purchase Order</a>
                                
                            </div>
                        <h4 class="panel-title">Purchase Order</h4>
                    </div>
                    <div class="panel-body min-padding">
                        {!! Form::open(array('route' => 'inventory-product-order.store','class'=>'form-horizontal author_form','method'=>'POST','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                            <div class="col-md-12 no-padding">
                                <!-- info -->
                                <div class="row">
                                    <div class="form-group col-md-5">
                                        <label class="col-md-12">Company Name :</label>
                                        <div class="col-md-10">
                                            <select name="fk_supplier_id" data-placeholder="- Select Company Name-" class="form-control select" tabindex="10" required="required">
                                                <option value="">Select Company Name</option>
                                                @foreach($getSupplier as $supplier)
                                                    <option value="{{$supplier->id}}">{{$supplier->company_name}}</option>
                                                @endforeach
                                            </select>
                                        </div>
                                        <div class="col-md-2 no-padding">
                                        <!-- Button trigger modal -->
                                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
                                          <i class="fa fa-plus"></i>
                                        </button>
                                   
                                    </div>
                                    </div>
                                    
                                    <div class="form-group col-md-3">
                                        <label class="col-md-12" for="Date">Purchase Date :</label>
                                        <div class="col-md-12">
                                            <input class="form-control datepicker" type="text" name="order_date" value="<?php echo date('d-m-Y'); ?>" data-parsley-required="true" />
                                        </div>
                                    </div>
                                </div>
                                
                                <input type="hidden" name="created_by" value="{{ Auth::user()->id }}">
                                <!-- transition -->
                                <div class="view_center_folwchart">
                                <div class='row'>
                                    <div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
                                        <table class="table table-bordered table-hover" id="table_auto">
                                            <thead>
                                                <tr>
                                                    <th width="2%"><input id="check_all" class="formcontrol" type="checkbox"/></th>
                                                    <!-- th width="13%">Barcode</th> -->
                                                    <th width="20%">Product Name</th>
                                                    <th colspan="2">Cost Per Unit &amp; Currency</th>
                                                    <th width="10%">Currency Rates in BDT</th>
                                                    <th colspan="3" width="25%">Quantity</th>
                                                    <th width="20%">Total</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td><input class="case" type="checkbox"/></td>
                                                    <!-- <td><input type="text" data-type="barcode" name="barcode[]" id="itemNo_1" class="form-control autocomplete_txt" autocomplete="off"></td>-->
                                                    
                                                    <td> 
                                                    <input type="text" data-type="product_name" id="itemName_1" class="form-control autocomplete_txt" autocomplete="off">
                                                        <input type="hidden" data-type="product_name" name="fk_product_id[]" id="itemId_1" class="form-control autocomplete_txt" autocomplete="off" placeholder="Cost per unit">
                                                        
                                                    </td>
                                                    

                                                    <td>
                                                        <input type="number" min="0" step="any" name="foreign_amount[]" id="cost_1" class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" placeholder="Unit Price" > 
                                                    </td>
                                                    <td width="10%">
                                                        <input type="text" name="currency_name[]" placeholder="Currency" class="form-control">
                                                    </td>
                                                    
                                                    <td>
                                                        <input type="number" min="0" step="any" name="bdt_rates[]" class="form-control changesNo" id="rates_1" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;">
                                                    </td>
                                                    <td>
                                                        <input type="number" min="0" step="any" name="qty[]" id="quantity2_1" class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" placeholder="Quantity">
                                                        
                                                    </td>
                                                    <td>
                                                        <input type="number" min="0" step="any" name="free_of_cost[]" class="form-control" placeholder="Free">
                                                        
                                                    </td>
                                                    <td>
                                                    <span id="uom_1">Unit</span> 
                                                    </td>
                                                    <td>
                                                        <input type="number" min="0" step="any" name="amount[]" id="total_1" class="form-control totalLinePrice" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;">
                                                        
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
                                        <div class="form-group">
                                            <label class="col-md-3 control-label">Shipping Address :</label>
                                              <div class="col-md-9">
                                                <input type="" name="shipping_address" class="form-control " value="{{$companyInfo->shipping_address}}">
                                              </div>
                                        </div>
                                    </div>
                                    <div class='col-xs-12 col-sm-5 col-md-5 col-lg-5'>
                                        <span class="form-inlines">
                                                
                                                <div class="form-group aside_system">
                                                    <label class="col-md-4">Total Amount :</label>
                                                    <div class="input-group col-md-8">
                                                        <div class="input-group-addon currency">৳</div>
                                                        <input value="" type="number" min="0" step="any" class="form-control" name="total_amount" id="totalWithExpenses" placeholder="Total Amount" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly>
                                                    </div>
                                                </div>
                                                <div class="form-group aside_system">
                                                <label class="col-md-4">Paid Amount :</label>
                                                <div class="input-group col-md-8">
                                                    <div class="input-group-addon currency">৳</div>
                                                    <input value="" type="number" min="0" step="any" class="form-control" name="total_paid" id="amountPaid" placeholder="Paid Amount" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;">
                                                </div>
                                            </div>
                                            
                                            <div class="form-group aside_system">
                                                <label class="col-md-4">Amount Due :</label>
                                                <div class="input-group col-md-8">
                                                    <div class="input-group-addon currency">৳</div>
                                                    <input value="" type="number" min="0" step="any" class="form-control amountDue" name="total"  id="amountDue" placeholder="Amount Due" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" readonly >
                                                </div>
                                            </div>
                                            <div class="form-group aside_system">
                                                <label class=" col-md-4">Account :</label>
                                                <div class="input-group col-md-8">
                                                   {{form::select('fk_account_id',$account,1,['class'=>'form-control','placeholder'=>'Select Account','required'])}}
                                                </div>
                                            </div>
                                            <div class="form-group aside_system">
                                                <label class=" col-md-4">Method :</label>
                                                <div class="input-group col-md-8">
                                                   {{form::select('fk_method_id',$method,3,['class'=>'form-control','placeholder'=>'Select Method','required'])}}
                                                </div>
                                            </div>
                                            <div class="form-group aside_system">
                                                <label class="col-md-4" for="Date">Ref ID</label>
                                                <div class="input-group col-md-8">
                                                    <input class="form-control" type="text" name="ref_id" placeholder="Ref ID" />
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
    <!-- Modal -->
                                    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                                      <div class="modal-dialog modal-lg" role="document">
                                        <div class="modal-content">
                                          <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                            <h4 class="modal-title" id="myModalLabel">Add new Supplier</h4>
                                          </div>
                                          {!! Form::open(array('route' => 'inventory-supplier.store','class'=>'form-horizontal author_form','method'=>'POST','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                                          <div class="modal-body">
                                            
                                                <div class="form-group">
                                                    <label class="control-label col-md-4 col-sm-4" for="company_name">Company Nmae :</label>
                                                    <div class="col-md-6 col-sm-6">
                                                        <input class="form-control" type="text" id="company_name" name="company_name" placeholder="Company Name" data-parsley-required="true" required />
                                                    </div>
                                                </div>
                                                
                                                <div class="form-group">
                                                    <label class="control-label col-md-4 col-sm-4" for="sub_category_name">Representative Name * :</label>
                                                    <div class="col-md-6 col-sm-6">
                                                        <input class="form-control" type="text" id="sub_category_name" name="representative" placeholder="Representative Name"  />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-4 col-sm-4" for="sub_category_name"> Email :</label>
                                                    <div class="col-md-6 col-sm-6">
                                                        <input class="form-control" type="text" id="email" name="email_id" data-parsley-type="email" placeholder="Email" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-4 col-sm-4" for="sub_category_name"> Address  :</label>
                                                    <div class="col-md-6 col-sm-6">
                                                        <textarea class="form-control" id="address" name="address" rows="4"  placeholder="Address"></textarea>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-4 col-sm-4" for="sub_category_name">Moblie No.  :</label>
                                                    <div class="col-md-6 col-sm-6">
                                                        <input class="form-control" type="number" min="0" id="number" name="mobile_no" data-parsley-type="number" placeholder="Mobile Number" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-4 col-sm-4">Status :</label>
                                                    <div class="col-md-1 col-sm-1">
                                                        <div class="radio">
                                                            <label>
                                                                <input type="radio" name="status" value="1" id="radio-required" data-parsley-required="true" checked /> Active
                                                            </label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4 col-sm-4">
                                                        <div class="radio">
                                                            <label>
                                                                <input type="radio" name="status" id="radio-required2" value="0" /> Inactive
                                                            </label>
                                                        </div>
                                                    </div> 
                                                </div>
                                          </div>
                                          <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                            <button type="submit" class="btn btn-primary">Save</button>
                                          </div>
                                            {!! Form::close(); !!}
                                        </div>
                                      </div>
                                    </div>
                                    <!-- /Modal -->
	
<script src="{{asset('public/plugins/jquery/jquery-1.9.1.min.js')}}"></script>
<script src="{{asset('public/custom_js/script_order.js')}}"></script>
   

 <script type="text/javascript">
       
         
        i=2;
        function appendList(){
            var html = '<div class="form-group" id="list'+i+'"><div class="col-md-1"> <button type="button" onclick="deleteAppend('+i+')" class="btn btn-danger btn-sm"><i class="fa fa-trash"></i></button> </div>';
            html += $('#appendList').html();
            html += '</div>';
            $('#other_expenses').append(html);
            i++;
        }
        function deleteAppend(id){
            $('#list'+id).remove();
        }
    </script>

@endsection
