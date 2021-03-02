@extends('layout.app')
	@section('content')
    <style type="text/css">
        .modal-dialog{width: 900px;}
        .invoice-note {margin-top: 35px;}
        .refId {display: none;}
        .customerInfo p{margin-bottom: 2px;}
        .customerInfo, .invoiceInfo{float: left;padding: 0 10px;}
    </style>
		<!-- begin #content -->
		<div id="content" class="content">
			
			<!-- begin invoice -->
			<div class="invoice">
                <div class="invoice-company">
                    <span class="pull-right hidden-print">
                    <a href="ui_modal_notification.html#modal-dialog" class="btn btn-sm btn-info m-b-10" data-toggle="modal"><i class="fa fa-envelope" aria-hidden="true"></i> Email</a>
                    <?
                        $url1=Request::path();
                        $url1=explode('/',$url1);
                        $url1=$url1[0];


                        ?>
                    @if($url1=='deposit'))
                        <?php 
                            $url = "deposit_send_mail/$getInvoiceData->id"; 
                            $public_url = "deposit-public-invoice/$getInvoiceData->id"; 
                        ?>
                    @else
                        <?php 
                            $url = "payment_send_mail/$getInvoiceData->id"; 
                            $public_url = "payment-public-invoice/$getInvoiceData->id"; 
                        ?>
                    @endif
                    <!-- #modal-dialog -->
                    <div class="modal fade" id="modal-dialog">
                        <div class="modal-dialog">
                            <div class="modal-content">
                            {!! Form::open(array('url' => "$url",'class'=>'form-horizontal author_form','method'=>'POST','files'=>'true', 'id'=>'commentForm','role'=>'form','data-parsley-validate novalidate')) !!}
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                    <h4 class="modal-title">#{{$getInvoiceData->invoice_no}}</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label class="control-label col-md-4 col-sm-4" for="to">To * :</label>
                                        <div class="col-md-8 col-sm-8">
                                            <input class="form-control" type="text"  name="to" value="{{$getInvoiceData->email_id}}" data-parsley-required="true" />
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
                                            <textarea name="body" class="textarea form-control" rows="5"><h1>Greetings,</h1><p>This email serves as your official invoice from {{$companyInfo->company_name}}</p><p>Invoice URL: <a href='{{URL::to("$public_url")}}' target="_blank">{{URL::to("$public_url")}}</a></p><p>Invoice ID: INV{{$getInvoiceData->id}}</p><p>Total Amount: <?php echo $totalAmount->total_amount; ?> Tk.</p><p>Total Paid: {{$totalPaid->total_paid}} Tk.</p><p>Total Due: <?php echo intval($totalAmount->total_amount)-intval($totalPaid->total_paid);?> Tk.</p><?php echo $emailConfig->message_body; ?></textarea>
                                            
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-md-4 col-sm-4" for="subject">Message Body * :</label>
                                        <div class="col-md-8 col-sm-8">
                                            <div class="checkbox c-checkbox">
                                              <label>
                                                <input type="checkbox" name="attach_pdf" value="1" checked=""></span>  <i class="fa fa-paperclip"></i> INV{{$getInvoiceData->id}}.pdf
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
                    @if(URL::to("deposit/$getInvoiceData->id")== url()->current())
                        <a href='{{URL::to("/deposit-generate-pdf/$getInvoiceData->id")}}' target="_blank" id="pdf-generate" class="btn btn-sm btn-success m-b-10"><i class="fa fa-download m-r-5"></i> Export as PDF</a>
                        <a href='{{URL::to("deposit/$getInvoiceData->id/edit")}}' class="btn btn-sm btn-danger m-b-10"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> Edit</a>
                    @else
                        <a href='{{URL::to("/payment-generate-pdf/$getInvoiceData->id")}}' target="_blank" id="pdf-generate" class="btn btn-sm btn-success m-b-10"><i class="fa fa-download m-r-5"></i> Export as PDF</a>
                        <a href='{{URL::to("payment/$getInvoiceData->id/edit")}}' class="btn btn-sm btn-danger m-b-10"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> Edit</a>
                    @endif
                    </span>
                    
                    <!-- Invoice No. : {{$getInvoiceData->invoice_no}} --> 
                </div>
                <input type="hidden" id="generate-id" value="{{$getInvoiceData->id}}">
                <input type="hidden" name="_token" value="{{ csrf_token() }}">
                <div class="company_header">
                    @include('common.invoiceHeader')
                </div>
               <div id="customer_info">
                    <div class="row">
                        <div class="customerInfo" style="width: 60%">
                            <p><b><u>Invoiced to</u></b></p>
                            <p><b>Name : </b>{{$getInvoiceData->client_name}}</p>
                            <p><b>Address : </b> {{$getInvoiceData->address}}</p>
                            <p><b>Mobile No :</b> {{$getInvoiceData->mobile_no}}</p>
                            <p><b>Email : </b> {{$getInvoiceData->email_id}}</p>
                            <p><b></b> </p>
                        </div>
                        <div class="invoiceInfo" style="width: 40%">
                            <table class="table table-bordered">
                                <tr>
                                
                                    <th>Invoice #:</th>
                                    <th>{{$singleHistory->invoice_id}} 
                                @if($singleHistory->invoice_id!=$getInvoiceData->invoice_no)
                                    <small>(Ref. Invoice: <a target="_blank" class="reflink" href='{{URL::to("$url1/$getInvoiceData->invoice_no")}}'>{{$getInvoiceData->invoice_no}}</a><span class="refId">{{$getInvoiceData->invoice_no}}</span>)</small>
                                @endif
                                </th>
                                </tr>
                                 <tr>
                                    <td>Invoice Date : </td>
                                    <td>{{$singleHistory->payment_date}}</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="invoice-content">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                                <tr class="active">
                                    <th>Sector </th>
                                    <th>Description</th>
                                    <th>Total</th>
                                    <th>Paid</th>
                                    <th>Due</th>
                                </tr>
                            </thead>
                            <tbody>
                            <?
                            $last_due=0;
                            $paid=0;
                            $totalDue=0;
                            ?>
                            @foreach($allTask as $task)
                                <tr>
                                    <td>
                                        {{$task->sub_category_name}}<br />
                                        
                                    </td>
                                    <td><small>{{$task->description}}</small></td>
                                    <td>{{$task->last_due}}
                                    </td>
                                    <td>{{$task->paid}}</td>
                                    <td>{{$task->last_due-$task->paid}}</td>
                                    <? 
                                        $due=$task->last_due-$task->paid;
                                        $totalDue+=$due;
                                        $last_due+= $task->last_due;
                                        $paid+= $task->paid;

                                    ?>
                                </tr>
                            @endforeach 
                                <tr class="info">
                                    <th>*</th>
                                    <th style="text-align: right;">Total = </th>
                                    <th>{{$last_due}}</th>
                                    <th>{{$paid}}</th>
                                    <th>{{$totalDue}}</th>
                                </tr>
                                
                            </tbody>
                        </table>
                    </div>
                    <div class="invoice-calculate" style="width: 40%;float: right;">
                        <table class="table table-bordered">
                    
                        <tr>
                            <th>Total Amount</th>
                            <th>{{$last_due}}</th>
                        </tr>
                        <tr>
                            <th>Total Paid Amount</th>
                            <th>{{$paid}}</th>
                        </tr>
                        <tr>
                            <th>Total Due</th>
                            <th>{{$totalDue}}</th>
                        </tr>

                            
                        </table>
                    </div>
                    <script type="text/javascript" src="{{asset('public/js/inWords.js')}}"></script>

                    <h6 style="text-transform: capitalize;">Paid : 
                    <b><script>
                                    document.write(inWords(<?php if(isset($paid)){ echo intVal($paid);}?>));
                                </script></b></h6>
                <div class="invoice-note-details">
                    <p>NB: This is system  generated Invoice.</p>
                </div>
                </div>
                
                <div class="companyFooter">
                    @include('common.invoiceFooter')
                </div>
                
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
    <script type="text/javascript">

        // $("#pdf-generate").click(function(){
        //     var id = $("#generate-id").val();
        //     var _token = $('input[name="_token"]').val();
        //     //alert(id);
        //    $.ajax({
        //         url: "{{URL::to('/')}}"+'/generate-pdf',
        //         type: "POST",
        //         data: { _token : _token,
        //             generate_id:  id,
        //             },
        //         success: function(response){
        //             console.log(response);
        //             $("#show-preview-team").show();
                        
        //         }
        //     });

        // });
</script>
@endsection