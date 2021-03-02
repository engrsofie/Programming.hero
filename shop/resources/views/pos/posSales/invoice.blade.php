<style type="text/css">
    #print_body{display: none;}
    @media print {
    #print_body{display: block;}

    }
</style>
<div id="print_body" style="width: 100%;overflow: hidden; padding: 10px 20px;">
    @include('pad.header')
        <h4 style="width: 100%;text-align: center;margin-top: 15px;"><b style="padding: 10px 20px;border-radius: 10px;color: #000;border:1px solid #ddd;">Sales Invoice</b>
            <br>
            <br>
            </h4>
        <div id="customer_info">
        <div class="row">
            <div class="customerInfo" style="width: 60%;float: left;">
                <p><b><u>Invoiced to</u></b></p>
                <p><b>Organization Name : </b>{{$getInvoiceData->company_name}}</p>
                <p><b>Address : </b> {{$getInvoiceData->address}}</p>
                <p><b>Mobile No :</b> {{$getInvoiceData->mobile_no}}</p>
                <p><b>Email : </b> {{$getInvoiceData->email_id}}</p>
                <br><br>
            </div>
            <div class="invoiceInfo" style="width: 40%;float: left;">
                <table class="table table-bordered">
                    <tr>
                        <th>Invoice #: </th>
                        <th>{{$getInvoiceData->invoice_id}} </th>
                    </tr>
                     <tr>
                        <td>Invoice Date : </td>
                        <td>{{date('d-m-Y',strtotime($getInvoiceData->date))}}</td>
                    </tr>
                @if($getInvoiceData->order_id!=null)
                    <tr>
                        <td>P.O : </td>
                        <td>{{$getInvoiceData->order_id}}</td>
                    </tr>
                @endif
                </table>
            </div>
        </div>
    </div> 
    
    <div class="invoice-content">
        <div class="table-responsive">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th width="5%">SL</th>
                        <th>Product Info</th>
                        <th width="12%">Quantity</th>
                        <th width="15%" class="text-right">Unit Price</th>
                        <th width="20%" class="text-right">Sub Total</th>
                    </tr>
                </thead>
                <tbody>
                
                <? $i=0;
                    $subTotal=0;
                 ?>
                    @if(isset($getProductData))
                    @foreach($getProductData as $product)
                    <? $i++;
                    $subTotal+=$product->product_price_amount*$product->sales_qty;
                     ?>
                    <tr>
                        <td>{{$i}}</td>
                        <td>{{$product->product_name}} ({{$product->model_name}})</td>
                        <td>{{$product->sales_qty}} {{$product->small_unit_name}}</td>
                        <td class="text-right">{{round($product->product_price_amount,2)}}</td>
                        <td class="text-right">{{round($product->product_price_amount*$product->sales_qty,2)}}</td>
                        
                    </tr>
                    @endforeach

                    @endif
                   
                </tbody>
            </table>
            <div class="col-md-6" style="width: 50%;float: left;">
                @if($getInvoiceData->paid_amount+$getInvoiceData->prev_paid>0)
                 <h6 style="text-transform: capitalize;text-align: left;"><b>Paid In Words :</b>
                <? 
                echo App\Http\Controllers\NumberFormat::taka(round($getInvoiceData->paid_amount+$getInvoiceData->prev_paid,2));
                ?><b></b></h6>
                @endif

                <div class="col-md-12 no-padding well">
                    <div class="col-md-12"> 
                        @if($prev->total_amount-$prev->paid_amount>0)
                        <p><b>Previous Due: </b> {{$prev->total_amount-$prev->paid_amount}}</p>
                        @endif
                        <p><b>Sales By: </b> {{$getInvoiceData->sales_by}}</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-md-offset-2 no-padding" style="width:40%;float: right;">
                <table class="table table-bordered table-striped">
                    <thead>
                        <tr class="success">
                            <th width="40%" class="text-right">Particular</th>
                            <th class="text-right">Amount</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th class="text-right">Sub Total :</th>
                            <td class="text-right">{{round($getInvoiceData->total_amount+$getInvoiceData->discount,3)}}</td>
                        </tr>
                        <tr>
                            <th class="text-right">Discount :</th>
                            <td class="text-right">{{round($getInvoiceData->discount,3)}}</td>
                        </tr>
                        <tr>
                            <th class="text-right">Total Amount:</th>
                            <td class="text-right">{{round($getInvoiceData->total_amount,3)}}</td>
                        </tr>
                    @if($getInvoiceData->prev_amount>0)
                        <tr>
                            <th class="text-right">Previous Due:</th>
                            <td class="text-right">{{round($getInvoiceData->prev_amount,3)}}</td>
                        </tr>
                        <tr>
                            <th class="text-right">Grand Total :</th>
                            <td class="text-right">{{round($getInvoiceData->total_amount+$getInvoiceData->prev_amount,3)}}</td>
                        </tr>
                    @endif
                        <tr>
                            <th class="text-right">Paid Amount :</th>
                            <td class="text-right">{{round($getInvoiceData->paid_amount+$getInvoiceData->prev_paid,3)}}</td>
                        </tr>
                        <tr>
                            <th class="text-right">Due Amount :</th>
                            <th class="text-right">{{round(($getInvoiceData->total_amount+$getInvoiceData->prev_amount)-($getInvoiceData->paid_amount+$getInvoiceData->prev_paid),3)}}</th>
                        </tr>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="printFooter" style="overflow: hidden;width: 100%;">
       @include('pad.footer')
   </div>
</div>