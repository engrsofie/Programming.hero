<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\CompanyInfo;
use App\Models\EmailConfig;
use App\Models\TermsCondition;
use App\Models\InventoryBranch;
use App\Models\InventoryOrderPayment;
use App\Models\InventoryOrderPaymentItem;
use App\Http\Requests;
use Validator;
use Response;
use DB;
use Auth;

class DashboardController extends Controller
{
    /**
     * Display a listing of the resource article table.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $companyInfo = CompanyInfo::first();
        $emailConfig = EmailConfig::first();
        $condition = TermsCondition::first();
        $branch=InventoryBranch::where('status',1)->pluck('branch_name','id');

        return view('index' ,compact('companyInfo','emailConfig','condition','branch'));

        
    }
     public function databaseTable(){
        $tables = DB::select('SHOW TABLES');
        foreach ($tables as $table) {
            foreach ($table as $key => $value)
                $accounting[]=$value;       
           DB::statement('ALTER TABLE ' . $value . ' ENGINE = InnoDB'); 
        }
            return $accounting;
    }
    public function branch($id){
        Auth::user()->update(['fk_branch_id'=>$id]);
        return redirect()->back();
    }

    public function allTable(){
        $tables = DB::select('SHOW TABLES');
        foreach ($tables as $k => $table) {
            foreach ($table as $key => $value)
                    $allData[$k]['table']=$value;
                    $allData[$k]['row']=DB::table("$value")->count();
        }
        return view('truncate',compact('allData'));
    }
    public function truncateTable($table){


        try {
            DB::statement('DELETE FROM ' . $table); 
            DB::statement('ALTER TABLE ' . $table . ' AUTO_INCREMENT = 1'); 
            $bug = 0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect()->back()->with('success','SuccessFully Truncate.');
        }else{
            return redirect()->back()->with('error','Error: '.$bug1);
        }
    }


    public function productOrder(){
        $all=InventoryOrderPaymentItem::leftJoin('inventory_product_add','inventory_order_payment_item.fk_order_id','inventory_product_add.id')->leftJoin('inventory_order_payment','inventory_order_payment_item.fk_order_payment_id','inventory_order_payment.id')->select('inventory_order_payment_item.fk_order_payment_id','inventory_product_add.fk_supplier_id')->where('inventory_order_payment.fk_supplier_id','=',null)->groupBy('inventory_order_payment_item.fk_order_payment_id')->get();
        foreach($all as $d){
            InventoryOrderPayment::where('id',$d->fk_order_payment_id)->update([
                'fk_supplier_id'=>$d->fk_supplier_id,
            ]);
            
        }
        return $all;
    }

}
