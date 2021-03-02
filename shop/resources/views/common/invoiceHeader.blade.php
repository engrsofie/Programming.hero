<style type="text/css">
	@media print {
            .col-md-6{width: 50%;float: left;}
            .alert {display: none;}
            .reflink {display: none;}
            .refId {display: inline-block;}
            .table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th{padding: 2px;}
          @page {
          size: auto;   /* auto is the initial value */
          margin: 5mm;  /* this affects the margin in the printer settings */
        }
        }
</style>
<div class="invoice_top" style="width: 100%; overflow: hidden;">
    <div class="view_logo" style="width: 18%; float: left;">
        <img src='{{asset("images/company/logo/$companyInfo->company_logo")}}' style="width: 100%; height: auto;">
    </div>
    <div class="view_company_info" style="width: 33%; float: right; margin-left: 0%;">
        <strong>{{$companyInfo->company_name}}</strong><br />
        <?php echo $companyInfo->company_address; ?><br />
        Phone: {{$companyInfo->company_phone}}<br />
        E-mail: {{$companyInfo->company_email}}
    </div>
</div>