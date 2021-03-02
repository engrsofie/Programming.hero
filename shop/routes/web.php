<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/


Route::get('/',function(){
	return redirect('/login');
});
Auth::routes();
Route::group(['middleware' =>'auth'], function(){
	Route::get('/clear-cache', function() {
	    $exitCode = Artisan::call('cache:clear');
	    return redirect()->back()->with('success','Successfully Clear Cache facade value.');
	});
	//Clear Config cache:
	Route::get('/config-cache', function() {
	    $exitCode = Artisan::call('config:cache');
	    return redirect('/')->with('success','Successfully Clear Config cache.');
	});
	Route::get('barcode-demo', 'HomeController@barcode');

	Route::get('productOrder', 'DashboardController@productOrder');
	Route::get('truncate', 'DashboardController@allTable');
	Route::get('truncate/{table}', 'DashboardController@truncateTable');
	Route::resource('acl-permission', 'AclPermissionController');
	Route::post('acl-permission-role', 'AclPermissionController@storeRole');

	Route::get('/dashboard', 'DashboardController@index');
	Route::get('/branch-change/{id}', 'DashboardController@branch');

	/*pos section start*/
	Route::resource('inventory-categories', 'InventoryCategoriesController');
	Route::resource('inventory-branch', 'InventoryBranchController');
	Route::resource('inventory-stock-position', 'InventoryStockPositionController');
	Route::resource('inventory-brand', 'InventoryBrandController');
	Route::get('inventory-client-account', 'InventoryClientReportController@account');
	Route::resource('inventory-client', 'InventoryClientController');
	Route::get('inventory-client-report', 'InventoryClientReportController@index');
	Route::get('inventory-client-report-show', 'InventoryClientReportController@show');
	Route::get('report-client-load/{id}', 'InventoryClientReportController@loadClient');
	Route::get('inventory-supplier-report', 'InventoryClientReportController@supplier');
	Route::get('inventory-supplier-report-show', 'InventoryClientReportController@supplierReport');
	Route::resource('inventory-supplier', 'InventorySupplierController');
	Route::resource('inventory-uom', 'InventoryUOMController');
	Route::resource('inventory-small-unit', 'InventorySmallUnitController');
	Route::resource('inventory-product', 'InventoryProductController');
	Route::resource('inventory-product-add', 'InventoryProductAddController');
	Route::get('inventory-product-add-all', 'InventoryProductAddController@all');
	Route::get('inventory-product-add-due/{id}', 'InventoryProductAddController@duePaid');
	Route::post('inventory-product-add-due', 'InventoryProductAddController@dueUpdate');
	Route::get('inventory-product-add-gen', 'InventoryProductAddController@generate');
	Route::resource('inventory-product-order', 'InventoryProductOrderController');
	Route::get('search-supplier','\App\Models\InventorySupplier@search');
	Route::get('search-client','\App\Models\InventoryClient@search');
	Route::resource('inventory-product-expense-list', 'InventoryProductOrderExpenseListController');
	Route::get('inventory-product-order-due-paid/{id}', 'InventoryProductOrderController@duePaid');
	Route::post('inventory-product-order-due-paid', 'InventoryProductOrderController@dueUpdate');
	Route::resource('inventory-product-order-challan', 'InventoryProductOrderChallanController');
	Route::get('inventory-order-all', 'InventoryProductOrderController@due');
	Route::get('inventory-order-browser/{id}', 'InventoryProductOrderController@orderBrowser');
	Route::get('inventory-order-browser/{id}', 'InventoryProductOrderController@orderBrowser');
	Route::resource('inventory-sales-price','InventoryProductSalePriceController');
	/*Product Wise Daily sales report*/
	Route::get('inventory-sales-daily', 'InventorySalesStatusController@daily');
	Route::get('inventory-sales-daily-result','InventorySalesStatusController@dailyResult');
	Route::get('inventory-account-report', 'InventoryReportController@account');
	Route::get('inventory-account-report-show', 'InventoryReportController@accountReport');
	/*Client Wise Daily sales report*/
	Route::get('inventory-daily-sales', 'InventorySalesStatusController@dailySales');

	Route::get('inventory-client-load/{id}', 'InventorySalesStatusController@loadClient');

	Route::get('inventory-report-purchase', 'InventoryReportController@purchase');
	Route::get('inventory-report-purchase-result', 'InventoryReportController@purchaseResult');

	Route::get('inventory-report-receivable', 'InventoryReportController@receivable');
	Route::get('inventory-report-receivable-result', 'InventoryReportController@receivableResult');

	Route::get('inventory-report-payable', 'InventoryReportController@payable');
	Route::get('inventory-report-payable-result', 'InventoryReportController@payableResult');
	Route::get('inventory-gross-profit', 'InventoryReportController@grossProfit');
	Route::get('inventory-gross-profit-result', 'InventoryReportController@grossProfitResult');

	Route::get('all-due-order', 'InventoryProductOrderController@allDue');
	Route::get('inventory-product-search', 'InventoryProductOrderController@searchProduct');
	Route::post('add-to-inventory', 'InventoryProductOrderController@addToInventory');
	Route::resource('inventory-product-sales', 'InventoryProductSalesController');
	Route::get('inventory-product-sales-due-paid/{id}', 'InventoryProductSalesController@duePaid');
	Route::post('inventory-product-sales-due-paid/{id}', 'InventoryProductSalesController@dueUpdate');
	Route::resource('inventory-sales-challan', 'InventorySalesChallanController');
	Route::get('sales-all-data', 'InventoryProductSalesController@allData');
	Route::get('inventory-sales-due', 'InventoryProductSalesController@due');
	Route::get('inventory-sales/{id}', 'InventoryProductSalesController@clientDue');
	Route::get('sales-due-data', 'InventoryProductSalesController@viewAllDue');
	Route::get('sales-client-due-data', 'InventoryProductSalesController@viewClientDue');
	Route::get('inventory-sales-invoice/{id}', 'InventoryProductSalesController@salesInvoice');
	Route::get('product_wise_info', 'InventoryProductSalesController@productInfo');
	Route::get('inventory-search', 'InventoryProductSalesController@searchProductToInventory');
	Route::resource('inventory', 'InventoryItemController');
	Route::get('total-inventory', 'InventoryItemController@totalInventory');
	Route::resource('inventory-receive-executive', 'InventoryReceiveExecutiveController');
	Route::resource('inventory-sales-payment', 'InventorySalesPaymentController');
	Route::get('inventory-sales-payment-invoice/{id}', 'InventorySalesPaymentController@invoice');
	Route::get('inventory-sales-all-payment', 'InventorySalesPaymentController@allPayment');
	Route::resource('inventory-client-opening-due', 'InventoryClientOpeningDueController');
	Route::resource('inventory-product-opening', 'InventoryProductOpeningController');
	Route::resource('inventory-product-damage', 'InventoryProductDamageController');
	Route::resource('barcode', 'PosBarcodeController');
	Route::get('allBarcode', 'PosBarcodeController@allBarcode');
	Route::get('search-inventory-barcode', 'PosBarcodeController@searchProductToInventory');
	Route::resource('pos-sales', 'PosSalesController');
	Route::resource('inventory-transfer', 'InventoryProductTransferController');
	Route::get('branch-wise-search', 'InventoryProductTransferController@inventoryProductSearch');
	Route::resource('inventory-order-payment','InventoryOrderPaymentController');
	Route::get('inventory-order-payment-invoice/{id}','InventoryOrderPaymentController@invoice');
	Route::get('inventory-order-all-payment', 'InventoryOrderPaymentController@allPayment');
	/*pos section end*/
	
	Route::resource('account-money-transfer', 'AccountMoneyTransferController');
	Route::get('load-acoount/{id}/{i}', 'AccountMoneyTransferController@loadAccount');
	Route::resource('inventory-return', 'InventoryProductReturnController');
	/*start General account system*/
	// project section
	Route::resource('deposit', 'DepositController');
	Route::get('deposit-generate-pdf/{id}', 'DepositController@generatePDF');
	Route::post('deposit_send_mail/{id}', 'DepositController@sendEmail');

	Route::resource('due-deposit', 'DueDepositController');
	Route::resource('client-wise-due-deposit', 'ClientWiseDueDepositController');
	Route::post('client_wise_deposit_send_mail/{id}', 'ClientWiseDueDepositController@sendEmail');

	Route::resource('payment', 'PaymentController');
	Route::get('payment-client', 'PaymentController@searchClient');
	Route::get('payment-generate-pdf/{id}', 'PaymentController@generatePDF');
	Route::post('payment_send_mail/{id}', 'PaymentController@sendEmail');

	Route::resource('due-payment', 'DuePaymentController');
	Route::resource('client-wise-due-payment', 'ClientWiseDuePaymentController');
	Route::post('client_wise_payment_send_mail/{id}', 'ClientWiseDuePaymentController@sendEmail');
	/**/
	/*end general account system*/

	/*report section*/
	Route::get('report-deposit', 'ReportController@reportDeposit');
	Route::get('deposit-report-generat', 'ReportController@reportDepositGenerate');
	/*Cash report section*/
	Route::get('report-cash', 'ReportController@cashAccount');
	Route::get('branch-wise-user/{id}', 'ReportController@branchWiseUser');
	Route::get('cash-report-generat', 'ReportController@reportCashGenerate');

	Route::get('report-payment', 'ReportController@reportPayment');
	Route::post('payment-report-generat', 'ReportController@reportPaymentGenerate');

	/*start set General Account*/
	// category section
	Route::resource('category', 'CategoryController');
	// sub category section
	Route::resource('sub-category', 'SubCategoryController');
	// client section
	Route::resource('client', 'ClientController');
	// project section
	Route::resource('project', 'ProjectItemController');
	/*end set General Account*/
	/*start account system*/
	// project section
	Route::resource('payment-method', 'PaymentMethodController');
	// account section
	Route::resource('account', 'AccountSettingController');

	// bill section
	Route::resource('bill', 'BillTransactionController');

	/*end account system*/

	/*admintration section*/
	
	
	Route::resource('/users', 'UsersController');
	Route::post('change-password',['as'=>'password','uses'=>'UsersController@password']);
	Route::get('change-password','UsersController@changePass');
	Route::get('my-profile','UsersController@profile');
	
	
	/*======= social Media =====*/
	Route::resource('/socialMedia', 'SocialMediaController');

	
	/*======= My profile =====*/
	Route::resource('/my-profile', 'MyProfileController');
	Route::get('/change-my-password', 'MyProfileController@viewPassword');
	Route::post('/change-my-password', 'MyProfileController@changeMyPassword');

	/*company setting section*/
	Route::resource('company-info', 'CompanyInfoController');
	Route::resource('email-config', 'EmailConfigController');
	Route::resource('terms-condition', 'TermsConditionController');

	// logout
	Route::get('/logout', 'Auth\LoginController@logout');

	/*  Employe */
	Route::resource('employe-section', 'EmployeSectionController');
	Route::resource('employe-information', 'EmployeInformationController');
	Route::resource('employe-salary-allowance', 'EmployeSalaryAllowanceController');
	Route::resource('employe-salary', 'EmployeSalaryController');
	Route::get('employe-section-wise-load/{id}', 'EmployeSalaryController@loadEmploye');
	Route::get('employe-salary-sheet-load', 'EmployeSalaryController@loadSalarySheet');
	Route::get('employe-salary-sheet', 'EmployeSalaryController@loadSectionSalary');






});
/*end public route*/

Route::get('deposit-public-invoice/{id}', 'DepositController@publicInvoice');
Route::get('payment-public-invoice/{id}', 'PaymentController@publicInvoice');
//client wise due deposit
Route::get('deposit-public-invoice-client-wise/{id}', 'ClientWiseDueDepositController@publicInvoice');
Route::get('payment-public-invoice-client-wise/{id}', 'ClientWiseDuePaymentController@publicInvoice');
Route::get('loadClientInfo/{id}','InventoryProductSalesController@loadClientInfo');
Route::get('loadClientPrev/{id}/{sub}','InventoryProductSalesController@loadClientPrev');

Route::resource('menu','MenuController');
Route::resource('sub-menu','SubMenuController');
Route::resource('sub-sub-menu','SubSubMenuController');
Route::resource('sms', 'SmsManageController');
Route::get('new-sms', 'SmsManageController@newSms');
Route::post('new-sms', 'SmsManageController@newStore');