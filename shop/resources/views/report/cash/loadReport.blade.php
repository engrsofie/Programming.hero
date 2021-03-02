<div class="invoice-content">
    <div class="table-responsive">
    
    <div class="filter_info">
        <h3 align="center">Account Cash Reports</h3>
        <table class="table table-bordered">
            <tr>
                 <td><b>Date : </b> {{$filterData['start']}} - {{$filterData['start']}}</td>
                <td><b>Branch : </b> {{$filterData['branch']}}</td>
                <td><b>User : </b> {{$filterData['user']}}</td>
            </tr>
        </table>
    </div>
    <div class="div">
    <div class="col-md-12">
    <p>Deposit</p>
        <table class="table table-bordered padding5">
            <thead>
                <tr class="success">
                    <th>SL</th>
                    <th>Client Name</th>
                    <th>Sector Name</th>
                    <th>Total</th>
                    <th>Paid</th>
                    <th>Due</th>
                </tr>
            </thead>
            <tbody>
            <? 
            $i=1;
            $totalSales=0;
            $totalPaidSales=0;
             ?>
            @foreach($sales as $sale)
            <?
            $totalSales+=$sale->total_amount;
            $totalPaidSales+=$sale->paid_amount;
            ?>
                <tr>
                    <td>{{$i++}}</td>
                    <td>{{$sale->client_name}}</td>
                    <td>Product Sales</td>
                    <td>{{round($sale->total_amount,3)}}</td>
                    <td>{{round($sale->paid_amount,3)}}</td>
                    <td>{{round($sale->total_amount-$sale->paid_amount,3)}}</td>
                </tr>
            @endforeach

            <? 
            $totalAmount=0;
            $totalPaid=0;
             ?>
            @foreach($depositReports as $subReport)
            <?
            $totalAmount+=$subReport->total_amount;
            $totalPaid+=$subReport->total_paid;
            ?>
                <tr>
                    <td>{{$i++}}</td>
                    <td>{{$subReport->client_name}}</td>
                    <td>{{$subReport->sub_category_name}}</td>
                    <td>{{$subReport->total_amount}}</td>
                    <td>{{$subReport->total_paid}}</td>
                    <td>{{$subReport->total_amount-$subReport->total_paid}}</td>
                </tr>
            @endforeach
            </tbody>
            <tfoot>
                <tr class="active">
                    <th>*</th>
                    <th colspan="2" class="text-right">Total = </th>
                    <th>{{round($totalAmount+$totalSales,3)}}</th>
                    <th>{{round($totalPaid+$totalPaidSales,3)}}</th>
                    <th>{{round(($totalAmount-$totalPaid)+($totalSales-$totalPaidSales),3)}}</th>
                </tr>
                
            </tfoot>
        </table>
    </div>
    <div class="col-md-12">
        <p>Payment</p>
        <table class="table table-bordered padding5">
            <thead>
                <tr class="success">
                    <th>SL</th>
                    <th>Client Name</th>
                    <th>Sector Name</th>
                    <th>Total</th>
                    <th>Paid</th>
                    <th>Due</th>
                </tr>
            </thead>
            <tbody>
                
            <? 
            $i=3;
            $totalAmount=0;
            $totalPaid=0;
             ?>
            @foreach($paymentReports as $subReport)
            <?
            $totalAmount+=$subReport->total_amount;
            $totalPaid+=$subReport->total_paid;
            ?>
                <tr>
                    <td>{{$i++}}</td>
                    <td>{{$subReport->client_name}}</td>
                    <td>{{$subReport->sub_category_name}}</td>
                    <td>{{$subReport->total_amount}}</td>
                    <td>{{$subReport->total_paid}}</td>
                    <td>{{$subReport->total_amount-$subReport->total_paid}}</td>
                </tr>
            @endforeach
            <? 
            $totalSalary=0;
            $totalPaidSalary=0;
             ?>
            @foreach($salary as $emp)
            <?
            $totalSalary+=$emp->total_amount;
            ?>
                <tr>
                    <td>{{$i++}}</td>
                    <td>{{$emp->employe_name}}</td>
                    <td>Salary</td>
                    <td>{{round($emp->total_amount,3)}}</td>
                    <td>{{round($emp->total_amount,3)}}</td>
                    <td>0</td>
                </tr>
            @endforeach
            </tbody>
            <tfoot>
                <tr class="active">
                    <th>*</th>
                    <th colspan="2" class="text-right">Total = </th>
                    <th>{{round($totalAmount+$totalSalary,3)}}</th>
                    <th>{{round($totalPaid+$totalSalary,3)}}</th>
                    <th>{{round($totalAmount-$totalPaid,3)}}</th>
                </tr>
                
            </tfoot>
        </table>
    </div>
    </div>
        
    </div>
    
</div>