<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InventoryOrderPayment extends Model
{
   protected $table='inventory_order_payment';
   protected $fillable=['last_due','paid','payment_date','created_by','invoice_id','type','fk_supplier_id'];
   public function item(){
   	return $this->hasMany(InventoryOrderPaymentItem::class,'fk_order_payment_id','id');
   }
   public function supplier(){
   	return $this->belongsTo(InventorySupplier::class,'fk_supplier_id','id');
   }
   public function user(){
   	return $this->belongsTo(\App\User::class,'created_by','id');
   }
}
