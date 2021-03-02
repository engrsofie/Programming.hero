<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use DB;
class PaymentCostItem extends Model
{
    protected $table = "payment_cost_item";
    protected $fillable = ['fk_payment_id','fk_sub_category_id','description','total_amount','paid_amount']; 

    public static function createPaymentCost($payment_id,$sub_category_id,$description,$total_amount,$paid_amount){
        $create = DB::table('payment_cost_item')
        ->insertGetId([
            'fk_payment_id' => $payment_id,
            'fk_sub_category_id' => $sub_category_id,
            'description' => $description,
            'total_amount' => $total_amount,
            'paid_amount' => $paid_amount,
            'created_at' => date('Y-m-d h:i:s')
            ]);

        return $create;
       
    }



    /*update Payment Item table*/
    public static function updatedPaymentItem($paymentId,$paymentItemId,$fk_sub_category_id,$description,$totalAmount,$totalPaid){
        $updatedItem = DB::table('payment_cost_item')
            ->where('id', $paymentItemId)
            ->update([
                'fk_payment_id' => $paymentId,
                'fk_sub_category_id' => $fk_sub_category_id,
                'description' => $description,
                'total_amount' => $totalAmount,
                'paid_amount' => $totalPaid,
                'updated_at' => date('Y-m-d h:i:s')
            ]);
        return true;
    }

    /*check is exists delete item */
    public static function isExistsPaymentItem($id){
        //print_r($id);exit;
        $result = DB::table('payment_cost_item')
        ->where('fk_payment_id', '=', $id)
        ->get();
        return $result;
    }

    /*delete Payment Item*/
    public static function deleteItemId($itemData){
        //print_r($itemData[1]->id);exit;
        for ($i=0; $i <sizeof($itemData); $i++) {
            $result = DB::table('payment_cost_item')
                ->where('id', $itemData[$i]->id)  // find your user by their id
                ->delete();
        }

    }

    /*update Payment amount paid*/
    public static function updatePaidAmount($paymentItemId,$newPaidAmount){
        //print_r($newPaidAmount);exit;
        $updatedItem = DB::table('payment_cost_item')
            ->where('id', $paymentItemId)
            ->update([
                'paid_amount' => $newPaidAmount,
                'updated_at' => date('Y-m-d h:i:s')
            ]);
        return true;
    }
}
