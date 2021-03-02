<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InventoryOrderPaymentItem extends Model
{
   protected $table='inventory_order_payment_item';
   protected $fillable=['fk_order_id','fk_order_payment_id','type','order_last_due','order_paid'];
   public function order(){
   	return $this->belongsTo(InventoryProductAdd::class,'fk_order_id','id');
   }
   public function payment(){
   	return $this->belongsTo(InventoryOrderPayment::class,'fk_order_payment_id','id');
   }
}
