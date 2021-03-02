<div id="customer_info" style="padding: 0 10px;">
    <div class="row">
        <div class="invoiceInfo" style="width: 100%;">
            <p align="center"><b>Report : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<u>{{$input['start_date']}}</u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TO  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<u>{{$input['end_date']}}</u></b></p>
            <table width="100%">
                <tr>
                    <td><b>Name : </b> <? echo $client->client_name ?></td>
                    <td><b>Mobile : </b> <? echo $client->mobile_no ?></td>
                    <td><b>Address : </b> <? echo $client->address ?></td>
                    <td><b>Email : </b> <? echo $client->email_id ?></td>
                </tr>
            </table>
            <div>
            <br>
            </div>
        </div>
    </div>
</div> 
<div class="invoice-content">
    <div class="table-responsive">
        <div class="row">
            <div class="col-md-12">  
                <table class="table table-bordered smallHr">
                    <thead>
                        <tr>
                            <th width="5%">SL</th>
                            <th width="15%">Date</th>
                            <th width="15%">Invoice ID</th>
                            <th>Buy Amount</th>
                            <th>Paid Amount</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?
                        $previous= $prev->total_amount-$prev->paid_amount;
                        ?>
                        <tr>
                            <td>1</td>
                            <th colspan="2">Previous Balance</th>
                            <th>{{($previous>0)?$previous:''}}</th>
                            <th></th>
                        </tr>
                    <? $i=1;
                        $total=$previous;
                        $paid=0;
                     ?>
                @foreach($report as $data)
                    <? $i++;
                        $total+=$data->total_amount;
                        $paid+=$data->paid;
                     ?>
                    <tr>
                        <td>{{$i}}</td>
                        <td>{{date('d-m-Y',strtotime($data->date))}}</td>
                        <td>{{$data->invoice_id}}</td>
                        <td>{{round($data->total_amount,3)}}</td>
                        <td>{{round($data->paid,3)}}</td>
                    </tr>
                @endforeach
                @foreach($payment as $pay)
                    <? $i++;
                        $paid+=$pay->paid;
                     ?>
                    <tr>
                        <td>{{$i}}</td>
                        <td>{{date('d-m-Y',strtotime($pay->payment_date))}}</td>
                        <td>{{$pay->invoice_id}}</td>
                        <td></td>
                        <td>{{round($pay->paid,3)}}</td>
                    </tr>
                @endforeach
                    <tr>
                        <td>*</td>
                        <th colspan="2">Total = </th>
                        <th>{{round($total,3)}}</th>
                        <th>{{round($paid,3)}}</th>
                    </tr>
                    <tr>
                        <th colspan="4" style="text-align: right;">Due Amount = </th>
                        <th>{{round($total-$paid,3)}}</th>
                    </tr>
                    </tbody>

                </table>
            </div>
                                  
        </div>
    </div>
</div>