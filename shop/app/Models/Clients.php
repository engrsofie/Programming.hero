<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use DB;
use Auth;
class Clients extends Model
{
    protected $table = 'clients';
    protected $fillable = ['client_id','client_name','address','mobile_no','email_id','client_type','client_status','company_name','created_by','updated_by','fk_company_id','fk_branch_id'];

   
    static function createNew($name){
    	$create='';
    	$data=Clients::where('client_name',$name)->first();
    	if($data==null){
	    	$create=Clients::create([

	    		'client_name'=>$name,
	    		'client_id'=> "client-".rand(1,1000),
	    		'address'=>'',
	    		'mobile_no'=>'',
	    		'email_id'=>'',
	    		'client_type'=>'supplier',
	    		'client_status'=>1,
	    		'company_name'=>'',
	    		'created_by'=>Auth::user()->id,
	    		'fk_branch_id'=>Auth::user()->fk_branch_id,
        		'fk_company_id'=>Auth::user()->fk_company_id,


	    	])->id;
    	return $create;
    	}else{
    		return $data->id;
    	}
    }
    
}
