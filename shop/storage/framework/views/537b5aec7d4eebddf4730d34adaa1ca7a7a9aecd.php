<? $companyInfo=DB::table('company_info')->first(); ?>
<style type="text/css">
        .invoice_top{display: none;}
        .print-footer{display: none;}
        .printable{display: none;}
        @media  print {
            .table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th{padding: 2px;}
            .invoice_top{display: block;}
            .print-footer{display: block;}
            .printable{display:inline-block;}
            .no-print{display: none;}
            a[href]:after {
                content: none !important;
              }
              .customerInfo p{margin: 0;line-height: 16px;}
              .col-md-6{width: 50%;float: left;}

          
        }        
        @page  {
      size: auto;   /* auto is the initial value */
        margin: 5px 30px;   /* this affects the margin in the printer settings */
    }
</style>
<div class="invoice_top" style="width: 100%; overflow: hidden;border-bottom:1px solid #ddd;padding-bottom: 5px;margin-bottom: 5px;">
<div class="view_logo" style="margin: 0 auto;width: 100%;text-align: center;">
    <img class="print-logo" src='<?php echo e(asset("images/company/logo/$companyInfo->company_logo")); ?>' style="width: auto;height: 60px;position: relative;top: -24px;left: 0;">
    <div class="pad_top_content" style="display: inline-block;">
        <h3 style="margin: 0;margin-left: 20px;display: inline-block;"><strong><?php echo e($companyInfo->company_name); ?></strong></h3>
        <p><?php echo $companyInfo->company_address; ?><br />
        Phone: <?php echo e($companyInfo->company_phone); ?>, Email: <?php echo e($companyInfo->company_email); ?></p>
    </div>
</div>
</div>