<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use DB;
class DepositCostItem extends Model
{
    protected $table = "deposit_cost_item";
    protected $fillable = ['fk_deposit_id','fk_sub_category_id','description','total_amount','paid_amount']; 

    public static function createDepositCost($deposit_id,$sub_category_id,$description,$total_amount,$paid_amount){
        $create = DB::table('deposit_cost_item')
        ->insertGetId([
            'fk_deposit_id' => $deposit_id,
            'fk_sub_category_id' => $sub_category_id,
            'description' => $description,
            'total_amount' => $total_amount,
            'paid_amount' => $paid_amount,
            'created_at' => date('Y-m-d h:i:s')
            ]);

        return $create;
       
    }



    /*update Deposit Item table*/
    public static function updatedDepositItem($depositId,$depositItemId,$fk_sub_category_id,$description,$totalAmount,$totalPaid){
        $updatedItem = DB::table('deposit_cost_item')
            ->where('id', $depositItemId)
            ->update([
                'fk_deposit_id' => $depositId,
                'fk_sub_category_id' => $fk_sub_category_id,
                'description' => $description,
                'total_amount' => $totalAmount,
                'paid_amount' => $totalPaid,
                'updated_at' => date('Y-m-d h:i:s')
            ]);
        return true;
    }

    /*check is exists delete item */
    public static function isExistsDepositItem($id){
        //print_r($id);exit;
        $result = DB::table('deposit_cost_item')
        ->where('fk_deposit_id', '=', $id)
        ->get();
        return $result;
    }

    /*delete Deposit Item*/
    public static function deleteItemId($itemData){
        //print_r($itemData[1]->id);exit;
        for ($i=0; $i <sizeof($itemData); $i++) {
            $result = DB::table('deposit_cost_item')
                ->where('id', $itemData[$i]->id)  // find your user by their id
                ->delete();
        }

    }

    

    /*update Deposit amount paid*/
    public static function updatePaidAmount($depositItemId,$newPaidAmount){
        //print_r($newPaidAmount);exit;
        $updatedItem = DB::table('deposit_cost_item')
            ->where('id', $depositItemId)
            ->update([
                'paid_amount' => $newPaidAmount,
                'updated_at' => date('Y-m-d h:i:s')
            ]);
        return true;
    }


}
