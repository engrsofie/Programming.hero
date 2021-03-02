<div class="sign" style="width: 100%; overflow: hidden;">
    <div class="company_sign" style="width: 50%; float: left;">
        <h5>Received By:</h5>
        <div style="width: 200px; height: 2px; margin-top: 30px; border-bottom: 1px solid #000;"></div>
        <div class="bottom_company_sign" style="text-transform: capitalize;">
            <h5>{{$companyInfo->company_name}}</h5>
            <h5>{{$companyInfo->company_phone}}</h5>
        </div>  
    </div>   
    <div class="customer_sign" style="width: 33%;float: right;">
        <h5>Customer Sine:</h5>
        <div style="width: 200px; height: 2px; margin-top: 30px; border-bottom: 1px solid #000;"></div>
        <p style="color: #e6e6e6;">(Hear Customer name)</p>
    </div>   
</div>
<div class="invoice-footer text-muted">
    <p class="text-center m-b-5">
        THANK YOU
    </p>
    <p class="text-center">
        <span class="m-r-10"><i class="fa fa-globe"></i> {{$companyInfo->web_address}}</span>
        <span class="m-r-10"><i class="fa fa-phone"></i>{{$companyInfo->company_phone}}</span>
        <span class="m-r-10"><i class="fa fa-envelope"></i> {{$companyInfo->company_email}}</span>
    </p>
</div>
<hr>
<div class="copyright">
    <div class="copyright-section">
        <p class="pull-left">© 2017 {{$companyInfo->company_name}} All Right Reserved. </p>
        
        <p class="design_band pull-right">Powered By: <a href="#" > Smart Software Inc.</a></p>
    </div>
</div>
<br>