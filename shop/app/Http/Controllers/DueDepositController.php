<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Deposit;
use App\Models\DepositCostItem;
use App\Models\SubCategories;
use App\Models\Clients;
use App\Models\ProjectItem;
use App\Models\AccountSetting;
use App\Models\PaymentMethod;
use App\Models\DepositHistory;
use DB;
use Validator;
use Auth;

class DueDepositController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        
        $query = Deposit::leftJoin('clients','deposit.fk_client_id','=','clients.id')
        ->leftJoin('inventory_branch','deposit.fk_branch_id','=','inventory_branch.id')
        ->leftJoin('account','deposit.fk_account_id','=','account.id')
        ->leftJoin('payment_method','deposit.fk_method_id','=','payment_method.id')
        ->whereColumn('deposit.amount', '>', 'deposit.total_paid')
        ->select('deposit.*','account.account_name','clients.client_name','payment_method.method_name','branch_name')
        ->orderBy('id','DESC');
        if(Auth::user()->isRole('administrator')){
            $getDueDeposit=$query->get();
        }else{
            $getDueDeposit=$query->where(['deposit.fk_branch_id'=>Auth::user()->fk_branch_id,'deposit.fk_company_id'=>Auth::user()->fk_company_id])->get();

        }
        //return $getDueDeposit;

        return view('deposit.viewDueDeposits', compact('getDueDeposit'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        

        $getDepositData =Deposit::leftJoin('clients','deposit.fk_client_id','=','clients.id')
        ->leftJoin('account','deposit.fk_account_id','=','account.id')
        ->leftJoin('payment_method','deposit.fk_method_id','=','payment_method.id')
        ->select('deposit.*','account.account_name','clients.client_name','payment_method.method_name')
        ->where('deposit.id',$id)
        ->first();

        
        $getDueDepositData = DepositCostItem::
        leftJoin('sub_category','deposit_cost_item.fk_sub_category_id','=','sub_category.id')
        ->where('fk_deposit_id',$id)
        ->whereColumn('total_amount', '>', 'paid_amount')
        ->select('deposit_cost_item.*','sub_category.sub_category_name')
        ->get();

        

        return view('deposit.singleDueDepositEdit', compact('getDepositData','getDueDepositData'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $getDepositData = Deposit::findOrFail($id);
        $validator = Validator::make($request->all(),[
            't_date' => 'required'
        ]);

        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }

        $input = $request->all();
        $lastId=DepositHistory::max('invoice_id');
        if($lastId!=null){
            $input['invoice_no']=$lastId+1;
        }else{
            $input['invoice_no'] = date('ymd').'1';
        }
        
        try {
            //print_r($input['paid']);exit;
            $depositExistsId = sizeof($input['deposit_item_old_id']);
            for ($i=0; $i < $depositExistsId; $i++) { 
                $depositItemId = $input['deposit_item_old_id'][$i];
                $existsPaid = DepositCostItem::findOrFail($depositItemId);
                $newPaidAmount = $existsPaid->paid_amount+$input['paid'][$i];
                $paid_Amount = DepositCostItem::updatePaidAmount($depositItemId,$newPaidAmount);
                DepositHistory::create([
                    'fk_deposit_item_id'=>$depositItemId,
                    'created_by'=>$input['updated_by'],
                    'invoice_id'=>$input['invoice_no'],
                    'last_due'=>$input['last_due'][$i],
                    'paid'=>$input['paid'][$i],
                    'payment_date'=>$input['t_date'],
                    ]);
            }
            $getDepositData->update([
                'total_paid'=>$getDepositData->total_paid+$input['total_paid'],
                ]);
            $bug = 0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
       
        if($bug == 0){
            return redirect("deposit/".$input['invoice_no']);
        }else{
            return redirect()->back()->with('error','Something Error Found !, Please try again.'.$bug1);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
