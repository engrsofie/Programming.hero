<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;

use App\Models\CompanyInfo;
use App\Models\EmailConfig;
use App\Models\TermsCondition;
use App\Models\Payment;
use App\Models\PaymentCostItem;
use App\Models\SubCategories;
use App\Models\Clients;
use App\Models\ProjectItem;
use App\Models\PaymentHistory;
use App\Models\AccountSetting;
use App\Models\PaymentMethod;
use DB;
use Validator;
use response;
use Mail;
use PDF;
use Auth;

class PaymentController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $query = Payment::
        leftJoin('clients','payment.fk_client_id','=','clients.id')
        ->leftJoin('inventory_branch','clients.fk_branch_id','=','inventory_branch.id')
        ->leftJoin('account','payment.fk_account_id','=','account.id')
        ->leftJoin('payment_method','payment.fk_method_id','=','payment_method.id')
        ->select('payment.*','clients.client_name','clients.mobile_no','clients.address','clients.email_id','branch_name')
        ->orderBy('payment.id','desc');
        if(Auth::user()->isRole('administrator')){
            $getPaymentData=$query->get();
        }else{
            $getPaymentData=$query->where(['payment.fk_branch_id'=>Auth::user()->fk_branch_id,'payment.fk_company_id'=>Auth::user()->fk_company_id])->get();
        }

        return view('payment.viewPayments', compact('getPaymentData'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $subCategories = SubCategories::where('sub_category_status',1)->get();
        $getClientData = Clients::where('client_status',1)->get();
        $getAccountData = AccountSetting::where('account_status',1)->get();
        $getMethodData = PaymentMethod::where('method_status',1)->get();
        return view('payment.index', compact('subCategories','getClientData','getAccountData','getMethodData'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(),[
                'client_name' => 'required',
                'fk_method_id' => 'required',
                't_date' => 'required'

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }

        $input = $request->all();
        $lastId=PaymentHistory::max('invoice_id');
        if($lastId!=null){
            $input['invoice_no']=$lastId+1;
        }else{
            $input['invoice_no'] = date('ymd').'1';
        }
        $input['amount'] = $input['total_amount'];
        $input['total_paid'] = $input['paid_amount'];
        $input['fk_branch_id']=Auth::user()->fk_branch_id;
        $input['fk_company_id']=Auth::user()->fk_company_id;
        DB::beginTransaction();
        try {
            $input['fk_client_id']=Clients::createNew($input['client_name']);
                if($input['fk_client_id']==null){
                    $input['fk_client_id']=$input['clientId'];
                }
            $payment_id = Payment::create($input)->id; 
            for ($i=0; $i < sizeof($input['fk_sub_category_id']); $i++) { 
                $sub_category_id = $input['fk_sub_category_id'][$i];
                $description = $input['description'][$i];
                $total_amount = $input['total'][$i];
                $paid_amount = $input['paid'][$i];
                $createPaymentCost = PaymentCostItem::createPaymentCost($payment_id,$sub_category_id,$description,$total_amount,$paid_amount);
                PaymentHistory::create([
                    'fk_payment_item_id'=>$createPaymentCost,
                    'created_by'=>$input['created_by'],
                    'invoice_id'=>$input['invoice_no'],
                    'last_due'=>$total_amount,
                    'paid'=>$paid_amount,
                    'payment_date'=>$input['t_date'],
                    ]);
            }
            $bug = 0;
            
        DB::commit();
         } catch (\Exception $e) {
            DB::rollback();
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
        
        if($bug == 0){
            return redirect("payment/".$input['invoice_no'])->with('success','New Payment Created Successfully.');
        }else{
            return redirect()->back()->with('error','Something Error Found !, Please try again.'.$bug1);
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
        $allTask=PaymentHistory::leftJoin('payment_cost_item','payment_history.fk_payment_item_id','payment_cost_item.id')
        ->leftJoin('sub_category','payment_cost_item.fk_sub_category_id','=','sub_category.id')
        ->select('payment_history.*','payment_cost_item.fk_payment_id','payment_cost_item.total_amount','payment_cost_item.paid_amount','payment_cost_item.description','sub_category.sub_category_name')
        ->where('payment_history.invoice_id',$id)
        ->get();
        if(count($allTask)==0){
            return redirect()->back();
        }
        $paymentId=$allTask[0]->fk_payment_id;
        $singleHistory=PaymentHistory::leftJoin('payment_cost_item','payment_history.fk_payment_item_id','payment_cost_item.id')
        ->select('payment_history.invoice_id','payment_history.created_by','payment_history.payment_date','payment_cost_item.fk_payment_id')
        ->where('payment_history.invoice_id',$id)->orderBy('payment_history.id','desc')->first();
        $paymentId=$singleHistory->fk_payment_id;
        $getInvoiceData = Payment::
        leftJoin('clients','payment.fk_client_id','=','clients.id')
        ->leftJoin('account','payment.fk_account_id','=','account.id')
        ->leftJoin('payment_method','payment.fk_method_id','=','payment_method.id')
        ->select('payment.*','account.account_name','clients.client_name','clients.mobile_no','clients.address','clients.email_id','payment_method.method_name')
        ->where('payment.id',$paymentId)
        ->first();
        

        $getInvoiceItemData = PaymentCostItem::
        leftJoin('sub_category','payment_cost_item.fk_sub_category_id','=','sub_category.id')
        ->where('payment_cost_item.fk_payment_id',$paymentId)
        ->select('payment_cost_item.*','sub_category.sub_category_name')
        ->get();

        $totalAmount = PaymentCostItem::
            where('fk_payment_id',$paymentId)
            ->selectRaw('sum(total_amount) as total_amount')
            ->first('total_amount');

        $totalPaid = PaymentCostItem::
            where('fk_payment_id',$id)
            ->selectRaw('sum(paid_amount) as total_paid')
            ->first('total_paid');

        $companyInfo = CompanyInfo::first();
        $emailConfig = EmailConfig::first();
        $condition = TermsCondition::first();
        
        return view('payment.invoice', compact('getInvoiceData','getInvoiceItemData','totalAmount','totalPaid','companyInfo','emailConfig','condition','allTask','singleHistory'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $subCategories = SubCategories::all();
        $getClientData = Clients::all();
        $getAccountData = AccountSetting::all();
        $getMethodData = PaymentMethod::all();

        $getPaymentData = Payment::where('payment.id',$id)
        ->first();

        $getPaymentItemData = PaymentCostItem::where('payment_cost_item.fk_payment_id',$id)
            ->get();

        $totalAmount = PaymentCostItem::
            where('fk_payment_id',$id)
            ->selectRaw('sum(total_amount) as total_amount')
            ->first('total_amount');

        $totalPaid = PaymentCostItem::
            where('fk_payment_id',$id)
            ->selectRaw('sum(paid_amount) as total_paid')
            ->first('total_paid');
        //return $totalAmount;


        return view('payment.singlePaymentEdit', compact('subCategories','getClientData','getAccountData','getMethodData','getPaymentData','getPaymentItemData','totalAmount','totalPaid'));

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
        $getPaymentData = Payment::findOrFail($id);
        $validator = Validator::make($request->all(),[
            'fk_client_id' => 'required',
            'fk_method_id' => 'required',
            't_date' => 'required'
        ]);

        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }

        $input = $request->all();


        try {
            $getPaymentData->update($input);

            //payment item updated
            $itemOldDataCount = sizeof($input['fk_sub_category_id']);
                for ($i=0; $i <$itemOldDataCount ; $i++) {
                    $paymentId = $input['fk_payment_id'];
                    $paymentItemId = $input['payment_item_old_id'][$i];
                    $fk_sub_category_id = $input['fk_sub_category_id'][$i];
                    $description = $input['description'][$i];
                    $totalAmount = $input['total'][$i];
                    $totalPaid = $input['paid'][$i];

                    $paymentItemUpdated = PaymentCostItem::updatedPaymentItem($paymentId,$paymentItemId,$fk_sub_category_id,$description,$totalAmount,$totalPaid);
                }

                //old payment item delete on click delete button
                if(isset($input['deleteItem'])){
                    $itemDeleteDataCount = sizeof($input['deleteItem']);
                    for ($i=0; $i < $itemDeleteDataCount; $i++) {
                        $itemSetDetele[]=$input['deleteItem'][$i];
                        $itemId = $itemSetDetele[$i];
                        $itemData[] = PaymentCostItem::findOrFail($itemId);
                        //return $itemData;

                    }

                    $itemDeleted = PaymentCostItem::deleteItemId($itemData);


                }

                //new payment item created
                if(isset($input['fk_sub_category_id_new'])){

                    $paymentItemNewDataCount = sizeof($input['fk_sub_category_id_new']);
                    for ($i=0; $i <$paymentItemNewDataCount ; $i++) {
                        $paymentId = $input['fk_payment_id'];
                        $sub_category_id = $input['fk_sub_category_id_new'][$i];
                        $description = $input['description_new'][$i];
                        $total_amount = $input['total_new'][$i];
                        $paid_amount = $input['paid_new'][$i];

                        $paymentItemCreated = PaymentCostItem::createPaymentCost($paymentId,$sub_category_id,$description,$total_amount,$paid_amount);
                    }
                }


            $bug = 0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
       
        if($bug == 0){
            return redirect()->back()->with('success','Updated Successfully.');
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
        $getPaymentData = Payment::findOrFail($id);
        try {
           
            $items = PaymentCostItem::where('fk_payment_id',$id)->get();
            foreach($items as $item){
                PaymentHistory::where('fk_payment_item_id',$item->id)->delete(); 
            }
            PaymentCostItem::where('fk_payment_id',$id)->delete();
            $getPaymentData->delete();
            $bug=0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
       
        if($bug == 0){
            return redirect()->back()->with('success','Payment Deleted Successfully.');
        }else{
            return redirect()->back()->with('error','Something Error Found !, Please try again.'.$bug1);
        }

    }

    public function publicInvoice($id)
    {
        $getInvoiceData = Payment::
        leftJoin('clients','payment.fk_client_id','=','clients.id')
        ->leftJoin('account','payment.fk_account_id','=','account.id')
        ->leftJoin('payment_method','payment.fk_method_id','=','payment_method.id')
        ->select('payment.*','account.account_name','clients.client_name','clients.mobile_no','clients.address','clients.email_id','payment_method.method_name')
        ->where('payment.id',$id)
        ->first();
        

        $getInvoiceItemData = PaymentCostItem::
        leftJoin('sub_category','payment_cost_item.fk_sub_category_id','=','sub_category.id')
        ->where('payment_cost_item.fk_payment_id',$id)
        ->select('payment_cost_item.*','sub_category.sub_category_name')
        ->get();

        $totalAmount = PaymentCostItem::
            where('fk_payment_id',$id)
            ->selectRaw('sum(total_amount) as total_amount')
            ->first('total_amount');

        $totalPaid = PaymentCostItem::
            where('fk_payment_id',$id)
            ->selectRaw('sum(paid_amount) as total_paid')
            ->first('total_paid');
        


        $data = [
        'getInvoiceData' => $getInvoiceData,
        'getInvoiceItemData' => $getInvoiceItemData,
        'totalAmount' => $totalAmount,
        'totalPaid' => $totalPaid
        ];
        //return $data;

        $companyInfo = CompanyInfo::first();
        $emailConfig = EmailConfig::first();
        $condition = TermsCondition::first();
        
        return view('common.invoice_public_view', compact('data','companyInfo','emailConfig','condition'));

    }
    public function generatePDF($id)
    {
        //$id = $request->get('generate_id');
        $getInvoiceData = Payment::
        leftJoin('clients','payment.fk_client_id','=','clients.id')
        ->leftJoin('account','payment.fk_account_id','=','account.id')
        ->leftJoin('payment_method','payment.fk_method_id','=','payment_method.id')
        ->select('payment.*','account.account_name','clients.client_name','clients.mobile_no','clients.address','clients.email_id','payment_method.method_name')
        ->where('payment.id',$id)
        ->first();
        

        $getInvoiceItemData = PaymentCostItem::
        leftJoin('sub_category','payment_cost_item.fk_sub_category_id','=','sub_category.id')
        ->where('payment_cost_item.fk_payment_id',$id)
        ->select('payment_cost_item.*','sub_category.sub_category_name')
        ->get();

        $totalAmount = PaymentCostItem::
            where('fk_payment_id',$id)
            ->selectRaw('sum(total_amount) as total_amount')
            ->first('total_amount');

        $totalPaid = PaymentCostItem::
            where('fk_payment_id',$id)
            ->selectRaw('sum(paid_amount) as total_paid')
            ->first('total_paid');

        $data = [
        'getInvoiceData' => $getInvoiceData,
        'getInvoiceItemData' => $getInvoiceItemData,
        'totalAmount' => $totalAmount,
        'totalPaid' => $totalPaid
        ];
        //return $data;
        //return view('common.invoice_public_view', compact('data'));

        $companyInfo = CompanyInfo::first();
        $emailConfig = EmailConfig::first();
        $condition = TermsCondition::first();
        
        $pdf = \PDF::loadView('common.invoice_public_view', compact('data','companyInfo','emailConfig','condition'));
        return $pdf->stream("invoice_$id.pdf");
    }

    public function sendEmail(Request $request, $id)
    {
        //return "hi";
        $validator = Validator::make($request->all(),[
                'to' => 'required'
        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }

        $input = $request->all();


        $getInvoiceData = Payment::
        leftJoin('clients','payment.fk_client_id','=','clients.id')
        ->leftJoin('account','payment.fk_account_id','=','account.id')
        ->leftJoin('payment_method','payment.fk_method_id','=','payment_method.id')
        ->select('payment.*','account.account_name','clients.client_name','clients.mobile_no','clients.address','clients.email_id','payment_method.method_name')
        ->where('payment.id',$id)
        ->first();
        

        $getInvoiceItemData = PaymentCostItem::
        leftJoin('sub_category','payment_cost_item.fk_sub_category_id','=','sub_category.id')
        ->where('payment_cost_item.fk_payment_id',$id)
        ->select('payment_cost_item.*','sub_category.sub_category_name')
        ->get();

        $totalAmount = PaymentCostItem::
            where('fk_payment_id',$id)
            ->selectRaw('sum(total_amount) as total_amount')
            ->first('total_amount');

        $totalPaid = PaymentCostItem::
            where('fk_payment_id',$id)
            ->selectRaw('sum(paid_amount) as total_paid')
            ->first('total_paid');

        $data = [
        'getInvoiceData' => $getInvoiceData,
        'getInvoiceItemData' => $getInvoiceItemData,
        'totalAmount' => $totalAmount,
        'totalPaid' => $totalPaid
        ];
        

        $companyInfo = CompanyInfo::first();
        $emailConfig = EmailConfig::first();
        $condition = TermsCondition::first();
        
        $pdf = PDF::loadView('common.invoice_public_view', compact('data','companyInfo','emailConfig','condition'));
        Mail::send('common.mail_body', array('body' => $input['body']), function($message) use ($input, $data, $pdf, $id)
        {
        
        $message->from($input['from'], $input['from']);
        if(!empty($input['cc'])){

            $message->cc($input['cc'], $input['cc']);
        }

        $message->to($input['to'])->subject($input['subject']);
        $message->attachData($pdf->output(), "invoice_$id.pdf");
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

    public function searchClient(Request $request){
        $name=$request->name;
        $data=array();

          $allData=Clients::where(['clients.fk_branch_id'=>Auth::user()->fk_branch_id,'clients.fk_company_id'=>Auth::user()->fk_company_id])->where('client_name', 'LIKE', '%'. $name .'%')->orderBy('client_name','ASC')->pluck('client_name','id');
          foreach ($allData as $key => $value) {
              $data[]=$value.'|'.$key;
          }
        
        return json_encode($data); 
    }
    












}
