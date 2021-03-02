<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\CompanyInfo;
use App\Models\EmailConfig;
use App\Models\TermsCondition;
use App\Models\Payment;
use App\Models\PaymentCostItem;
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
class ClientWiseDuePaymentController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $getDuePayment = PaymentCostItem::
        leftJoin('payment','payment_cost_item.fk_payment_id','=','payment.id')
        ->leftJoin('clients','payment.fk_client_id','=','clients.id')
        ->leftJoin('account','payment.fk_account_id','=','account.id')
        ->leftJoin('payment_method','payment.fk_method_id','=','payment_method.id')
        ->whereColumn('payment_cost_item.total_amount', '>', 'payment_cost_item.paid_amount')
        ->select('payment_cost_item.*','account.account_name','clients.client_name','payment_method.method_name','payment.invoice_no','payment.fk_client_id','payment.t_date')
        //->groupBy('payment_cost_item.fk_payment_id')
        ->groupBy('clients.client_name')
        ->get();


        return view('payment.viewClientWiseDuePayments', compact('getDuePayment'));
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
        $getClientData = Clients::findOrFail($id);

        $getPaymentData = Payment::where('payment.fk_client_id',$id)
        ->get();

        $getInvoiceData = PaymentCostItem::
        leftJoin('payment','payment_cost_item.fk_payment_id','=','payment.id')
        ->leftJoin('clients','payment.fk_client_id','=','clients.id')
        ->leftJoin('sub_category','payment_cost_item.fk_sub_category_id','=','sub_category.id')
        ->leftJoin('account','payment.fk_account_id','=','account.id')
        ->leftJoin('payment_method','payment.fk_method_id','=','payment_method.id')
        ->where('payment.fk_client_id','=',$id)
        ->whereColumn('total_amount', '>', 'paid_amount')
        ->select('payment_cost_item.description','payment_cost_item.total_amount','payment_cost_item.paid_amount','sub_category.sub_category_name')
        ->get();


        //$getPaymentItemData = PaymentCostItem::where('payment_cost_item.fk_payment_id',$id)->get();
        $getDuePaymentData = PaymentCostItem::
        leftJoin('sub_category','payment_cost_item.fk_sub_category_id','=','sub_category.id')
        ->where('fk_payment_id',$id)
        ->whereColumn('total_amount', '>', 'paid_amount')
        ->select('payment_cost_item.*','sub_category.sub_category_name')
        ->get();

        //return $getDuePayment;
        $totalAmount = PaymentCostItem::
            leftJoin('payment','payment_cost_item.fk_payment_id','=','payment.id')
            ->where('fk_client_id',$id)
            ->whereColumn('total_amount', '>', 'paid_amount')
            ->selectRaw('sum(total_amount) as total_amount')
            ->first('total_amount');
            //return $totalAmount;
        $totalPaid = PaymentCostItem::
            leftJoin('payment','payment_cost_item.fk_payment_id','=','payment.id')
            ->where('fk_client_id',$id)
            ->whereColumn('total_amount', '>', 'paid_amount')
            ->selectRaw('sum(paid_amount) as total_paid')
            ->first('total_paid');
        $companyInfo = CompanyInfo::first();
        $emailConfig = EmailConfig::first();
        $condition = TermsCondition::first();
        return view('common.client_wise_invoice_view', compact('getClientData','getPaymentData','totalPaid','getInvoiceData','totalAmount','companyInfo','emailConfig','condition','id'));
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

        $getPaymentData = Payment::where('payment.fk_client_id',$id)
        ->get();

        $getInvoiceData = PaymentCostItem::
        leftJoin('payment','payment_cost_item.fk_payment_id','=','payment.id')
        ->leftJoin('clients','payment.fk_client_id','=','clients.id')
        ->leftJoin('sub_category','payment_cost_item.fk_sub_category_id','=','sub_category.id')
        ->leftJoin('account','payment.fk_account_id','=','account.id')
        ->leftJoin('payment_method','payment.fk_method_id','=','payment_method.id')
        ->where('payment.fk_client_id','=',$id)
        ->whereColumn('total_amount', '>', 'paid_amount')
        ->select('payment_cost_item.id','payment_cost_item.description','payment_cost_item.total_amount','payment_cost_item.paid_amount','sub_category.sub_category_name')
        ->get();


        //$getPaymentItemData = PaymentCostItem::where('payment_cost_item.fk_payment_id',$id)->get();
        $getDuePaymentData = PaymentCostItem::
        leftJoin('sub_category','payment_cost_item.fk_sub_category_id','=','sub_category.id')
        ->where('fk_payment_id',$id)
        ->whereColumn('total_amount', '>', 'paid_amount')
        ->select('payment_cost_item.*','sub_category.sub_category_name')
        ->get();

        //return $getDuePayment;
        $totalAmount = PaymentCostItem::
            leftJoin('payment','payment_cost_item.fk_payment_id','=','payment.id')
            ->where('fk_client_id',$id)
            ->whereColumn('total_amount', '>', 'paid_amount')
            ->selectRaw('sum(total_amount) as total_amount')
            ->first('total_amount');
            //return $totalAmount;
        $totalPaid = PaymentCostItem::
            leftJoin('payment','payment_cost_item.fk_payment_id','=','payment.id')
            ->where('fk_client_id',$id)
            ->whereColumn('total_amount', '>', 'paid_amount')
            ->selectRaw('sum(paid_amount) as total_paid')
            ->first('total_paid');
        $companyInfo = CompanyInfo::first();
        $emailConfig = EmailConfig::first();
        $condition = TermsCondition::first();
        return view('payment.singleClientWiseDuePaymentEdit', compact('getClientData','getPaymentData','totalPaid','getInvoiceData','totalAmount','companyInfo','emailConfig','condition','id','getAccountData','getMethodData')); 
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
            $paymentExistsId = sizeof($input['payment_item_old_id']);
            for ($i=0; $i < $paymentExistsId; $i++) { 
                $paymentItemId = $input['payment_item_old_id'][$i];
                $existsPaid = PaymentCostItem::findOrFail($paymentItemId);
                $newPaidAmount = intval($existsPaid->paid_amount)+intval($input['paid'][$i]);
                $paid_Amount = PaymentCostItem::updatePaidAmount($paymentItemId,$newPaidAmount);
                //return $newPaidAmount;
            }

            $getInvoiceData = PaymentCostItem::
            leftJoin('sub_category','payment_cost_item.fk_sub_category_id','=','sub_category.id')
            ->whereIn('payment_cost_item.id',$input['payment_item_old_id'])
            ->select('payment_cost_item.*','sub_category.sub_category_name')
            ->get();
            $totalAmount = PaymentCostItem::
            whereIn('payment_cost_item.id',$input['payment_item_old_id'])
            ->selectRaw('sum(total_amount) as total_amount')
            ->first('total_amount');

            $totalPaid = PaymentCostItem::
            whereIn('payment_cost_item.id',$input['payment_item_old_id'])
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
            //return redirect("client-wise-due-payment/$id")->with('success','Updated Successfully.');
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

        $getPaymentData = Payment::where('payment.fk_client_id',$id)
        ->get();

        $getInvoiceData = PaymentCostItem::
        leftJoin('payment','payment_cost_item.fk_payment_id','=','payment.id')
        ->leftJoin('clients','payment.fk_client_id','=','clients.id')
        ->leftJoin('sub_category','payment_cost_item.fk_sub_category_id','=','sub_category.id')
        ->leftJoin('account','payment.fk_account_id','=','account.id')
        ->leftJoin('payment_method','payment.fk_method_id','=','payment_method.id')
        ->where('payment.fk_client_id','=',$id)
        ->whereColumn('total_amount', '>', 'paid_amount')
        ->select('payment_cost_item.description','payment_cost_item.total_amount','payment_cost_item.paid_amount','sub_category.sub_category_name')
        ->get();
        


        $totalAmount = PaymentCostItem::
            leftJoin('payment','payment_cost_item.fk_payment_id','=','payment.id')
            ->where('fk_client_id',$id)
            ->whereColumn('total_amount', '>', 'paid_amount')
            ->selectRaw('sum(total_amount) as total_amount')
            ->first('total_amount');
            //return $totalAmount;
        $totalPaid = PaymentCostItem::
            leftJoin('payment','payment_cost_item.fk_payment_id','=','payment.id')
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

        $getPaymentData = Payment::where('payment.fk_client_id',$id)
        ->get();

        $getInvoiceData = PaymentCostItem::
        leftJoin('payment','payment_cost_item.fk_payment_id','=','payment.id')
        ->leftJoin('clients','payment.fk_client_id','=','clients.id')
        ->leftJoin('sub_category','payment_cost_item.fk_sub_category_id','=','sub_category.id')
        ->leftJoin('account','payment.fk_account_id','=','account.id')
        ->leftJoin('payment_method','payment.fk_method_id','=','payment_method.id')
        ->where('payment.fk_client_id','=',$id)
        ->whereColumn('total_amount', '>', 'paid_amount')
        ->select('payment_cost_item.description','payment_cost_item.total_amount','payment_cost_item.paid_amount','sub_category.sub_category_name')
        ->get();
        


        $totalAmount = PaymentCostItem::
            leftJoin('payment','payment_cost_item.fk_payment_id','=','payment.id')
            ->where('fk_client_id',$id)
            ->whereColumn('total_amount', '>', 'paid_amount')
            ->selectRaw('sum(total_amount) as total_amount')
            ->first('total_amount');
            //return $totalAmount;
        $totalPaid = PaymentCostItem::
            leftJoin('payment','payment_cost_item.fk_payment_id','=','payment.id')
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
