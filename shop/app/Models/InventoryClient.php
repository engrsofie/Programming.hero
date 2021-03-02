<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;
use Auth;
use DB;
use App\Models\InventoryProductSales;

class InventoryClient extends Model
{
    protected $table = 'inventory_clients';
    protected $fillable = ['client_id','client_name','address','mobile_no','email_id','client_status','client_type','company_name','created_by','updated_by','shipping_address1','shipping_address2','fk_branch_id','fk_company_id'];
public function search(Request $request){
    	$name=$request->name;
        $data=array();

          $data=InventoryClient::where('company_name', 'LIKE', '%'. $name .'%')->orderBy('company_name','ASC')->limit(10)->pluck('company_name','id');
        foreach ($data as $id => $client) {
        	$prev=InventoryProductSales::select(DB::raw('SUM(total_amount) as total_amount'),DB::raw('SUM(paid_amount) as paid_amount'))
	        ->where('fk_client_id',$id)
	        ->whereColumn('total_amount','>','paid_amount')
	        ->first();
	        $total=$prev->total_amount-$prev->paid_amount;
	        $jsonData[]=$client.'|'.$total;
        }
        return json_encode($jsonData); 
    }

    static function createNew($name){
    	$data=InventoryClient::where('company_name',$name)->first();
    	$lastId=InventoryClient::max('id')+1;
    	if($data==null){
	    	$create=InventoryClient::create([
	    		'client_id'=>"client-".$lastId,
	    		'client_name'=>$name,
	    		'address'=>'',
	    		'mobile_no'=>'',
	    		'email_id'=>'',
	    		'client_status'=>1,
	    		'client_type'=>'',
	    		'company_name'=>$name,
	    		'updated_by'=>'',
	    		'shipping_address1'=>'',
	    		'shipping_address2'=>'',
	    		'created_by'=>Auth::user()->id,
	          'fk_branch_id'=>Auth::user()->fk_branch_id,
	          'fk_company_id'=>Auth::user()->fk_company_id
	    	])->id;
    	return $create;
      }else{
        return $data->id;
      }
    }

}

