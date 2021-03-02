@include('_partials.public_view_header')
    <style type="text/css">
        .content {width: 95%; text-transform: capitalize; margin: 0 auto;}
        .invoice-note{margin: 10px 0;}
        .col-md-4{width: 33.33333333%;float: left;position: relative; min-height: 1px; padding-right: 15px; padding-left: 15px;}
        .col-md-5{width: 41.66666667%; float: left; position: relative; min-height: 1px; padding-right: 15px; padding-left: 15px;}
        .col-md-2{width: 16.66666667%;float: left; position: relative; min-height: 1px; padding-right: 15px; padding-left: 15px;}
        .text-center {text-align: center;}
    </style>
        <!-- begin #content -->
        <div id="content" class="content">
            <!-- begin breadcrumb -->

            <!-- end page-header -->
            
            <!-- begin invoice -->
            <div class="invoice">
                <!--  -->
                <div class="invoice_top invoice-company" style="width: 100%; height:90px;">
                    <div class="view_logo" style="width: 18%; float: left; height:90px;">
                        <img src='{{asset("images/company/logo/$companyInfo->company_logo")}}' style="width: 100%; height: 100%;">
                    </div>
                    <div class="view_company_info" style="width: 33%; float: right; margin-left: 0%;">
                        <strong>{{$companyInfo->company_name}}</strong><br />
                        <?php echo $companyInfo->company_address; ?><br />
                        Phone: {{$companyInfo->company_phone}}<br />
                        E-mail: {{$companyInfo->company_email}}
                    </div>
                </div>
                <h3 style="text-align: center;">Invoice</h3>
                <hr>
                <div class="invoice-header" style="width: 100%; height: 130px;">
                    <div class="client_info" style="width: 64%; float: left;">
                        <div class="list">
                            <label>Client Name : </label>
                            <label> {{$data['getInvoiceData']->client_name}}</label>
                        </div>
                        <div class="list">
                            <label> Client Address :</label>
                            <label> {{$data['getInvoiceData']->address}}</label>
                        </div>
                        <div class="list">
                            <label> Client Phone :</label>
                            <label> {{$data['getInvoiceData']->mobile_no}}</label>
                        </div>
                        <div class="list">
                            <label> Client Email :</label>
                            <label> {{$data['getInvoiceData']->email_id}}</label>
                        </div>
                    </div>
                    <div class="client_invoice_id" style="width: 36%; float: right;">
                       <div class="list">
                            <label>Invoice Id :</label>
                            <label># {{$data['getInvoiceData']->invoice_no}}</label>
                        </div>
                        <div class="list">
                            <label> Data :</label>
                            <label> {{$data['getInvoiceData']->t_date}}</label>
                        </div> 
                    </div>
                </div>
                
                <div class="invoice-content">
                    <div class="table-responsive">
                        <table class="table table-invoice table-bordered">
                            <thead>
                                <tr>
                                    <th width="65%">TASK DESCRIPTION</th>
                                    <th>Total</th>
                                    <th>Paid</th>
                                    <th>Due</th>
                                </tr>
                            </thead>
                            <tbody>
                            @foreach($data['getInvoiceItemData'] as $invoiceItemData)
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
                        <div class="row">
                            <div class="col-md-8">
                                <div class="invoice-price-left">
                                    <div class="invoice-price-row">
                                        <div class="row">
                                            <div class="col-md-5">
                                                <div class="sub-price">
                                                    <small>Total Amount</small>
                                                   Tk. <?php echo $data['totalAmount']->total_amount; ?>
                                                </div>
                                            </div>  
                                            <div class="col-md-2">
                                                <div class="sub-price" style="width: 20px; height: 3px; background: #000; margin-top: 7px;"></div>   
                                            </div>  
                                            <div class="col-md-5">
                                                <div class="sub-price">
                                                    <small>Total Paid Amount</small>
                                                    Tk. {{$data['totalPaid']->total_paid}}
                                                </div>   
                                            </div>  
                                        </div>
                                    </div>
                                </div>
                                
                            </div>
                            <div class="col-md-4">
                                <div class="invoice-price-right">
                                    <small>TOTAL Due</small>Tk. <?php echo intval($data['totalAmount']->total_amount)-intval($data['totalPaid']->total_paid);?>
                                </div>   
                            </div>
                        </div> 
                        <script type="text/javascript" src="{{asset('public/js/inWords.js')}}"></script>
                        <h3 style="text-transform: capitalize;">Taka : <b><script>
                                    document.write(inWords(<?php if(isset($data['totalAmount']->total_amount)){ echo $data['totalAmount']->total_amount;}?>));
                                </script></b></h3> 
                    </div>
                </div>
                <div class="sign" style="width: 100%; height:117px;">
                    <div class="company_sign" style="width: 50%; float: left;">
                        <h5>Received By:</h5>
                        <div style="width: 200px; height: 2px; margin-top: 30px; border-bottom: 1px solid #000;"></div>
                        <div class="bottom_company_sign" style="text-transform: capitalize;">
                            <h5>{{$companyInfo->company_name}}</h5>
                            <h5>{{$companyInfo->company_phone}}</h5>
                        </div>  
                    </div>   
                    <div class="customer_sign" style="width: 35%;float: right;">
                        <h5>Customer Sine:</h5>
                        <div style="width: 200px; height: 2px; margin-top: 30px; border-bottom: 1px solid #000;"></div>
                        <p style="color: #e6e6e6;">(Hear Customer name)</p>
                    </div>   
                </div>
                <div class="invoice-note">
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
            </div>
            <hr>
            <div class="copyright">
                <div class="copyright-section">
                    <p class="pull-left">© 2017 {{$companyInfo->company_name}} All Right Reserved. </p>
                    
                    <p class="design_band pull-right">Powered By: <a href="#" > Smart Software Inc.</a></p>
                </div>
            </div>

            <!-- end invoice -->
        </div>
        <!-- end #content -->
        

    <script src="{{asset('public/plugins/jquery/jquery-1.9.1.min.js')}}"></script>
<script type="text/javascript">
        var a = ['','one ','two ','three ','four ', 'five ','six ','seven ','eight ','nine ','ten ','eleven ','twelve ','thirteen ','fourteen ','fifteen ','sixteen ','seventeen ','eighteen ','nineteen '];
    var b = ['', '', 'twenty','thirty','forty','fifty', 'sixty','seventy','eighty','ninety'];

    function inWords (num) {
        if ((num = num.toString()).length > 9) return 'overflow';
        n = ('000000000' + num).substr(-9).match(/^(\d{2})(\d{2})(\d{2})(\d{1})(\d{2})$/);
        if (!n) return; var str = '';
        str += (n[1] != 0) ? (a[Number(n[1])] || b[n[1][0]] + ' ' + a[n[1][1]]) + 'crore ' : '';
        str += (n[2] != 0) ? (a[Number(n[2])] || b[n[2][0]] + ' ' + a[n[2][1]]) + 'lakh ' : '';
        str += (n[3] != 0) ? (a[Number(n[3])] || b[n[3][0]] + ' ' + a[n[3][1]]) + 'thousand ' : '';
        str += (n[4] != 0) ? (a[Number(n[4])] || b[n[4][0]] + ' ' + a[n[4][1]]) + 'hundred ' : '';
        str += (n[5] != 0) ? ((str != '') ? 'and ' : '') + (a[Number(n[5])] || b[n[5][0]] + ' ' + a[n[5][1]]) + 'only ' : '';
        return str.toLowerCase().replace(/(?:(^.{1})|\ [a-z]{1})/g, function(a){return a.toUpperCase();});
    }
    </script>
@include('_partials.public_view_footer')