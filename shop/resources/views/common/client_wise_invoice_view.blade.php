@extends('layout.app')
	@section('content')
    <style type="text/css">
        .modal-dialog{width: 900px;}
    </style>
		<!-- begin #content -->
		<div id="content" class="content">
			
			<!-- begin invoice -->
			<div class="invoice">
                <div class="invoice-company">
                    <span class="pull-right hidden-print">
                    <a href="ui_modal_notification.html#modal-dialog" class="btn btn-sm btn-info m-b-10" data-toggle="modal"><i class="fa fa-envelope" aria-hidden="true"></i> Email</a>
                    @if(URL::to("client-wise-due-deposit/$id")== url()->current())
                        <?php 
                            $url = "client_wise_deposit_send_mail/$id"; 
                            $public_url = "deposit-public-invoice-client-wise/$id"; 
                        ?>
                    @else
                        <?php 
                            $url = "client_wise_payment_send_mail/$id"; 
                            $public_url = "payment-public-invoice-client-wise/$id";
                        ?>
                    @endif
                    <!-- #modal-dialog -->
                    <div class="modal fade" id="modal-dialog">
                        <div class="modal-dialog">
                            <div class="modal-content">
                            {!! Form::open(array('url' => "$url",'class'=>'form-horizontal author_form','method'=>'POST','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                    
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label class="control-label col-md-4 col-sm-4" for="to">To * :</label>
                                        <div class="col-md-8 col-sm-8">
                                            <input class="form-control" type="text"  name="to" value="{{$getClientData->email_id}}" data-parsley-required="true" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-md-4 col-sm-4" for="cc">Cc * :</label>
                                        <div class="col-md-8 col-sm-8">
                                            <input class="form-control" type="text"  name="cc" value="" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-md-4 col-sm-4" for="from">From * :</label>
                                        <div class="col-md-8 col-sm-8">
                                            <input class="form-control" type="text" name="from" value="<?php echo $emailConfig->default_email; ?>" data-parsley-required="true" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-md-4 col-sm-4" for="subject">subject * :</label>
                                        <div class="col-md-8 col-sm-8">
                                            <input class="form-control" type="text"  name="subject" value="" data-parsley-required="true" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-md-4 col-sm-4" for="subject">Message Body * :</label>
                                        <div class="col-md-8 col-sm-8">
                                            <textarea name="body" class="textarea form-control" id="wysihtml5" rows="5"><h1>Greetings,</h1><p>This email serves as your official invoice from {{$companyInfo->company_name}}</p><p>Invoice URL: <a href='{{URL::to("$public_url")}}' target="_blank">{{URL::to("$public_url")}}</a></p><p>Invoice ID: INV_CLIENT{{$id}}</p><p>Total Amount: <?php echo $totalAmount->total_amount; ?> Tk.</p><p>Total Paid: {{$totalPaid->total_paid}} Tk.</p><p>Total Due: <?php echo intval($totalAmount->total_amount)-intval($totalPaid->total_paid);?> Tk.</p><?php echo $emailConfig->message_body; ?></textarea>
                                            
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-md-4 col-sm-4" for="subject">Message Body * :</label>
                                        <div class="col-md-8 col-sm-8">
                                            <div class="checkbox c-checkbox">
                                              <label>
                                                <input type="checkbox" name="attach_pdf" value="1" checked=""></span>  <i class="fa fa-paperclip"></i> INV_CLIENT{{$id}}.pdf
                                              </label>
                                                
                                            </div>
                                        </div>
                                    </div>
                                     
                                </div>
                                <div class="modal-footer">
                                    <a href="javascript:;" class="btn btn-sm btn-white" data-dismiss="modal">Close</a>
                                    <button type="submit" class="btn btn-sm btn-success">Update</button>
                                </div>
                            {!! Form::close(); !!}
                            </div>
                        </div>
                    </div>
                    
                    <a href="javascript:;" onclick="window.print()" class="btn btn-sm btn-success m-b-10"><i class="fa fa-print m-r-5"></i> Print</a>
                    
                    </span>
                    <!-- <div class="view_logo">
                        <img src='{{asset("images/company/logo/$companyInfo->company_logo")}}' style="width: 12%;">
                    </div> <br> -->
                    
                </div>
                <input type="hidden" id="generate-id" value="{{$id}}">
                <input type="hidden" name="_token" value="{{ csrf_token() }}">
                <div class="invoice_top" style="width: 100%; overflow: hidden;">
                    <div class="view_logo" style="width: 18%; float: left;">
                        <img src='{{asset("images/company/logo/$companyInfo->company_logo")}}' style="width: 100%; height: auto;">
                    </div>
                    <div class="view_company_info" style="width: 33%; float: right; margin-left: 0%;">
                        <strong>{{$companyInfo->company_name}}</strong><br />
                        <?php echo $companyInfo->company_address; ?><br />
                        Phone: {{$companyInfo->company_phone}}<br />
                        E-mail: {{$companyInfo->company_email}}
                    </div>
                </div>
                <div class="invoice-header" style="width: 100%; overflow: hidden;">
                    <div class="client_info" style="width: 70%; float: left;">
                        <div class="list">
                            Client Name :
                            <label> {{$getClientData->client_name}}</label>
                        </div>
                        <div class="list">
                            Client Address :
                            <label> {{$getClientData->address}}</label>
                        </div>
                        <div class="list">
                            Client Phone :
                            <label> {{$getClientData->mobile_no}}</label>
                        </div>
                        <div class="list">
                            Client Email :
                            <label> {{$getClientData->email_id}}</label>
                        </div>
                    </div>
                    <div class="client_invoice_id" style="width: 30%; float: right;">
                       <!-- <div class="list">
                            Invoice Id :
                            <label># {{$getClientData->invoice_no}}</label>
                        </div>
                        <div class="list">
                            Data :
                            <label> {{$getClientData->t_date}}</label>
                        </div> --> 
                    </div>
                </div>
                
                <div class="invoice-content">
                    <div class="table-responsive">
                        <table class="table table-invoice">
                            <thead>
                                <tr>
                                    <th width="65%">TASK DESCRIPTION</th>
                                    <th>Total</th>
                                    <th>Paid</th>
                                    <th>Due</th>
                                </tr>
                            </thead>
                            <tbody>
                            @foreach($getInvoiceData as $invoiceItemData)
                                <tr>
                                    <td>
                                        {{$invoiceItemData->sub_category_name}}<br />
                                        <small>{{$invoiceItemData->description}}</small>
                                    </td>
                                    <td>{{$invoiceItemData->total_amount}}</td>
                                    <td>{{$invoiceItemData->paid_amount}}</td>
                                    <td>{{$invoiceItemData->total_amount-$invoiceItemData->paid_amount}}</td>
                                </tr>
                            @endforeach 
                                
                            </tbody>
                        </table>
                    </div>
                    <div class="invoice-price">
                        <div class="invoice-price-left">
                            <div class="invoice-price-row">
                                <div class="sub-price">
                                    <small>Total Amount</small>
                                   Tk. <?php echo $totalAmount->total_amount; ?>
                                </div>
                                <div class="sub-price">
                                    
                                    <i class="fa fa-minus" aria-hidden="true"></i>
                                </div>
                                <div class="sub-price">
                                    <small>Total Paid Amount</small>
                                    Tk. {{$totalPaid->total_paid}}
                                </div>
                            </div>
                        </div>
                        <div class="invoice-price-right">
                            <small>TOTAL Due</small>Tk. <?php echo intval($totalAmount->total_amount)-intval($totalPaid->total_paid);?>
                        </div>
                    </div>
                    <script type="text/javascript" src="{{asset('public/js/inWords.js')}}"></script>
                        <h3 style="text-transform: capitalize;">Taka : <b><script>
                                    document.write(inWords(<?php if(isset($totalAmount->total_amount)){ echo $totalAmount->total_amount;}?>));
                                </script></b></h3>
                </div>
                <div class="sign" style="width: 100%; overflow: hidden;">
                    <div class="company_sign" style="width: 50%; float: left;">
                        <h5>Received By:</h5>
                        <div style="width: 200px; height: 2px; margin-top: 30px; border-bottom: 1px solid #000;"></div>
                        <div class="bottom_company_sign" style="text-transform: capitalize;">
                            <h5>{{$companyInfo->company_name}}</h5>
                            <h5>{{$companyInfo->company_phone}}</h5>
                        </div>  
                    </div>   
                    <div class="customer_sign" style="width: 33%;float: right;">
                        <h5>Customer Sine:</h5>
                        <div style="width: 200px; height: 2px; margin-top: 30px; border-bottom: 1px solid #000;"></div>
                        <p style="color: #e6e6e6;">(Hear Customer name)</p>
                    </div>   
                </div>
                <div class="invoice-note-details">
                    <?php echo $condition->details; ?>
                </div>
                <div class="invoice-footer text-muted">
                    <p class="text-center m-b-5">
                        THANK YOU
                    </p>
                    <p class="text-center">
                        <span class="m-r-10"><i class="fa fa-globe"></i> {{$companyInfo->web_address}}</span>
                        <span class="m-r-10"><i class="fa fa-phone"></i>{{$companyInfo->company_phone}}</span>
                        <span class="m-r-10"><i class="fa fa-envelope"></i> {{$companyInfo->company_email}}</span>
                    </p>
                </div>
                <hr>
                <div class="copyright">
                    <div class="copyright-section">
                        <p class="pull-left">© 2017 {{$companyInfo->company_name}} All Right Reserved. </p>
                        
                        <p class="design_band pull-right">Powered By: <a href="#" > Smart Software Inc.</a></p>
                    </div>
                </div>
                <br>
            </div>
			<!-- end invoice -->
		</div>
		<!-- end #content -->
		
    <script src="{{asset('public/plugins/jquery/jquery-1.9.1.min.js')}}"></script>
    <script>
		$(document).ready(function() {
			App.init();
		});
	</script>
  
@endsection