<div class="invoice-content">
    <div class="table-responsive">
        <table class="table table-invoice">
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Category Name</th>
                    <th>Sub Category Name</th>
                    <th>Invoice No.</th>
                    <th>Client Name</th>
                    <th>Paid</th>
                    <th>Due</th>
                </tr>
            </thead>
            <tbody>
            @foreach($getPaymentReport as $report)
                <tr>
                    <td>{{$report->t_date}}</td>
                    <td>{{$report->category_name}}</td>
                    <td>{{$report->sub_category_name}}</td>
                    <td>{{$report->invoice_no}}</td>
                    <td>{{$report->client_name}}</td>
                    <td>{{$report->total_amount}}</td>
                    <td>{{$report->paid_amount}}</td>
                </tr>
            @endforeach
            </tbody>
            <tfoot>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>{{$totalAmount->total_amount}}</td>
                    <td>{{$totalAmount->total_amount-$totalPaid->total_paid}}</td>
                </tr>
                
            </tfoot>
        </table>
    </div>
    
</div>