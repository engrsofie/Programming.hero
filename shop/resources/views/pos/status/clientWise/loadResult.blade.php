<div class="filter_info">
    <h3 align="center">Sales Report</h3>
    <table class="table table-bordered">
        <tr>
            <td><b>Start Date:</b> {{$filterData['start']}}</td>
            <td><b>End Date:</b> {{$filterData['start']}}</td>
            <td><b>Branch :</b> {{($filterData['branch']!=null)?$total->branch_name:'All'}}</td>
            <td><b>Client :</b> {{($filterData['client']>0)?$total->client_name:'All'}}</td>
        </tr>
    </table>
</div>
            <table class="table table-bordered">
                <thead>
                    <tr class="success">
                        <th>Sl</th>
                        <th>Organization Name</th>
                        <th>Total Amount</th>
                        <th>Paid Amount</th>
                        <th>Due</th>
                        <th>Discount</th>
                    </tr>
                </thead>
                <tbody>
                <? 
                $i=0;
                $paid_amount=0;
                $total_amount=0;
                $discount=0;
                ?>
                @foreach($allData as $data)
                <? 
                $i++;
                $paid_amount=$paid_amount+$data->paid_amount;
                $total_amount=$total_amount+$data->total_amount;
                $discount=$discount+$data->discount;
                ?>
                <tr>
                    <td>{{$i}}</td>
                    <td>{{$data->client_name}}</td>
                    <td>{{round($data->total_amount,2)}}</td>
                    <td>{{round($data->paid_amount,2)}}</td>
                    <td>{{round($data->total_amount-$data->paid_amount,2)}}</td>
                    <td>{{round($data->discount,2)}}</td>
                </tr>
                @endforeach
                <tr class="active">
                    <th>*</th>
                    <th style="text-align: right">Total = </th>
                    <th>{{round($total_amount,2)}}</th>
                    <th>{{round($paid_amount,2)}}</th>
                    <th>{{round($total_amount-$paid_amount,2)}}</th>
                    <th>{{round($discount,2)}}</th>
                    
                </tr>
                </tbody>
                
            </table>
            <table class="table table-bordered">
                <tr class="warning">
                    <td><b>Total Sales Amount : </b>{{round($total->total_amount,2)}}</td>
                    <td><b> Paid Amonut : </b>{{round($total->paid_amount,2)}}</td>
                    <td><b> Due Amount : </b> {{round($total->total_amount-$total->paid_amount,2)}}</td>
                    <td><b> Discount : </b>{{round($total->discount,2)}}</td>
                </tr>
            </table>
