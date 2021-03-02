@extends('layout.app')
    @section('content')
    <style type="text/css">
        .modal-dialog{width: 900px;}
        .invoice-note {margin-top: 35px;}
        .invoice-company{width: 100%; overflow: hidden;}
        .invoice-footer{width: 50%; float: right; overflow: hidden; border:0; }
        .invoice-content{width: 100%; overflow: hidden; border-bottom: 1px solid #999;}
        h5{margin-top: 0 !important;}
    </style>
        <!-- begin #content -->
        <div id="content" class="content">
            
            <!-- begin invoice -->
            <div class="invoice">
                <div class="invoice-company">
                    <span class="pull-right hidden-print">
                    
                    <a href='{{URL::to("billing-payment-system/create")}}' id="pdf-generate" class="btn btn-sm btn-success m-b-10"><i class="fa fa-plus m-r-5"></i> New Payment Transition</a>
                    <a href="javascript:;" onclick="window.print()" class="btn btn-sm btn-success m-b-10"><i class="fa fa-print m-r-5"></i> Print</a>

                    
                    </span>
                  
                </div>
                
                <div class="invoice">
                    <div class="invoice_ganarat">
                        <div class="invoice_left">
                           <div class="invoice_top">
                               <div class="invoice_top_left">
                                  <div class="invoice_company_logo">
                                      <img src='{{asset("images/company/logo/$getCompanyData->company_logo")}}'> 
                                  </div>
                                  <br>
                                  <?php echo $getCompanyData->company_address; ?>
                                  <br>
                                  <?php echo $getCompanyData->company_email; ?>
                                  <br>
                                  <?php echo $getCompanyData->web_address; ?>
                               </div>
                               <div class="invoice_top_right">
                                    <div class="copy">Office Copy</div>
                                   Date: <?php echo $getPayment->payment_date; ?>
                                   <br>
                                   Invoice : <?php echo $getPayment->transition_id; ?>
                                   <br>
                                   ID : <?php echo $getPayment->id; ?>
                                   <br>
                                   Area : <?php echo $getPayment->area_name; ?>
                               </div>
                           </div>
                           <hr>
                           <div class="invoice-content">
                                <table style="width: 100%; text-transform: capitalize;">
                                    <tr>
                                        <th width="50%"><h5>Name :</h5></th>
                                        <td><h5><?php echo $getPayment->customer_name; ?> </h5></td>
                                    </tr>
                                    <tr>
                                        <th width="50%"><h5>Address :</h5></th>
                                        <td><h5><?php echo $getPayment->address; ?> </h5></td>
                                    </tr>
                                    <tr>
                                        <th width="50%"><h5>Mobile No. :</h5></th>
                                        <td><h5><?php echo $getPayment->customer_phone; ?> </h5></td>
                                    </tr>
                                    <tr>
                                        <th width="50%"><h5>Monthly Charge :</h5></th>
                                        <td><h5> <?php echo $getPayment->line_amount; ?></h5></td>
                                    </tr>
                                    
                                    <tr>
                                        <th width="50%"><h5>Month :</h5></th>
                                        <td><h5>
                                         <?php 
                                            
                                            foreach ($getMultiPayment as $transitionMonth) {
                                                $dateObj = DateTime::createFromFormat('!m',$transitionMonth->month);
                                                echo $dateObj->format('F'). ',';
                                            }
                                            ?></h5></td>
                                    </tr>
                                    <tr>
                                        <th width="50%"><h5>Total Amount :</h5></th>
                                        <td><h5> <?php echo ($getPayment->paid_amount)+($getPayment->discount)+($getPayment->due_amount); ?></h5></td>
                                    </tr>
                                    <tr>
                                        <th width="50%"><h5>Discount :</h5></th>
                                        <td><h5> <?php echo $getPayment->discount; ?></h5></td>
                                    </tr>
                                    <tr>
                                        <th width="50%"><h5>Total Paid :</h5></th>
                                        <td><h5> <?php echo $getPayment->paid_amount; ?></h5></td>
                                    </tr>
                                    <tr>
                                        <th width="50%"><h5>Total Due :</h5></th>
                                        <td><h5> <?php echo $getPayment->due_amount; ?></h5></td>
                                    </tr>
                                    <tr>
                                        <th width="50%"><h5>Receive By :</h5></th>
                                        <td><h5> <?php echo $getPayment->staff_name; ?></h5></td>
                                    </tr>
                                    
                                </table>
                               
                           </div>

                           <div class="invoice-footer">
                               <p>Powered By: Smart Software Inc.</p>
                           </div> 
                        </div>
                        <div class="invoice_right">
                           <div class="invoice_top">
                               <div class="invoice_top_left">
                                  <div class="invoice_company_logo">
                                      <img src='{{asset("images/company/logo/$getCompanyData->company_logo")}}'> 
                                  </div>
                                  <br>
                                  <?php echo $getCompanyData->company_address; ?>
                                  <br>
                                  <?php echo $getCompanyData->company_email; ?>
                                  <br>
                                  <?php echo $getCompanyData->web_address; ?>
                               </div>
                               <div class="invoice_top_right">
                                    <div class="copy">Money Receipt</div>
                                   Date: <?php echo $getPayment->payment_date; ?>
                                   <br>
                                   Invoice : <?php echo $getPayment->transition_id; ?>
                                   <br>
                                   ID : <?php echo $getPayment->id; ?>
                                   <br>
                                   Area : <?php echo $getPayment->area_name; ?>
                               </div>
                           </div>
                           <hr>
                           <div class="invoice-content">
                                <table style="width: 100%; text-transform: capitalize;">
                                    <tr>
                                        <th width="50%"><h5>Name :</h5></th>
                                        <td><h5><?php echo $getPayment->customer_name; ?> </h5></td>
                                    </tr>
                                    <tr>
                                        <th width="50%"><h5>Address :</h5></th>
                                        <td><h5><?php echo $getPayment->address; ?> </h5></td>
                                    </tr>
                                    <tr>
                                        <th width="50%"><h5>Mobile No. :</h5></th>
                                        <td><h5><?php echo $getPayment->customer_phone; ?> </h5></td>
                                    </tr>
                                    <tr>
                                        <th width="50%"><h5>Monthly Charge :</h5></th>
                                        <td><h5> <?php echo $getPayment->line_amount; ?></h5></td>
                                    </tr>
                                    
                                    <tr>
                                        <th width="50%"><h5>Month :</h5></th>
                                        <td><h5>
                                         <?php 
                                            
                                            foreach ($getMultiPayment as $transitionMonth) {
                                                $dateObj = DateTime::createFromFormat('!m',$transitionMonth->month);
                                                echo $dateObj->format('F'). ',';
                                            }
                                            ?></h5></td>
                                    </tr>
                                    <tr>
                                        <th width="50%"><h5>Total Amount :</h5></th>
                                        <td><h5> <?php echo ($getPayment->paid_amount)+($getPayment->discount)+($getPayment->due_amount); ?></h5></td>
                                    </tr>
                                    <tr>
                                        <th width="50%"><h5>Discount :</h5></th>
                                        <td><h5> <?php echo $getPayment->discount; ?></h5></td>
                                    </tr>
                                    <tr>
                                        <th width="50%"><h5>Total Paid :</h5></th>
                                        <td><h5> <?php echo $getPayment->paid_amount; ?></h5></td>
                                    </tr>
                                    <tr>
                                        <th width="50%"><h5>Total Due :</h5></th>
                                        <td><h5> <?php echo $getPayment->due_amount; ?></h5></td>
                                    </tr>
                                    <tr>
                                        <th width="50%"><h5>Receive By :</h5></th>
                                        <td><h5> <?php echo $getPayment->staff_name; ?></h5></td>
                                    </tr>
                                    
                                </table>
                               
                           </div>

                           <div class="invoice-footer">
                               <p>Powered By: Smart Software Inc.</p>
                           </div> 
                        </div>
                    </div>
                </div>
                
            </div>

            <!-- end invoice -->
        </div>
        <!-- end #content -->


    
@endsection