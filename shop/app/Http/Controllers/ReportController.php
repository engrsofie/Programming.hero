<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\Deposit;
use App\Models\Payment;
use App\Models\AccountSetting;
use App\Models\CompanyInfo;
use App\Models\DepositCostItem;
use App\Models\PaymentCostItem;
use App\Models\SubCategories;
use App\Models\Clients;
use App\Models\ProjectItem;
use App\Models\PaymentMethod;
use App\Models\BillTransaction;
use App\Models\InventorySalesChallanItem;
use App\Models\InventoryProductAdd;
use App\Models\InventoryProductAddItem;
use App\Models\EmployeSalarySheet;
use App\Models\InventorySalesPaymentHistory;
use App\Models\InventoryProductSales;
use App\Models\InventoryBranch;
use App\Models\PaymentHistory;
use App\Models\DepositHistory;
use DB;
use Auth;

class ReportController extends Controller
{
    public function reportDeposit(Request $request){
        $branch = InventoryBranch::where('status',1)->pluck('branch_name','id');
        $companyInfo = CompanyInfo::first();
         $accountReports=array();
         if(isset($request->start) and isset($request->end)){
            $form_date = $request->get('start');
            $to_date = $request->get('end');
         }else{
            $form_date = date('Y-m-d');
            $to_date = date('Y-m-d');
            
         }
        $salesQuery=InventorySalesChallanItem::leftJoin('inventory_sales_delivery_challan','inventory_sales_challan_item.fk_sales_challan_id','inventory_sales_delivery_challan.id')
        ->leftJoin('inventory_product_sales','inventory_sales_delivery_challan.fk_sales_id','inventory_product_sales.id')
        ->whereBetween('received_date',[$form_date,$to_date])
          ->select(DB::raw('SUM(payable_amount) as total_amount'),DB::raw('SUM(cost_amount) as total_cost'));
         if(Auth::user()->isRole('administrator')){
          if(isset($request->branch)){
            $salesQuery=$salesQuery->where('fk_branch_id',$request->branch);
            $branchName = InventoryBranch::where('id',$request->branch)->value('branch_name');
          }else{
            $branchName = 'All';
          }
        }else{
          
            $branchName = InventoryBranch::where('id',Auth::user()->fk_branch_id)->value('branch_name');
            $salesQuery=$salesQuery->where('fk_branch_id',Auth::user()->fk_branch_id);
        }
        $sales=$salesQuery->first();

        $purchaseQuery=InventoryProductAddItem::leftJoin('inventory_product_add','fk_product_add_id','inventory_product_add.id')->whereBetween('date',[$form_date,$to_date])
          ->select(DB::raw('SUM(payable_amount) as total_amount'));
        if(Auth::user()->isRole('administrator')){
          if(isset($request->branch)){
            $purchaseQuery=$purchaseQuery->where('fk_branch_id',$request->branch);
          }
        }else{
            $purchaseQuery=$purchaseQuery->where('fk_branch_id',Auth::user()->fk_branch_id);
        }
        $purchase=$purchaseQuery->first();
        $salaryQuery=EmployeSalarySheet::leftJoin('employe_information','employe_salary_sheet.fk_employe_id','employe_information.id')->whereBetween('date',[$form_date,$to_date])->select(DB::raw('SUM(paid_amount) as total_amount'));
        if(Auth::user()->isRole('administrator')){
          if(isset($request->branch)){
            $salaryQuery=$salaryQuery->where('fk_branch_id',$request->branch);
          }
        }else{
          
            $salaryQuery=$salaryQuery->where('fk_branch_id',Auth::user()->fk_branch_id);
        }
        $salary=$salaryQuery->first();

        $depositQuery=DepositCostItem::leftJoin('deposit','deposit_cost_item.fk_deposit_id','=','deposit.id')
                ->leftJoin('account','deposit.fk_account_id','=','account.id')
                ->leftJoin('sub_category','deposit_cost_item.fk_sub_category_id','sub_category.id')
                ->select('account.account_name','sub_category.sub_category_name',DB::raw('SUM(deposit_cost_item.total_amount) as total_amount'),DB::raw('SUM(deposit_cost_item.paid_amount) as total_paid'))
                ->whereBetween('deposit.t_date', [$form_date, $to_date])
                ->groupBy('deposit_cost_item.fk_sub_category_id');
        $paymentQuery=PaymentCostItem::leftJoin('payment','payment_cost_item.fk_payment_id','=','payment.id')
                ->leftJoin('account','payment.fk_account_id','=','account.id')
                ->leftJoin('sub_category','payment_cost_item.fk_sub_category_id','sub_category.id')
                ->select('account.account_name','sub_category.sub_category_name',DB::raw('SUM(payment_cost_item.total_amount) as total_amount'),DB::raw('SUM(payment_cost_item.paid_amount) as total_paid'))
                ->whereBetween('payment.t_date', [$form_date, $to_date])
                ->groupBy('payment_cost_item.fk_sub_category_id');
        if(Auth::user()->isRole('administrator')){
          if(isset($request->branch)){
            $depositQuery=$depositQuery->where('deposit.fk_branch_id',$request->branch);
            $paymentQuery=$paymentQuery->where('payment.fk_branch_id',$request->branch);
          }
        }else{
          
            $depositQuery=$depositQuery->where('deposit.fk_branch_id',Auth::user()->fk_branch_id);
            $paymentQuery=$paymentQuery->where('payment.fk_branch_id',Auth::user()->fk_branch_id);
        }
            $depositReports=$depositQuery->get();
            $paymentReports=$paymentQuery->get();
        /*Account Balance*/
        $accountStarting=AccountSetting::select('id','account_name','current_balance')->where('account_status',1)->get();
        foreach ($accountStarting as $key => $value) {
            $balance=0;
           $purchaseAccount =  InventoryProductAdd::select('inventory_order_id','total_amount','total_paid','date')->orderBy('id','ASC')->where('total_amount','>',0)->select(DB::raw('SUM(total_paid) as total_paid'))->value('total_paid');
            $salesAccount=InventorySalesPaymentHistory::select(DB::raw('SUM(paid) as total_paid'))
                ->where('fk_account_id',$value->id)
                ->value('total_paid');
            $salaryAccount=EmployeSalarySheet::select(DB::raw('SUM(paid_amount) as paid_amount'))
                ->where('fk_account_id',$value->id)
                ->value('paid_amount');
            $depositAccount=Deposit::select(DB::raw('SUM(deposit.total_paid) as total_paid'))
                ->where('deposit.fk_account_id',$value->id)
                ->value('total_paid');
            $paymentAccount=Payment::select(DB::raw('SUM(payment.total_paid) as total_paid'))
                ->where('payment.fk_account_id',$value->id)
                ->first();
            $accountTransfer=BillTransaction::select(DB::raw('SUM(amount) as total'))
                ->where('from_account',$value->id)
                ->first();
            $accountRecieve=BillTransaction::select(DB::raw('SUM(amount) as total'))
                ->where('to_account',$value->id)
                ->first();
            $total=$value->current_balance+$depositAccount+$accountRecieve->total+$salesAccount;
            $expense=$paymentAccount->total_paid+$accountTransfer->total+$salaryAccount+$purchaseAccount;
            $balance=$total-$expense;
            $accountReports[]=array(
                'account_name'=>$value->account_name,
                'balance'=>$balance,
                );
        }
        $filterData=array(
        'start'=>date('d-M-Y',strtotime($form_date)),
        'end'=>date('d-M-Y',strtotime($to_date)),
        );
        return view('report.all.index',compact('companyInfo','branch','accountReports','depositReports','paymentReports','filterData','sales','purchase','salary','branchName'));
    }

    public function reportDepositGenerate(Request $request){
        $accountReports=array();
        $form_date = $request->get('start');
        $to_date = $request->get('end');
        $sales=InventorySalesChallanItem::leftJoin('inventory_sales_delivery_challan','inventory_sales_challan_item.fk_sales_challan_id','inventory_sales_delivery_challan.id')->whereBetween('received_date',[$form_date,$to_date])
          ->select(DB::raw('SUM(payable_amount) as total_amount'),DB::raw('SUM(cost_amount) as total_cost'))->first();

        $purchase=InventoryProductAdd::whereBetween('date',[$form_date,$to_date])
          ->select(DB::raw('SUM(total_amount) as total_amount'))->first();
        $salary=EmployeSalarySheet::whereBetween('date',[$form_date,$to_date])->select(DB::raw('SUM(paid_amount) as total_amount'))->first();
        $depositQuery=DepositCostItem::leftJoin('deposit','deposit_cost_item.fk_deposit_id','=','deposit.id')
                ->leftJoin('account','deposit.fk_account_id','=','account.id')
                ->leftJoin('sub_category','deposit_cost_item.fk_sub_category_id','sub_category.id')
                ->select('account.account_name','sub_category.sub_category_name',DB::raw('SUM(deposit_cost_item.total_amount) as total_amount'),DB::raw('SUM(deposit_cost_item.paid_amount) as total_paid'))
                ->whereBetween('deposit.t_date', [$form_date, $to_date])
                ->groupBy('deposit_cost_item.fk_sub_category_id');
        $paymentQuery=PaymentCostItem::leftJoin('payment','payment_cost_item.fk_payment_id','=','payment.id')
                ->leftJoin('account','payment.fk_account_id','=','account.id')
                ->leftJoin('sub_category','payment_cost_item.fk_sub_category_id','sub_category.id')
                ->select('account.account_name','sub_category.sub_category_name',DB::raw('SUM(payment_cost_item.total_amount) as total_amount'),DB::raw('SUM(payment_cost_item.paid_amount) as total_paid'))
                ->whereBetween('payment.t_date', [$form_date, $to_date])
                ->groupBy('payment_cost_item.fk_sub_category_id');
        
            $depositReports=$depositQuery->get();
            $paymentReports=$paymentQuery->get();
        /*Account Balance*/
        $accountStarting=AccountSetting::select('id','account_name','current_balance')->where('account_status',1)->get();
        foreach ($accountStarting as $key => $value) {
            $balance=0;
           $purchaseAccount =  InventoryProductAdd::select('inventory_order_id','total_amount','total_paid','date')->orderBy('id','ASC')->where('total_amount','>',0)->select(DB::raw('SUM(total_paid) as total_paid'))->value('total_paid');
            $salesAccount=InventorySalesPaymentHistory::select(DB::raw('SUM(paid) as total_paid'))
                ->where('fk_account_id',$value->id)
                ->value('total_paid');
            $salaryAccount=EmployeSalarySheet::select(DB::raw('SUM(paid_amount) as paid_amount'))
                ->where('fk_account_id',$value->id)
                ->value('paid_amount');
            $depositAccount=Deposit::select(DB::raw('SUM(deposit.total_paid) as total_paid'))
                ->where('deposit.fk_account_id',$value->id)
                ->value('total_paid');
            $paymentAccount=Payment::select(DB::raw('SUM(payment.total_paid) as total_paid'))
                ->where('payment.fk_account_id',$value->id)
                ->first();
            $accountTransfer=BillTransaction::select(DB::raw('SUM(amount) as total'))
                ->where('from_account',$value->id)
                ->first();
            $accountRecieve=BillTransaction::select(DB::raw('SUM(amount) as total'))
                ->where('to_account',$value->id)
                ->first();
            $total=$value->current_balance+$depositAccount+$accountRecieve->total+$salesAccount;
            $expense=$paymentAccount->total_paid+$accountTransfer->total+$salaryAccount+$purchaseAccount;
            $balance=$total-$expense;
            $accountReports[]=array(
                'account_name'=>$value->account_name,
                'balance'=>$balance,
                );
        }
        $filterData=array(
        'start'=>date('d-M-Y',strtotime($form_date)),
        'end'=>date('d-M-Y',strtotime($to_date)),
        );
        return view('report.all.load-report', compact('accountReports','depositReports','paymentReports','filterData','sales','purchase','salary'));

    }
    
    //payment report section
    public function reportPayment(){
    	return view('report.payment.index');
    }

    public function reportPaymentGenerate(Request $request){
    	$form_date = $request->get('form_date');
    	$to_date = $request->get('to_date');

    	$getPaymentReport = Payment::
    	leftJoin('clients','payment.fk_client_id','=','clients.id')
        ->leftJoin('payment_cost_item','payment.id','=','payment_cost_item.fk_payment_id')
        ->leftJoin('sub_category','payment_cost_item.fk_sub_category_id','=','sub_category.id')
        ->leftJoin('category','sub_category.fk_category_id','=','category.id')
        ->whereBetween('payment.t_date', [$form_date, $to_date])
        ->select('payment.id','payment.invoice_no','payment.t_date','payment_cost_item.total_amount','payment_cost_item.paid_amount','clients.client_name','sub_category.sub_category_name','category.category_name')
        ->orderBy('payment.id','desc')
    	->get();

    	$totalAmount = PaymentCostItem::
    		leftJoin('payment','payment_cost_item.fk_payment_id','=','payment.id')
            ->whereBetween('payment.t_date', [$form_date, $to_date])
            ->selectRaw('sum(total_amount) as total_amount')
            ->first('total_amount');

        $totalPaid = PaymentCostItem::
        	leftJoin('payment','payment_cost_item.fk_payment_id','=','payment.id')
            ->whereBetween('payment.t_date', [$form_date, $to_date])
            ->selectRaw('sum(paid_amount) as total_paid')
            ->first('total_paid');

    	return view('report.payment.load-payment-report', compact('getPaymentReport','totalAmount','totalPaid'));

    }
    public function cashAccount(Request $request){
        $branch = InventoryBranch::where('status',1)->pluck('branch_name','id');
        $users = \App\User::where('status',1)->pluck('name','id');
        if(isset($request->branch) and $request->branch!=null){
        $users = \App\User::where('status',1)->where('fk_branch_id',$request->branch)->pluck('name','id');
        }
        if(Auth::user()->isRole('branch-admin')){
            $branchId = Auth::user()->fk_branch_id;
            $users = \App\User::where('status',1)->where('fk_branch_id',$branchId)->pluck('name','id');
        }
        $reports = '';
        if(isset($request->start)){
            $reports = $this->reportCashGenerate($request);
        }
        return view('report.cash.index',compact('branch','users','reports'));
    }
    public function reportCashGenerate(Request $request){
        $start = date('Y-m-d',strtotime($request->start));
        $end = date('Y-m-d',strtotime($request->end));
        $filterData=array(
        'start'=>date('d-M-Y',strtotime($start)),
        'end'=>date('d-M-Y',strtotime($end)),
        'branch'=>'All',
        'user'=>'All',
        );
        $sales=InventorySalesPaymentHistory::leftJoin('inventory_clients','inventory_payment_history.fk_client_id','inventory_clients.id')->whereBetween('payment_date',[$start,$end])
          ->select('client_name',DB::raw('SUM(last_due) as total_amount'),DB::raw('SUM(paid) as paid_amount'))->groupBy('fk_client_id');
        $salary=EmployeSalarySheet::leftJoin('employe_information','employe_salary_sheet.fk_employe_id','employe_information.id')
                ->whereBetween('date',[$start,$end])->select(DB::raw('SUM(total_amount) as total_amount'),'employe_name')->groupBy('fk_employe_id');
        $depositQuery=DepositHistory::leftJoin('deposit_cost_item','deposit_history.fk_deposit_item_id','=','deposit_cost_item.id')
                ->leftJoin('deposit','deposit_cost_item.fk_deposit_id','=','deposit.id')
                ->leftJoin('account','deposit.fk_account_id','=','account.id')
                ->leftJoin('clients','deposit.fk_client_id','=','clients.id')
                ->leftJoin('sub_category','deposit_cost_item.fk_sub_category_id','sub_category.id')
                ->select('client_name','account.account_name','sub_category.sub_category_name',DB::raw('SUM(deposit_history.last_due) as total_amount'),DB::raw('SUM(deposit_history.paid) as total_paid'))
                ->whereBetween('deposit_history.payment_date', [$start, $end])
                ->groupBy('deposit_cost_item.fk_sub_category_id','fk_client_id');
        $paymentQuery=PaymentHistory::leftJoin('payment_cost_item','payment_history.fk_payment_item_id','=','payment_cost_item.id')
                ->leftJoin('payment','payment_cost_item.fk_payment_id','=','payment.id')
                ->leftJoin('clients','payment.fk_client_id','=','clients.id')
                ->leftJoin('account','payment.fk_account_id','=','account.id')
                ->leftJoin('sub_category','payment_cost_item.fk_sub_category_id','sub_category.id')
                ->select('client_name','account.account_name','sub_category.sub_category_name',DB::raw('SUM(payment_history.last_due) as total_amount'),DB::raw('SUM(payment_history.paid) as total_paid'))
                ->whereBetween('payment_history.payment_date', [$start, $end])
                ->groupBy('payment_cost_item.fk_sub_category_id','fk_client_id');

        if(isset($request->branch) and $request->branch!=null){
            $filterData['branch'] = InventoryBranch::where('id',$request->branch)->value('branch_name');
            $depositReports=$depositQuery->where('deposit.fk_branch_id',$request->branch);
            $paymentReports=$paymentQuery->where('payment.fk_branch_id',$request->branch);
            $sales = $sales->where('inventory_payment_history.fk_branch_id',$request->branch);
            $salary = $salary->where('employe_information.fk_branch_id',$request->branch);
        }
        if(isset($request->user) and $request->user!=null){
            $filterData['user'] = \App\User::where('id',$request->user)->value('name');

            $depositReports=$depositQuery->where('deposit_history.created_by',$request->user);
            $paymentReports=$paymentQuery->where('payment_history.created_by',$request->user);
            $sales = $sales->where('inventory_payment_history.created_by',$request->user);
            $salary = $salary->where('employe_salary_sheet.created_by',$request->user);
        }
        if(Auth::user()->isRole('branch-admin')){
            $branchId = Auth::user()->fk_branch_id;
            $filterData['branch'] = InventoryBranch::where('id',$branchId)->value('branch_name');
            $depositReports=$depositQuery->where('deposit.fk_branch_id',$branchId);
            $paymentReports=$paymentQuery->where('payment.fk_branch_id',$branchId);
            $sales = $sales->where('inventory_payment_history.fk_branch_id',$branchId);
            $salary = $salary->where('employe_information.fk_branch_id',$branchId);
        }
        if(Auth::user()->isRole('Sales')){
            $userId = Auth::user()->id;
            $filterData['user'] = \App\User::where('id',$userId)->value('name');

            $depositReports=$depositQuery->where('deposit_history.created_by',$userId);
            $paymentReports=$paymentQuery->where('payment_history.created_by',$userId);
            $sales = $sales->where('inventory_payment_history.created_by',$userId);
            $salary = $salary->where('employe_salary_sheet.created_by',$userId);
        }
        

            $depositReports=$depositQuery->get();
            $paymentReports=$paymentQuery->get();
            $sales = $sales->get();
            $salary = $salary->get();
        
        return view('report.cash.loadReport', compact('depositReports','paymentReports','filterData','sales','salary'));
    }

    public function branchWiseUser($id){
        $users =  \App\User::where('fk_branch_id',$id)->pluck('name','id');
        return view('report.cash.user',compact('users'));
    }
}
