<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\CompanyInfo;
use App\Models\EmailConfig;
use App\Models\TermsCondition;
use App\Models\Deposit;
use App\Models\DepositCostItem;
use App\Models\SubCategories;
use App\Models\Clients;
use App\Models\ProjectItem;
use App\Models\AccountSetting;
use App\Models\PaymentMethod;
use DB;
use Validator;
use response;
use Mail;
use PDF;

class ClientWiseDueDepositController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        
        $getDueDeposit = DepositCostItem::
        leftJoin('deposit','deposit_cost_item.fk_deposit_id','=','deposit.id')
        ->leftJoin('clients','deposit.fk_client_id','=','clients.id')
        ->leftJoin('account','deposit.fk_account_id','=','account.id')
        ->leftJoin('payment_method','deposit.fk_method_id','=','payment_method.id')
        ->whereColumn('deposit_cost_item.total_amount', '>', 'deposit_cost_item.paid_amount')
        ->select('deposit_cost_item.*','account.account_name','clients.client_name','payment_method.method_name','deposit.invoice_no','deposit.fk_client_id','deposit.t_date')
        //->groupBy('deposit_cost_item.fk_deposit_id')
        ->groupBy('clients.client_name')
        ->get();
        //return $getDueDeposit;

        return view('deposit.viewClientWiseDueDeposits', compact('getDueDeposit'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        
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
        $getClientData = Clients::findOrFail($id);

        $getDepositData = Deposit::where('deposit.fk_client_id',$id)
        ->get();

        $getInvoiceData = DepositCostItem::
        leftJoin('deposit','deposit_cost_item.fk_deposit_id','=','deposit.id')
        ->leftJoin('clients','deposit.fk_client_id','=','clients.id')
        ->leftJoin('sub_category','deposit_cost_item.fk_sub_category_id','=','sub_category.id')
        ->leftJoin('account','deposit.fk_account_id','=','account.id')
        ->leftJoin('payment_method','deposit.fk_method_id','=','payment_method.id')
        ->where('deposit.fk_client_id','=',$id)
        ->whereColumn('total_amount', '>', 'paid_amount')
        ->select('deposit_cost_item.description','deposit_cost_item.total_amount','deposit_cost_item.paid_amount','sub_category.sub_category_name')
        ->get();


        //$getDepositItemData = DepositCostItem::where('deposit_cost_item.fk_deposit_id',$id)->get();
        $getDueDepositData = DepositCostItem::
        leftJoin('sub_category','deposit_cost_item.fk_sub_category_id','=','sub_category.id')
        ->where('fk_deposit_id',$id)
        ->whereColumn('total_amount', '>', 'paid_amount')
        ->select('deposit_cost_item.*','sub_category.sub_category_name')
        ->get();

        //return $getDueDeposit;
        $totalAmount = DepositCostItem::
            leftJoin('deposit','deposit_cost_item.fk_deposit_id','=','deposit.id')
            ->where('fk_client_id',$id)
            ->whereColumn('total_amount', '>', 'paid_amount')
            ->selectRaw('sum(total_amount) as total_amount')
            ->first('total_amount');
            //return $totalAmount;
        $totalPaid = DepositCostItem::
            leftJoin('deposit','deposit_cost_item.fk_deposit_id','=','deposit.id')
            ->where('fk_client_id',$id)
            ->whereColumn('total_amount', '>', 'paid_amount')
            ->selectRaw('sum(paid_amount) as total_paid')
            ->first('total_paid');
        $companyInfo = CompanyInfo::first();
        $emailConfig = EmailConfig::first();
        $condition = TermsCondition::first();
        return view('common.client_wise_invoice_view', compact('getClientData','getDepositData','totalPaid','getInvoiceData','totalAmount','companyInfo','emailConfig','condition','id'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $getAccountData = AccountSetting::all();
        $getMethodData = PaymentMethod::all();
        $getClientData = Clients::findOrFail($id);

        $getDepositData = Deposit::where('deposit.fk_client_id',$id)
        ->get();

        $getInvoiceData = DepositCostItem::
        leftJoin('deposit','deposit_cost_item.fk_deposit_id','=','deposit.id')
        ->leftJoin('clients','deposit.fk_client_id','=','clients.id')
        ->leftJoin('sub_category','deposit_cost_item.fk_sub_category_id','=','sub_category.id')
        ->leftJoin('account','deposit.fk_account_id','=','account.id')
        ->leftJoin('payment_method','deposit.fk_method_id','=','payment_method.id')
        ->where('deposit.fk_client_id','=',$id)
        ->whereColumn('total_amount', '>', 'paid_amount')
        ->select('deposit_cost_item.id','deposit_cost_item.description','deposit_cost_item.total_amount','deposit_cost_item.paid_amount','sub_category.sub_category_name')
        ->get();


        //$getDepositItemData = DepositCostItem::where('deposit_cost_item.fk_deposit_id',$id)->get();
        $getDueDepositData = DepositCostItem::
        leftJoin('sub_category','deposit_cost_item.fk_sub_category_id','=','sub_category.id')
        ->where('fk_deposit_id',$id)
        ->whereColumn('total_amount', '>', 'paid_amount')
        ->select('deposit_cost_item.*','sub_category.sub_category_name')
        ->get();

        //return $getDueDeposit;
        $totalAmount = DepositCostItem::
            leftJoin('deposit','deposit_cost_item.fk_deposit_id','=','deposit.id')
            ->where('fk_client_id',$id)
            ->whereColumn('total_amount', '>', 'paid_amount')
            ->selectRaw('sum(total_amount) as total_amount')
            ->first('total_amount');
            //return $totalAmount;
        $totalPaid = DepositCostItem::
            leftJoin('deposit','deposit_cost_item.fk_deposit_id','=','deposit.id')
            ->where('fk_client_id',$id)
            ->whereColumn('total_amount', '>', 'paid_amount')
            ->selectRaw('sum(paid_amount) as total_paid')
            ->first('total_paid');
        $companyInfo = CompanyInfo::first();
        $emailConfig = EmailConfig::first();
        $condition = TermsCondition::first();
        return view('deposit.singleClientWiseDueDepositEdit', compact('getClientData','getDepositData','totalPaid','getInvoiceData','totalAmount','companyInfo','emailConfig','condition','id','getAccountData','getMethodData'));   
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
        $getClientData = Clients::findOrFail($id);
        $validator = Validator::make($request->all(),[
            'fk_client_id' => 'required'
        ]);

        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }

        $input = $request->all();

        try {
            //print_r($input['paid']);exit;
            $depositExistsId = sizeof($input['deposit_item_old_id']);
            for ($i=0; $i < $depositExistsId; $i++) { 
                $depositItemId = $input['deposit_item_old_id'][$i];
                $existsPaid = DepositCostItem::findOrFail($depositItemId);
                $newPaidAmount = intval($existsPaid->paid_amount)+intval($input['paid'][$i]);
                $paid_Amount = DepositCostItem::updatePaidAmount($depositItemId,$newPaidAmount);
                //return $newPaidAmount;
            }
            //
            // for ($i=0; $i < $depositExistsId; $i++) { 
            //     $depositItemId = $input['deposit_item_old_id'][$i];
            //     $getInvoiceData[] = DepositCostItem::findOrFail($depositItemId);
            // }
            $getInvoiceData = DepositCostItem::
            leftJoin('sub_category','deposit_cost_item.fk_sub_category_id','=','sub_category.id')
            ->whereIn('deposit_cost_item.id',$input['deposit_item_old_id'])
            ->select('deposit_cost_item.*','sub_category.sub_category_name')
            ->get();
            $totalAmount = DepositCostItem::
            whereIn('deposit_cost_item.id',$input['deposit_item_old_id'])
            ->selectRaw('sum(total_amount) as total_amount')
            ->first('total_amount');

            $totalPaid = DepositCostItem::
            whereIn('deposit_cost_item.id',$input['deposit_item_old_id'])
            ->selectRaw('sum(paid_amount) as total_paid')
            ->first('total_paid');
            $companyInfo = CompanyInfo::first();
            $emailConfig = EmailConfig::first();
            $condition = TermsCondition::first();

            $bug = 0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
       
        if($bug == 0){
            //return redirect("client-wise-due-deposit/$id")->with('success','Updated Successfully.');
            return view('common.client_wise_invoice_view', compact('getClientData','totalPaid','getInvoiceData','totalAmount','companyInfo','emailConfig','condition','id'));
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

    public function publicInvoice($id)
    {
        $getClientData = Clients::findOrFail($id);

        $getDepositData = Deposit::where('deposit.fk_client_id',$id)
        ->get();

        $getInvoiceData = DepositCostItem::
        leftJoin('deposit','deposit_cost_item.fk_deposit_id','=','deposit.id')
        ->leftJoin('clients','deposit.fk_client_id','=','clients.id')
        ->leftJoin('sub_category','deposit_cost_item.fk_sub_category_id','=','sub_category.id')
        ->leftJoin('account','deposit.fk_account_id','=','account.id')
        ->leftJoin('payment_method','deposit.fk_method_id','=','payment_method.id')
        ->where('deposit.fk_client_id','=',$id)
        ->whereColumn('total_amount', '>', 'paid_amount')
        ->select('deposit_cost_item.description','deposit_cost_item.total_amount','deposit_cost_item.paid_amount','sub_category.sub_category_name')
        ->get();
        


        $totalAmount = DepositCostItem::
            leftJoin('deposit','deposit_cost_item.fk_deposit_id','=','deposit.id')
            ->where('fk_client_id',$id)
            ->whereColumn('total_amount', '>', 'paid_amount')
            ->selectRaw('sum(total_amount) as total_amount')
            ->first('total_amount');
            //return $totalAmount;
        $totalPaid = DepositCostItem::
            leftJoin('deposit','deposit_cost_item.fk_deposit_id','=','deposit.id')
            ->where('fk_client_id',$id)
            ->whereColumn('total_amount', '>', 'paid_amount')
            ->selectRaw('sum(paid_amount) as total_paid')
            ->first('total_paid');

        $data = [
        'getInvoiceData' => $getInvoiceData,
        'getClientData' => $getClientData,
        'totalAmount' => $totalAmount,
        'totalPaid' => $totalPaid
        ];

        $companyInfo = CompanyInfo::first();
        $emailConfig = EmailConfig::first();
        $condition = TermsCondition::first();
        //return $data;
        return view('common.invoice_client_wise_public_view', compact('data','companyInfo','emailConfig','condition'));

    }
    

    public function sendEmail(Request $request, $id)
    {
        $validator = Validator::make($request->all(),[
                'to' => 'required'
        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }

        $input = $request->all();


        $getClientData = Clients::findOrFail($id);

        $getDepositData = Deposit::where('deposit.fk_client_id',$id)
        ->get();

        $getInvoiceData = DepositCostItem::
        leftJoin('deposit','deposit_cost_item.fk_deposit_id','=','deposit.id')
        ->leftJoin('clients','deposit.fk_client_id','=','clients.id')
        ->leftJoin('sub_category','deposit_cost_item.fk_sub_category_id','=','sub_category.id')
        ->leftJoin('account','deposit.fk_account_id','=','account.id')
        ->leftJoin('payment_method','deposit.fk_method_id','=','payment_method.id')
        ->where('deposit.fk_client_id','=',$id)
        ->whereColumn('total_amount', '>', 'paid_amount')
        ->select('deposit_cost_item.description','deposit_cost_item.total_amount','deposit_cost_item.paid_amount','sub_category.sub_category_name')
        ->get();
        


        $totalAmount = DepositCostItem::
            leftJoin('deposit','deposit_cost_item.fk_deposit_id','=','deposit.id')
            ->where('fk_client_id',$id)
            ->whereColumn('total_amount', '>', 'paid_amount')
            ->selectRaw('sum(total_amount) as total_amount')
            ->first('total_amount');
            //return $totalAmount;
        $totalPaid = DepositCostItem::
            leftJoin('deposit','deposit_cost_item.fk_deposit_id','=','deposit.id')
            ->where('fk_client_id',$id)
            ->whereColumn('total_amount', '>', 'paid_amount')
            ->selectRaw('sum(paid_amount) as total_paid')
            ->first('total_paid');

        $data = [
        'getInvoiceData' => $getInvoiceData,
        'getClientData' => $getClientData,
        'totalAmount' => $totalAmount,
        'totalPaid' => $totalPaid
        ];
        
        $companyInfo = CompanyInfo::first();
        $emailConfig = EmailConfig::first();
        $condition = TermsCondition::first();

        $pdf = PDF::loadView('common.invoice_client_wise_public_view', compact('data','companyInfo','emailConfig','condition'));
        Mail::send('common.mail_body', array('body' => $input['body']), function($message) use ($input, $data, $pdf, $id)
        {
        $message->from($input['from'], $input['from']);
        if(!empty($input['cc'])){

            $message->cc($input['cc'], $input['cc']);
        }

        $message->to($input['to'])->subject($input['subject']);
        $message->attachData($pdf->output(), "INV_CLIENT_$id.pdf");
        });

        try {
            

            $bug=0;
            
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2]; 
        }
        if($bug == 0){
            return redirect()->back()->with('success','Send Successfully.');
        }else{
            return redirect()->back()->with('error','Something Error Found !, Please try again.'.$bug1);
        }
    }
}
