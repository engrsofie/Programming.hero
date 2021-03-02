<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;
use Auth;

class InventorySupplier extends Model
{
    protected $table = "inventory_supplier";
    protected $fillable = ['supplier_id','representative','address','mobile_no','email_id','status','company_name','created_by','updated_by','fk_branch_id','fk_company_id'];
     public function search(Request $request){
    	$name=$request->name;
        $data=array();

          $allData=InventorySupplier::where('company_name', 'LIKE', '%'. $name .'%')->orderBy('company_name','ASC')->pluck('company_name','id');
          foreach ($allData as $key => $value) {
              $data[]=$value.'|'.$key;
          }
        
        return json_encode($data); 
    }

    static function createNew($name){
    	$data=InventorySupplier::where('company_name',$name)->first();
    	$lastId=InventorySupplier::max('id')+1;
    	if($data==null){
	    	$create=InventorySupplier::create([

	    		'supplier_id'=> "s".$lastId,
	    		'representative'=>'',
	    		'address'=>'',
	    		'mobile_no'=>'',
	    		'email_id'=>'',
	    		'status'=>1,
	    		'company_name'=>$name,
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
