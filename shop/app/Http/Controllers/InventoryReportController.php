<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\CompanyInfo;
use App\Models\InventorySupplier;
use App\Models\InventoryBranch;
use App\Models\InventoryProductOrder;
use App\Models\InventoryProductOrderItem;
use App\Models\InventoryProductSales;
use App\Models\InventoryProductSalesItem;
use App\Models\InventoryClient;
use App\Models\InventorySalesChallanItem;
use App\Models\EmployeSalarySheet;
use App\Models\PaymentCostItem;
use App\Models\DepositCostItem;
use App\Models\InventoryCategories;
use App\Models\InventoryProductAdd;
use App\Models\InventoryProductAddItem;
use App\Models\AccountSetting;
use App\Models\InventorySalesPaymentHistory;
use App\Models\InventoryOrderPayment;
use App\Models\Deposit;
use App\Models\Payment;
use App\Models\BillTransaction;
use DB;
use Auth;

class InventoryReportController extends Controller
{
    public function purchase(Request $request){
    	date_default_timezone_set('Asia/Dhaka');
      $filterData=array();
      $curentDate=date('Y-m-d');
      $fullUrl=explode('?',$request->fullUrl());
      if(count($fullUrl)==1){
        return redirect($request->path().'?branch='.Auth::user()->fk_branch_id);
      }
    	$query=InventoryProductAddItem::leftJoin('inventory_product_add','inventory_product_add_item.fk_product_add_id','inventory_product_add.id')
    	->leftJoin('inventory_product','inventory_product_add_item.fk_product_id','inventory_product.id')
      ->leftJoin('product_category','inventory_product.fk_category_id','product_category.id')
      ->leftJoin('inventory_product_model','inventory_product_add_item.fk_model_id','inventory_product_model.id')
      ->leftJoin('inventory_branch','inventory_product_add_item.fk_branch_id','inventory_branch.id')
      ->groupBy('inventory_product_add_item.fk_product_id','inventory_product_add_item.fk_model_id','inventory_product_add_item.fk_branch_id');
    	if(isset($request->start) and isset($request->end)){
        $filterData['start']=date('d-M-Y',strtotime($request->start));
        $filterData['end']=date('d-M-Y',strtotime($request->end));
        $query=$query->whereBetween('inventory_product_add.date',[$request->start, $request->end]);
      }else{
        $query=$query->whereBetween('inventory_product_add.date',[$curentDate, $curentDate]);
      }
      if(Auth::user()->isRole('administrator')){
        if(isset($request->branch)){
          $filterData['branch']=InventoryBranch::where('id',$request->branch)->value('branch_name');
          $query=$query->where('inventory_product_add_item.fk_branch_id',$request->branch);
        }
      }
      if(isset($request->category)){
        $filterData['category']=InventoryCategories::where('id',$request->category)->value('category_name');
        $query=$query->where('inventory_product.fk_category_id',$request->category);
      }
      if(!Auth::user()->isRole('administrator')){
        $branchId = Auth::user()->fk_branch_id;
        $filterData['branch']=InventoryBranch::where('id',$branchId)->value('branch_name');
        $query=$query->where('inventory_product_add_item.fk_branch_id',$branchId);
      }
    	$allData=$query->select('model_name','branch_name','inventory_product.product_name','category_name','inventory_product_add_item.fk_product_id',DB::raw('SUM(inventory_product_add_item.qty) as total_qty'),DB::raw('SUM(inventory_product_add_item.payable_amount) as total_amount'))
    	->get();
    	$branch=InventoryBranch::where('status',1)->pluck('branch_name','id');
      $category=InventoryCategories::where('status',1)->pluck('category_name','id');
    	$companyInfo = CompanyInfo::first();
      
      return view('report.purchaseReport.index',compact('allData','companyInfo','category','branch','filterData'));
    }

    public function purchaseResult(Request $request){

    	date_default_timezone_set('Asia/Dhaka');
      	$start=$request->start;
      	$end=$request->end;
      	$category=$request->category;
    	$query=InventoryProductAddItem::leftJoin('inventory_product_add','inventory_product_add_item.fk_product_add_id','inventory_product_add.id')
    	->leftJoin('inventory_product','inventory_product_add_item.fk_product_id','inventory_product.id')->leftJoin('product_category','inventory_product.fk_category_id','product_category.id')
    	->groupBy('inventory_product_add_item.fk_product_id')
    	->whereBetween('inventory_product_add.date', [$start, $end]);
    	if($category>0){
    		$query=$query->where('inventory_product.fk_category_id',$category);
    	}
    	$allData=$query->select('inventory_product.product_name','category_name','inventory_product_add_item.fk_product_id',DB::raw('SUM(inventory_product_add_item.qty) as total_qty'),DB::raw('SUM(inventory_product_add_item.payable_amount) as total_amount'))
    	->get();
    	$total['category_name']='';
    	if($category>0){
      $total['category_name']=InventoryCategories::where('id',$category)->value('category_name');
      }
    $filterData=array(
    	'start'=>date('d-M-Y',strtotime($start)),
    	'end'=>date('d-M-Y',strtotime($end)),
    	'category'=>$category
    	);
      return view('report.purchaseReport.loadResult',compact('allData','total','filterData'));
	}
	public function receivable(Request $request){
		date_default_timezone_set('Asia/Dhaka');
     $fullUrl=explode('?',$request->fullUrl());
          if(count($fullUrl)==1){
            return redirect($request->path().'?branch='.Auth::user()->fk_branch_id);
          }
      $branch = InventoryBranch::where('status',1)->pluck('branch_name','id');
      	if(!isset($request->branch)){
            $request=array(
                'branch' => ''
            );
            $request = (object) $request;
        }
        $allData = $this->receivableResult($request);
        return view('report.receivableDue.index',compact('allData','branch','request'));
	}
	static public function receivableResult($request){
        $branchName='';
      	date_default_timezone_set('Asia/Dhaka');
        if(Auth::user()->isRole('administrator')){
          $branch=$request->branch;
        }else{
          $branch=Auth::user()->fk_branch_id;
        }
      	$query = InventoryProductSales::leftJoin('inventory_clients','inventory_product_sales.fk_client_id','inventory_clients.id')
      	->select('inventory_clients.company_name as client_name','inventory_clients.mobile_no','inventory_clients.address',DB::raw('SUM(total_amount) as total_amount'),DB::raw('SUM(paid_amount) as paid_amount'))->groupBy('fk_client_id')
        ->orderBy('inventory_product_sales.id','ASC');
        if($branch!=null){
          $query=$query->where('inventory_product_sales.fk_branch_id',$branch);
          $branchName=InventoryBranch::where('id',$branch)->value('branch_name');
        }
        $allData=$query->get();
        $filterData=array(
        'branch'=>$branchName,
      	);
        return view('report.receivableDue.loadResult',compact('allData','filterData'));
	}
	public function payable(){
		date_default_timezone_set('Asia/Dhaka');
      	$curentDate=date('Y-m-d');
      	$allData=InventoryProductAdd::leftJoin('inventory_supplier','inventory_product_add.fk_supplier_id','inventory_supplier.id')->whereBetween('date',[$curentDate,$curentDate])
      	->select('inventory_supplier.company_name',DB::raw('SUM(total_amount) as total_amount'),DB::raw('SUM(total_paid) as paid_amount'))->groupBy('fk_supplier_id')
        ->orderBy('inventory_product_add.id','ASC')->whereColumn('total_amount','>','total_paid')->get();
        return view('report.payableDue.index',compact('allData'));
	}
	public function payableResult(Request $request){
      	date_default_timezone_set('Asia/Dhaka');
      	$start=$request->start;
      	$end=$request->end;
      	$allData=InventoryProductAdd::leftJoin('inventory_supplier','inventory_product_add.fk_supplier_id','inventory_supplier.id')->whereBetween('date',[$start,$end])
      	->select('inventory_supplier.company_name',DB::raw('SUM(total_amount) as total_amount'),DB::raw('SUM(total_paid) as paid_amount'))->groupBy('fk_supplier_id')
        ->orderBy('inventory_product_add.id','ASC')->whereColumn('total_amount','>','total_paid')->get();
        $filterData=array(
    	'start'=>date('d-M-Y',strtotime($start)),
    	'end'=>date('d-M-Y',strtotime($end)),
    	);
        return view('report.payableDue.loadResult',compact('allData','filterData'));
  }

  public function grossProfit(Request $request){
      $branch = InventoryBranch::where('status',1)->pluck('branch_name','id');
      if(isset($request->year) and isset($request->month)){
        $start=date('Y-m-d',strtotime($request->year.'-'.$request->month.'-01'));
        $end=date('Y-m-t',strtotime($request->year.'-'.$request->month.'-01'));
        $year = $request->year;
        $monthN = $request->month;
      }else{
        $start=date('Y-m-'.'01');
        $end=date('Y-m-t');
        $year = date('Y');
        $monthN = date('m');
      }
        $salesQuery=InventorySalesChallanItem::leftJoin('inventory_sales_delivery_challan','inventory_sales_challan_item.fk_sales_challan_id','inventory_sales_delivery_challan.id')
        ->leftJoin('inventory_product_sales','inventory_sales_delivery_challan.fk_sales_id','inventory_product_sales.id')
        ->whereBetween('received_date',[$start,$end])
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

        $salaryQuery=EmployeSalarySheet::leftJoin('employe_information','employe_salary_sheet.fk_employe_id','employe_information.id')->where(['year'=>$year,'month'=>$monthN])->select(DB::raw('SUM(total_amount) as total_amount'));
        if(Auth::user()->isRole('administrator')){
          if(isset($request->branch)){
            $salaryQuery=$salaryQuery->where('fk_branch_id',$request->branch);
          }
        }else{
          
            $salaryQuery=$salaryQuery->where('fk_branch_id',Auth::user()->fk_branch_id);
        }
        $salary=$salaryQuery->first();

        $depositQuery=DepositCostItem::leftJoin('deposit','deposit_cost_item.fk_deposit_id','deposit.id')->leftJoin('sub_category','deposit_cost_item.fk_sub_category_id','sub_category.id')->whereBetween('t_date',[$start,$end])->select(DB::raw('SUM(total_amount) as total_amount'),'sub_category_name')->groupBy('fk_sub_category_id');
        if(Auth::user()->isRole('administrator')){
          if(isset($request->branch)){
            $depositQuery=$depositQuery->where('fk_branch_id',$request->branch);
          }
        }else{
          
            $depositQuery=$depositQuery->where('fk_branch_id',Auth::user()->fk_branch_id);
        }
        $deposit=$depositQuery->get();

        $paymentQuery=PaymentCostItem::leftJoin('payment','payment_cost_item.fk_payment_id','payment.id')->leftJoin('sub_category','payment_cost_item.fk_sub_category_id','sub_category.id')->whereBetween('t_date',[$start,$end])->select(DB::raw('SUM(total_amount) as total_amount'),'sub_category_name')->groupBy('fk_sub_category_id');
        if(Auth::user()->isRole('administrator')){
          if(isset($request->branch)){
            $paymentQuery=$paymentQuery->where('fk_branch_id',$request->branch);
          }
        }else{
          
            $paymentQuery=$paymentQuery->where('fk_branch_id',Auth::user()->fk_branch_id);
        }
        $payment=$paymentQuery->get();

        $month=date('F, Y',strtotime("$year-$monthN-01"));
      return view('report.gross.gross',compact('sales','month','salary','payment','deposit','branch','branchName'));
}
public function grossProfitResult(Request $request){
  $start=date('Y-m-d',strtotime($request->year.'-'.$request->month.'-01'));
  $end=date('Y-m-t',strtotime($request->year.'-'.$request->month.'-01'));
  $sales=InventorySalesChallanItem::leftJoin('inventory_sales_delivery_challan','inventory_sales_challan_item.fk_sales_challan_id','inventory_sales_delivery_challan.id')->whereBetween('received_date',[$start,$end])
          ->select(DB::raw('SUM(payable_amount) as total_amount'),DB::raw('SUM(cost_amount) as total_cost'))->first();
  $salary=EmployeSalarySheet::where(['year'=>$request->year,'month'=>$request->month])->select(DB::raw('SUM(total_amount) as total_amount'))->first();
  $deposit=DepositCostItem::leftJoin('deposit','deposit_cost_item.fk_deposit_id','deposit.id')->leftJoin('sub_category','deposit_cost_item.fk_sub_category_id','sub_category.id')->whereBetween('t_date',[$start,$end])->select(DB::raw('SUM(total_amount) as total_amount'),'sub_category_name')->groupBy('fk_sub_category_id')->get();
  $payment=PaymentCostItem::leftJoin('payment','payment_cost_item.fk_payment_id','payment.id')->leftJoin('sub_category','payment_cost_item.fk_sub_category_id','sub_category.id')->whereBetween('t_date',[$start,$end])->select(DB::raw('SUM(total_amount) as total_amount'),'sub_category_name')->groupBy('fk_sub_category_id')->get();
  $month=date('F, Y',strtotime($request->year.'-'.$request->month.'-01'));
  return view('report.gross.grossResult',compact('sales','month','salary','payment','deposit'));
}

public function account(){
      $accounts = AccountSetting::orderBy('id','desc')->pluck('account_name','id');
       $branch = InventoryBranch::where('status',1)->pluck('branch_name','id');
      return view('report.account.index',compact('accounts','branch'));
    }
    function sortFunction( $a, $b ) {
            return strtotime($a["date"]) - strtotime($b["date"]);
        }
    public function accountReport(Request $request){
        $to_date=$request->start_date;
        $input=$request->except('_token');
        $accounts = AccountSetting::orderBy('id','desc')->pluck('account_name','id');
        $branch = InventoryBranch::where('status',1)->pluck('branch_name','id');
        $accountInfo = AccountSetting::where('id',$request->id)->first();
        $query = InventorySalesPaymentHistory::select('invoice_id','total_amount','paid as paid_amount','payment_date as date')
          ->where('fk_account_id',$request->id)
          ->whereBetween('payment_date',[$request->start_date,$request->end_date])
          ->orderBy('payment_date','ASC')
          ->where('total_amount','>',0);
          if($request->fk_branch_id!=null){
            $query=$query->where('fk_branch_id',$request->fk_branch_id);
          }
        $report=$query->get();


        $query2 = InventoryProductAdd::select('inventory_order_id as invoice_id','total_amount','total_paid','date')
        ->whereBetween('date',[$request->start_date,$request->end_date])
        ->orderBy('date','ASC')
        ->where('total_amount','>',0);
        
        $purchase=$query2->get();
        $cash = array_merge($report->toArray(), $purchase->toArray());
       usort($cash, function($a, $b) {
          return strtotime($a['date']) - strtotime($b['date']);
      });
        $salary=EmployeSalarySheet::whereBetween('date',[$request->start_date,$request->end_date])->where('fk_account_id',$request->id)->select(DB::raw('SUM(total_amount) as total_amount'))->first();

        $deposit=DepositCostItem::leftJoin('deposit','deposit_cost_item.fk_deposit_id','deposit.id')->leftJoin('sub_category','deposit_cost_item.fk_sub_category_id','sub_category.id')->whereBetween('t_date',[$request->start_date,$request->end_date])->where('fk_account_id',$request->id)->select(DB::raw('SUM(total_amount) as total_amount'),'sub_category_name')->groupBy('fk_sub_category_id')->get();

        $payment=PaymentCostItem::leftJoin('payment','payment_cost_item.fk_payment_id','payment.id')->leftJoin('sub_category','payment_cost_item.fk_sub_category_id','sub_category.id')->where('fk_account_id',$request->id)->whereBetween('t_date',[$request->start_date,$request->end_date])->select(DB::raw('SUM(total_amount) as total_amount'),'sub_category_name')->groupBy('fk_sub_category_id')->get();

        /*Account Balance*/
        $balance=0;
           $purchaseAccount =  InventoryProductAdd::select('inventory_order_id','total_amount','total_paid','date')->where('date','<=',$to_date)->orderBy('id','ASC')->where('total_amount','>',0)->select(DB::raw('SUM(total_paid) as total_paid'))->value('total_paid');
           $salesAccount=InventorySalesPaymentHistory::select(DB::raw('SUM(paid) as total_paid'))
                ->where('payment_date','<=',$to_date)
                ->where('fk_account_id',$request->id)
                ->value('total_paid');
           
            $depositAccount=Deposit::select(DB::raw('SUM(deposit.total_paid) as total_paid'))
                ->where('deposit.t_date','<=',$to_date)
                ->where('deposit.fk_account_id',$request->id)
                ->value('total_paid');
            $paymentAccount=Payment::select(DB::raw('SUM(payment.total_paid) as total_paid'))
                ->where('payment.t_date','<=',$to_date)
                ->where('payment.fk_account_id',$request->id)
                ->first();
            $salaryAccount=EmployeSalarySheet::select(DB::raw('SUM(total_amount) as total_amount'))
                ->where('date','<=',$to_date)
                ->where('fk_account_id',$request->id)
                ->value('total_amount');
            $accountTransfer=BillTransaction::select(DB::raw('SUM(amount) as total'))
                ->where('from_account',$request->id)
                ->first();
            $accountRecieve=BillTransaction::select(DB::raw('SUM(amount) as total'))
                ->where('to_account',$request->id)
                ->first();
            $total=$accountInfo->current_balance+$depositAccount+$accountRecieve->total+$salesAccount;
            $expense=$paymentAccount->total_paid+$accountTransfer->total+$salaryAccount+$purchaseAccount;
            $balance=$total-$expense;
        return view('report.account.index',compact('report','accountInfo','accounts','input','branch','purchase','salary','deposit','payment','account','balance','cash'));
    }






}
