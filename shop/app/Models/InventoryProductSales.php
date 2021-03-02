<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InventoryProductSales extends Model
{
    protected $table = 'inventory_product_sales';
    protected $fillable = ['fk_client_id','summary','invoice_id','date','total_amount','discount','paid_amount','created_by','shipping_address','order_id','type','shipping_date','fk_user_id','fk_branch_id','fk_company_id','sales_type','transport_bill','sales_type','prev_amount','prev_paid'];
}
