<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\AccountMoneyTransfer;
use App\Models\Deposit;
use App\Models\Payment;
use App\Models\AccountSetting;
use App\Models\PaymentMethod;
use App\Models\InventoryBranch;
use App\Models\InventoryProductAdd;
use App\Models\InventorySalesPaymentHistory;
use App\Models\EmployeSalarySheet;
use Auth;
use DB;
use Validator;

class AccountMoneyTransferController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $allData =  AccountMoneyTransfer::leftJoin('account','account_money_transfer.transfer_from','=','account.id')
        ->leftJoin('inventory_branch','account.fk_branch_id','=','inventory_branch.id')
        ->leftJoin('account as account1','account_money_transfer.transfer_to','=','account1.id')
        ->leftJoin('inventory_branch as inventory_branch1','account1.fk_branch_id','=','inventory_branch1.id')
        ->leftJoin('payment_method','account_money_transfer.fk_method_id','=','payment_method.id')
        ->select('account_money_transfer.*','account.account_name','account.account_name as account_name','account1.account_name as account1_name','payment_method.method_name','inventory_branch.branch_name as branch_one','inventory_branch1.branch_name as branch_two')
        ->orderBy('account_money_transfer.id','desc')
        ->paginate(20);
        return view('moneyTransfer.index', compact('allData'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $accounts= AccountSetting::where('account_status',1)->where('fk_branch_id',Auth::user()->fk_branch_id)->pluck('account_name','id');
        $methods= PaymentMethod::where('method_status',1)->pluck('method_name','id');
        $branch=InventoryBranch::where('status',1)->pluck('branch_name','id');
        $ownBranch=InventoryBranch::where('id',Auth::user()->fk_branch_id)->first();
        return view('moneyTransfer.create', compact('accounts','methods','branch','ownBranch'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $input = $request->except('_token');
        $validator = Validator::make($request->all(),[
                'transfer_from' => 'required',
                'transfer_to' => 'required',
                'fk_method_id' => 'required',
                'amount' => 'required'
        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }

        if($input['transfer_from']==$input['transfer_to']){
            return redirect()->back()->with('error','Transfer not pissible to same account!');
        }
        $input['date']=date('Y-m-d',strtotime($input['date']));
        $input['created_by']=Auth::user()->id;
        try {
            AccountMoneyTransfer::create($input); 
            $bug = 0;
            
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect('account-money-transfer')->with('success','Balance Transferred Successfully.');
        }else{
            return redirect()->back()->with('error','Something Error Found! '.$bug1);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
   static public function show($id)
    {
        /*Account Balance*/
        $balance=0;
        $accountInfo = AccountSetting::where('id',$id)->first();
           $purchaseAccount =  InventoryProductAdd::select('inventory_order_id','total_amount','total_paid','date')->orderBy('id','ASC')->where('total_amount','>',0)->select(DB::raw('SUM(total_paid) as total_paid'))->value('total_paid');
           $salesAccount=InventorySalesPaymentHistory::select(DB::raw('SUM(paid) as total_paid'))
                ->where('fk_account_id',$id)
                ->value('total_paid');
           
            $depositAccount=Deposit::select(DB::raw('SUM(deposit.total_paid) as total_paid'))
                ->where('deposit.fk_account_id',$id)
                ->value('total_paid');
            $paymentAccount=Payment::select(DB::raw('SUM(payment.total_paid) as total_paid'))
                ->where('payment.fk_account_id',$id)
                ->first();
            $salaryAccount=EmployeSalarySheet::select(DB::raw('SUM(total_amount) as total_amount'))
                ->where('fk_account_id',$id)
                ->value('total_amount');
            $accountTransfer=AccountMoneyTransfer::select(DB::raw('SUM(amount) as total'))
                ->where('transfer_from',$id)
                ->first();
            $accountRecieve=AccountMoneyTransfer::select(DB::raw('SUM(amount) as total'))
                ->where('transfer_to',$id)
                ->first();
            $total=$accountInfo->current_balance+$depositAccount+$accountRecieve->total+$salesAccount;
            $expense=$paymentAccount->total_paid+$accountTransfer->total+$salaryAccount+$purchaseAccount;
            $balance=$total-$expense;
            return $balance;
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $data =  AccountMoneyTransfer::leftJoin('account','account_money_transfer.transfer_from','=','account.id')
        ->leftJoin('inventory_branch','account.fk_branch_id','=','inventory_branch.id')
        ->leftJoin('account as account1','account_money_transfer.transfer_to','=','account1.id')
        ->leftJoin('inventory_branch as inventory_branch1','account1.fk_branch_id','=','inventory_branch1.id')
        ->leftJoin('payment_method','account_money_transfer.fk_method_id','=','payment_method.id')
        ->select('account_money_transfer.*','account.account_name','account.account_name as account_name','account1.account_name as account1_name','payment_method.method_name','inventory_branch.branch_name as branch_one','inventory_branch1.id as branch_id','inventory_branch1.branch_name as branch_two')
        ->orderBy('account_money_transfer.id','desc')->first();
        $accounts= AccountSetting::where('account_status',1)->where('fk_branch_id',$data->branch_id)->pluck('account_name','id');
        $methods= PaymentMethod::where('method_status',1)->pluck('method_name','id');
        $branch=InventoryBranch::where('status',1)->pluck('branch_name','id');
        $accountBalance=array();
        $accountBalance['one']=$this->show($data->transfer_from);
        $accountBalance['two']=$this->show($data->transfer_to);
        return view('moneyTransfer.edit',compact('data','methods','branch','accounts','accountBalance'));
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
        $input = $request->except('_token','_method','branch_one');
        $validator = Validator::make($request->all(),[
                'transfer_from' => 'required',
                'transfer_to' => 'required',
                'fk_method_id' => 'required',
                'amount' => 'required'
        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }
        if($input['transfer_from']==$input['transfer_to']){
            return redirect()->back()->with('error','Transfer not pissible to same account!');
        }
        $input['date']=date('Y-m-d',strtotime($input['date']));
        $input['updated_by']=Auth::user()->id;
        try {
            AccountMoneyTransfer::where('id',$id)->update($input); 
            $bug = 0;
            
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect('account-money-transfer')->with('success','Balance Transferred Successfully.');
        }else{
            return redirect()->back()->with('error','Something Error Found! '.$bug1);
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
     $data = AccountMoneyTransfer::findOrFail($id);
        
        try {
            $data->delete();
            $bug = 0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect()->back()->with('success','Delete Data Successfully ');
        }elseif($bug == 1451){
                return redirect()->back()->with('error','This Data Used AnyWhere.');
            }else{
            return redirect()->back()->with('error','Something Error Found !, Please try again.'.$bug1);
        } 
    }

    public function loadAccount($id,$i)
    {
        $accounts= AccountSetting::where('account_status',1)->where('fk_branch_id',$id)->pluck('account_name','id');
        return view('moneyTransfer.loadAccount',compact('accounts','i'));
    }
}
