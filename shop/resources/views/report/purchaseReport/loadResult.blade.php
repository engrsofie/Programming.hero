<div class="filter_info">
    <h3 align="center">Purchase Report</h3>
    <table class="table table-bordered">
        <tr>
            <td><b>Start Date:</b> {{$filterData['start']}}</td>
            <td><b>End Date:</b> {{$filterData['end']}}</td>
            <td><b>Category :</b> {{($filterData['category']>0)?$total['category_name']:'All'}}</td>
        </tr>
    </table>
</div>
            <table class="table table-bordered">
                <thead>
                    <tr class="success">
                        <th>Sl</th>
                        <th>Product Name</th>
                        <th>Category Name</th>
                        <th>QTY</th>
                        <th>Total Amount</th>
                    </tr>
                </thead>
                <tbody>
                <? 
                $i=0;
                $total_qty=0;
                $total_amount=0;
                ?>
                @foreach($allData as $data)
                <? 
                $i++;
                $total_qty=$total_qty+$data->total_qty;
                $total_amount=$total_amount+$data->total_amount;
                ?>
                <tr>
                    <td>{{$i}}</td>
                    <td>{{$data->product_name}}</td>
                    <td>{{$data->category_name}}</td>
                    <td>{{$data->total_qty}}</td>
                    <td>{{round($data->total_amount,2)}}</td>
                </tr>
                @endforeach
                <tr class="active">
                    <th>*</th>
                    <th colspan="2" style="text-align: right">Total = </th>
                    <th>{{$total_qty}}</th>
                    <th>{{round($total_amount,2)}}</th>
                    
                </tr>
                </tbody>
                
            </table>
