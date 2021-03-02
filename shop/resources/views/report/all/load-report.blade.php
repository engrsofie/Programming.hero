<div class="invoice-content">
    <div class="table-responsive">
    
    <div class="filter_info">
        <h3 align="center">Income &amp; Expense Reports</h3>
        <table class="table table-bordered">
            <tr>
                 <td><b>From : </b> {{$filterData['start']}}</td>
                <td><b>To : </b> {{$filterData['start']}}</td>
            </tr>
        </table>
    </div>
    <div class="div">
    <div class="col-md-6">
    <p>Income</p>
        <table class="table table-bordered padding5">
            <thead>
                <tr class="success">
                    <th>SL</th>
                    <th>Sector Name</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                 <tr>
                    <td>1</td>
                    <td>Product Sales</td>
                    <td>{{round($sales->total_amount,3)}}</td>
                </tr>
            <? 
            $i=2;
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
                    <td>{{$subReport->sub_category_name}}</td>
                    <td>{{$subReport->total_amount}}</td>
                </tr>
            @endforeach
            </tbody>
            <tfoot>
                <tr class="active">
                    <th>*</th>
                    <th class="text-right">Total = </th>
                    <th>{{round($totalAmount+$sales->total_amount,3)}}</th>
                </tr>
                
            </tfoot>
        </table>
    </div>
    <div class="col-md-6">
        <p>Expense</p>
        <table class="table table-bordered padding5">
            <thead>
                <tr class="success">
                    <th>SL</th>
                    <th>Sector Name</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td>Product Purchase</td>
                    <td>{{round($purchase->total_amount,3)}}</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Total Salary</td>
                    <td>{{round($salary->total_amount,3)}}</td>
                </tr>
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
                    <td>{{$subReport->sub_category_name}}</td>
                    <td>{{$subReport->total_amount}}</td>
                </tr>
            @endforeach
            </tbody>
            <tfoot>
                <tr class="active">
                    <th>*</th>
                    <th class="text-right">Total = </th>
                    <th>{{round($totalAmount+$purchase->total_amount+$salary->total_amount,3)}}</th>
                </tr>
                
            </tfoot>
        </table>
    </div>
    </div>  
    <div class="col-md-12">
        <p style="width: 100%">Accoutn Balance</p>
        <table class="table table-bordered padding5">
            <thead>
                <tr class="success">
                    <th>SL</th>
                    <th>Account Name</th>
                    <th>Balance</th>
                </tr>
            </thead>
            <tbody>
            <? 
            $i=1;
            $totalAmount=0;
            $totalPaid=0;
             ?>
            @foreach($accountReports as $acReport)
            <?
            $totalAmount+=$acReport['balance'];
            ?>
                <tr>
                    <td>{{$i++}}</td>
                    <td>{{$acReport['account_name']}}</td>
                    <td>{{$acReport['balance']}}</td>
                </tr>
            @endforeach
            </tbody>
            <tfoot>
                <tr class="active">
                    <th>*</th>
                    <th class="text-right">Total = </th>
                    <th>{{$totalAmount}}</th>
                </tr>
                
            </tfoot>
        </table>
    </div>
        
    </div>
    
</div>