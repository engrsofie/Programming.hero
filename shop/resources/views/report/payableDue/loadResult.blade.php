<div class="filter_info">
    <h3 align="center">PayableDue Due</h3>
    <table class="table table-bordered">
        <tr>
            <td><b>Start Date:</b> {{$filterData['start']}}</td>
            <td><b>End Date:</b> {{$filterData['start']}}</td>
        </tr>
    </table>
</div>
            <table class="table table-bordered">
                <thead>
                    <tr class="success">
                       <th>Sl</th>
                        <th>Supplier Name</th>
                        <th>Total Amount</th>
                        <th>Total Due</th>
                    </tr>
                </thead>
                <tbody>
                    
                <? 
                    $i=0;
                    $total_due=0;
                    $total_amount=0;
                    ?>
                    @foreach($allData as $data)
                    <? 
                    $i++;
                    $due=$data->total_amount-$data->paid_amount;
                    $total_due=$total_due+$due;
                    $total_amount=$total_amount+$data->total_amount;

                ?>
                    <tr>
                        <td>{{$i}}</td>
                        <td>{{$data->company_name}}</td>
                        <td>{{round($data->total_amount,3)}}</td>
                        <td>{{round($due,3)}}</td>
                    </tr>
                    @endforeach
                    <tr class="active">
                        <th>*</th>
                        <th style="text-align: right">Total = </th>
                        <th>{{round($total_amount,3)}}</th>
                        <th>{{round($total_due,3)}}</th>
                        
                    </tr>
                                
                </tbody>
                
            </table>