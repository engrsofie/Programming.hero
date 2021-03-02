<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;

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
use App\Models\DepositHistory;
use DB;
use Validator;
use response;
use Mail;
use PDF;
use Auth;

class DepositController extends Controller
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
        ->select('deposit.*','clients.client_name','branch_name')
        ->orderBy('deposit.id','desc');
        if(Auth::user()->isRole('administrator')){
            $getDepositData=$query->get();
        }else{
            $getDepositData=$query->where(['deposit.fk_branch_id'=>Auth::user()->fk_branch_id,'deposit.fk_company_id'=>Auth::user()->fk_company_id])->get();

        }
        //return $getDepositData;

        return view('deposit.viewDeposits', compact('getDepositData'));
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
        return view('deposit.index', compact('subCategories','getClientData','getAccountData','getMethodData'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $input = $request->all();
        $validator = Validator::make($request->all(),[
                'client_name' => 'required',
                'fk_method_id' => 'required',
                't_date' => 'required'

        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }

        $lastId=DepositHistory::max('invoice_id');
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
            $deposit_id = Deposit::create($input)->id; 
            for ($i=0; $i < sizeof($input['fk_sub_category_id']); $i++) { 
                $sub_category_id = $input['fk_sub_category_id'][$i];
                $description = $input['description'][$i];
                $total_amount = $input['total'][$i];
                $paid_amount = $input['paid'][$i];
                $createDepositCost = DepositCostItem::createDepositCost($deposit_id,$sub_category_id,$description,$total_amount,$paid_amount);
                DepositHistory::create([
                    'fk_deposit_item_id'=>$createDepositCost,
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
            return redirect("deposit/".$input['invoice_no'])->with('success','New Deposit Created Successfully.');
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
        $allTask=DepositHistory::leftJoin('deposit_cost_item','deposit_history.fk_deposit_item_id','deposit_cost_item.id')
        ->leftJoin('sub_category','deposit_cost_item.fk_sub_category_id','=','sub_category.id')
        ->select('deposit_history.*','deposit_cost_item.fk_deposit_id','deposit_cost_item.total_amount','deposit_cost_item.paid_amount','deposit_cost_item.description','sub_category.sub_category_name')
        ->where('deposit_history.invoice_id',$id)
        ->get();
        if(count($allTask)==0){
            return redirect()->back();
        }
        $depositId=$allTask[0]->fk_deposit_id;
        $singleHistory=DepositHistory::leftJoin('deposit_cost_item','deposit_history.fk_deposit_item_id','deposit_cost_item.id')
        ->select('deposit_history.invoice_id','deposit_history.created_by','deposit_history.payment_date','deposit_cost_item.fk_deposit_id')
        ->where('deposit_history.invoice_id',$id)->orderBy('deposit_history.id','desc')->first();
        $depositId=$singleHistory->fk_deposit_id;
        $getInvoiceData = Deposit::
        leftJoin('clients','deposit.fk_client_id','=','clients.id')
        ->leftJoin('account','deposit.fk_account_id','=','account.id')
        ->leftJoin('payment_method','deposit.fk_method_id','=','payment_method.id')
        ->select('deposit.*','account.account_name','clients.client_name','clients.mobile_no','clients.address','clients.email_id','payment_method.method_name')
        ->where('deposit.id',$depositId)
        ->first();
        

        $getInvoiceItemData = DepositCostItem::
        leftJoin('sub_category','deposit_cost_item.fk_sub_category_id','=','sub_category.id')
        ->where('deposit_cost_item.fk_deposit_id',$depositId)
        ->select('deposit_cost_item.*','sub_category.sub_category_name')
        ->get();

        $totalAmount = DepositCostItem::
            where('fk_deposit_id',$depositId)
            ->selectRaw('sum(total_amount) as total_amount')
            ->first('total_amount');

        $totalPaid = DepositCostItem::
            where('fk_deposit_id',$depositId)
            ->selectRaw('sum(paid_amount) as total_paid')
            ->first('total_paid');
        $companyInfo = CompanyInfo::first();
        $emailConfig = EmailConfig::first();
        $condition = TermsCondition::first();

        return view('deposit.invoice', compact('getInvoiceData','getInvoiceItemData','totalAmount','totalPaid','companyInfo','emailConfig','condition','allTask','singleHistory'));

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
        $getProjectData = ProjectItem::all();
        $getAccountData = AccountSetting::all();
        $getMethodData = PaymentMethod::all();

        $getDepositData = Deposit::where('deposit.id',$id)
        ->first();

        $getDepositItemData = DepositCostItem::where('deposit_cost_item.fk_deposit_id',$id)
            ->get();

        $totalAmount = DepositCostItem::
            where('fk_deposit_id',$id)
            ->selectRaw('sum(total_amount) as total_amount')
            ->first('total_amount');

        $totalPaid = DepositCostItem::
            where('fk_deposit_id',$id)
            ->selectRaw('sum(paid_amount) as total_paid')
            ->first('total_paid');
        //return $totalAmount;


        return view('deposit.singleDepositEdit', compact('subCategories','getClientData','getProjectData','getAccountData','getMethodData','getDepositData','getDepositItemData','totalAmount','totalPaid'));

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
        $getDepositData = Deposit::findOrFail($id);
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
            $getDepositData->update($input);

            //deposit item updated
            $itemOldDataCount = sizeof($input['fk_sub_category_id']);
                for ($i=0; $i <$itemOldDataCount ; $i++) {
                    $depositId = $input['fk_deposit_id'];
                    $depositItemId = $input['deposit_item_old_id'][$i];
                    $fk_sub_category_id = $input['fk_sub_category_id'][$i];
                    $description = $input['description'][$i];
                    $totalAmount = $input['total'][$i];
                    $totalPaid = $input['paid'][$i];

                    $depositItemUpdated = DepositCostItem::updatedDepositItem($depositId,$depositItemId,$fk_sub_category_id,$description,$totalAmount,$totalPaid);
                }

                //old deposit item delete on click delete button
                if(isset($input['deleteItem'])){
                    $itemDeleteDataCount = sizeof($input['deleteItem']);
                    for ($i=0; $i < $itemDeleteDataCount; $i++) {
                        $itemSetDetele[]=$input['deleteItem'][$i];
                        $itemId = $itemSetDetele[$i];
                        $itemData[] = DepositCostItem::findOrFail($itemId);
                        //return $itemData;

                    }

                    $itemDeleted = DepositCostItem::deleteItemId($itemData);


                }

                //new deposit item created
                if(isset($input['fk_sub_category_id_new'])){

                    $depositItemNewDataCount = sizeof($input['fk_sub_category_id_new']);
                    for ($i=0; $i <$depositItemNewDataCount ; $i++) {
                        $depositId = $input['fk_deposit_id'];
                        $sub_category_id = $input['fk_sub_category_id_new'][$i];
                        $description = $input['description_new'][$i];
                        $total_amount = $input['total_new'][$i];
                        $paid_amount = $input['paid_new'][$i];

                        $depositItemCreated = DepositCostItem::createDepositCost($depositId,$sub_category_id,$description,$total_amount,$paid_amount);
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
        $getDepositData = Deposit::findOrFail($id);
        try {
           $items = DepositCostItem::where('fk_deposit_id',$id)->get();
            foreach($items as $item){
                DepositHistory::where('fk_deposit_item_id',$item->id)->delete(); 
            }
            DepositCostItem::where('fk_deposit_id',$id)->delete();
            $getDepositData->delete();
            $bug=0;
        } catch (\Exception $e) {
            $bug = $e->errorInfo[1];
            $bug1 = $e->errorInfo[2];
        }
       
        if($bug == 0){
            return redirect()->back()->with('success','Deposit Deleted Successfully.');
        }else{
            return redirect()->back()->with('error','Something Error Found !, Please try again.'.$bug1);
        }

    }

    public function publicInvoice($id)
    {
        $getInvoiceData = Deposit::
        leftJoin('clients','deposit.fk_client_id','=','clients.id')
        ->leftJoin('account','deposit.fk_account_id','=','account.id')
        ->leftJoin('payment_method','deposit.fk_method_id','=','payment_method.id')
        ->select('deposit.*','account.account_name','clients.client_name','clients.mobile_no','clients.address','clients.email_id','payment_method.method_name')
        ->where('deposit.id',$id)
        ->first();
        

        $getInvoiceItemData = DepositCostItem::
        leftJoin('sub_category','deposit_cost_item.fk_sub_category_id','=','sub_category.id')
        ->where('deposit_cost_item.fk_deposit_id',$id)
        ->select('deposit_cost_item.*','sub_category.sub_category_name')
        ->get();

        $totalAmount = DepositCostItem::
            where('fk_deposit_id',$id)
            ->selectRaw('sum(total_amount) as total_amount')
            ->first('total_amount');

        $totalPaid = DepositCostItem::
            where('fk_deposit_id',$id)
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
        //return $data;
        return view('common.invoice_public_view', compact('data','companyInfo','emailConfig','condition'));

    }
    public function generatePDF($id)
    {
        //$id = $request->get('generate_id');
        $getInvoiceData = Deposit::
        leftJoin('clients','deposit.fk_client_id','=','clients.id')
        ->leftJoin('account','deposit.fk_account_id','=','account.id')
        ->leftJoin('payment_method','deposit.fk_method_id','=','payment_method.id')
        ->select('deposit.*','account.account_name','clients.client_name','clients.mobile_no','clients.address','clients.email_id','payment_method.method_name')
        ->where('deposit.id',$id)
        ->first();
        

        $getInvoiceItemData = DepositCostItem::
        leftJoin('sub_category','deposit_cost_item.fk_sub_category_id','=','sub_category.id')
        ->where('deposit_cost_item.fk_deposit_id',$id)
        ->select('deposit_cost_item.*','sub_category.sub_category_name')
        ->get();

        $totalAmount = DepositCostItem::
            where('fk_deposit_id',$id)
            ->selectRaw('sum(total_amount) as total_amount')
            ->first('total_amount');

        $totalPaid = DepositCostItem::
            where('fk_deposit_id',$id)
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
        $validator = Validator::make($request->all(),[
                'to' => 'required'
        ]);
        if($validator->fails()){
            return redirect()->back()->withErrors($validator)->withInput();
        }

        $input = $request->all();


        $getInvoiceData = Deposit::
        leftJoin('clients','deposit.fk_client_id','=','clients.id')
        ->leftJoin('account','deposit.fk_account_id','=','account.id')
        ->leftJoin('payment_method','deposit.fk_method_id','=','payment_method.id')
        ->select('deposit.*','account.account_name','clients.client_name','clients.mobile_no','clients.address','clients.email_id','payment_method.method_name')
        ->where('deposit.id',$id)
        ->first();
        

        $getInvoiceItemData = DepositCostItem::
        leftJoin('sub_category','deposit_cost_item.fk_sub_category_id','=','sub_category.id')
        ->where('deposit_cost_item.fk_deposit_id',$id)
        ->select('deposit_cost_item.*','sub_category.sub_category_name')
        ->get();

        $totalAmount = DepositCostItem::
            where('fk_deposit_id',$id)
            ->selectRaw('sum(total_amount) as total_amount')
            ->first('total_amount');

        $totalPaid = DepositCostItem::
            where('fk_deposit_id',$id)
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
}
