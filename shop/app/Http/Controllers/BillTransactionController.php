<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;

use App\Models\BillTransaction;
use App\Models\Deposit;
use App\Models\Payment;
use App\Models\AccountSetting;
use App\Models\PaymentMethod;
use DB;
use Validator;

class BillTransactionController extends Controller
{
    /**
     * Display a listing of the resource about us page.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $getAccount= AccountSetting::orderBy('id','asc')->get();
        $getMethodData= PaymentMethod::get();
         $billTransaction =  BillTransaction::
        join('account','bill_transaction.from_account','=','account.id')
        ->join('account as account1','bill_transaction.to_account','=','account1.id')
        ->join('payment_method','bill_transaction.method','=','payment_method.id')
        ->select('bill_transaction.*','account.account_name','account.id as account_id','account1.account_name as account1_name','account1.id as account1_id','payment_method.method_name','payment_method.id as method_id')
        ->orderBy('bill_transaction.id','desc')
        ->get();
       
        return view('bill_transaction.viewBill', compact('getAccount','getMethodData','billTransaction'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $getAccount= AccountSetting::where('account_status',1)->orderBy('id','asc')->get();
        $getMethodData= PaymentMethod::where('method_status',1)->get();
        $billTransaction = BillTransaction::all();
        return view('bill_transaction.index', compact('billTransaction','getAccount','getMethodData'));
    }

    /**
     * Store a newly created resource in storage about us page.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(),[
                'from_account' => 'required',
                'to_account' => 'required'
        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }

        $input = $request->all();
        if($input['from_account']==$input['to_account']){
            return redirect()->back()->with('error','Transfer not pissible to same account!');
        }
        try {
            BillTransaction::create($input); 
            
            $bug = 0;
            
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect('bill/create')->with('success','Balance Transferred Successfully.');
        }else{
            return redirect('bill/create')->with('error','Something Error Found !, Please try again.'.$bug1);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $balance=0;
            $accountStarting=AccountSetting::where('id',$id)->value('current_balance');
            $depositAccount=Deposit::select(DB::raw('SUM(deposit.total_paid) as total_paid'))
                ->where('deposit.fk_account_id',$id)
                ->first();
            $paymentAccount=Payment::select(DB::raw('SUM(payment.total_paid) as total_paid'))
                ->where('payment.fk_account_id',$id)
                ->first();
            $accountTransfer=BillTransaction::select(DB::raw('SUM(amount) as total'))
                ->where('from_account',$id)
                ->first();
            $accountRecieve=BillTransaction::select(DB::raw('SUM(amount) as total'))
                ->where('to_account',$id)
                ->first();
            $total=$accountStarting+$depositAccount->total_paid+$accountRecieve->total;
            $expense=$paymentAccount->total_paid+$accountTransfer->total;
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
        //
    }

    /**
     * Update the specified resource in storage contact us page.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {   

        $billTransaction = BillTransaction::findOrFail($id); 
        $validator = Validator::make($request->all(),[
                'amount' => 'required',
                'description' => 'required'

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }

        $input = $request->all();
        $input['updated_by']=1;

        try {
            $billTransaction->update($input);
            $bug = 0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect('bill')->with('success','Bill Transaction Updated Successfully.');
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
         $billTransaction = BillTransaction::findOrFail($id);
        
        try {
            $billTransaction->delete();
            $bug = 0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect('bill')->with('success','Delete Data Successfully ');
        }elseif($bug == 1451){
                return redirect('bill')->with('error','This Data Used AnyWhere.');
            }else{
            return redirect('bill')->with('error','Something Error Found !, Please try again.'.$bug1);
        } 
    }

    
}
