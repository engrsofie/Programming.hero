<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\InventoryBranch;
use App\Models\InventoryClient;
use App\Models\SmsConfig;
use App\Models\Sms;

class SmsManageController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Request $request)
    {
        $branch = InventoryBranch::orderBy('id','ASC')->where('status',1)->pluck('branch_name','id');
        if(isset($request->branch)){
           $customers= InventoryClient::leftJoin('inventory_branch','inventory_clients.fk_branch_id','=','inventory_branch.id')
        ->select('inventory_branch.branch_name','inventory_clients.*')->where('fk_branch_id',$request->branch)->orderBy('id','desc')->get();
        }
        $quantity=SmsConfig::first()->value('sms_quantity');
        $quantity=$this->simpleCrypt($quantity,'d');
        return view('sms.create',compact('branch','customers','quantity'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $input=$request->except('_token');
        $config=SmsConfig::first();
        $qty=$this->simpleCrypt($config->sms_quantity,'d');
        $user= $this->simpleCrypt($config->user_name,'d');
        $password= $this->simpleCrypt($config->password,'d');
        $from= $this->simpleCrypt($config->from,'d');
        if($qty==0){
            return redirect()->back()->with('error','Insufficient balance ! '); 
        }
        $number=$request->number;
        $msg=$request->message;
        $length = $request->length;
        $smsCount=ceil($length/160);
         $number=array();
        foreach ($request->fk_client_id as $k => $customer) {
            $num=$request->number[$customer];
            if($num!=null and strlen($num)>10){
                if(substr($num,0,2)!='88'){
                    $num="88".$num;
                }
                $number[]=$num;
                $customers[]=$customer;
            }
        }
        $numbers=implode($number, ',');
        
           
        try{
            $msg=str_replace(' ','%20',$msg);
                $xml = file_get_contents("https://api.mobireach.com.bd/SendTextMultiMessage?Username=$user&Password=$password&From=$from&To=$numbers&Message=$msg");
                $smsApi=array();
                $tag='MessageId';
                preg_match_all("/<".$tag."[^>]*>(.*?)<\/$tag>/si", $xml, $matches);
                $smsApi['messageId']=$matches[1];

                $tag='ErrorText';
                preg_match_all("/<".$tag."[^>]*>(.*?)<\/$tag>/si", $xml, $matches);
                $smsApi['errorText']=$matches[1];

                $tag='CurrentCredit';
                preg_match_all("/<".$tag."[^>]*>(.*?)<\/$tag>/si", $xml, $matches);
                $smsApi['currentCredit']=$matches[1];
                $number=explode(',', $numbers);
                $apiDetails=array();
                foreach ($smsApi['messageId'] as $key => $value) {
                    $status = file_get_contents("https://api.mobireach.com.bd/GetMessageStatus?Username=$user&Password=$password&MessageId=$value");
                    $tag='Status';
                    preg_match("/<".$tag."[>]*>(.*?)<\/$tag>/si", $status, $matches);
                    $insert=Sms::create([
                        'number'=>$number[$key],
                        'message'=>str_replace('%20',' ',$msg),
                        'status'=>$matches[1],
                        'message_id'=>$value,
                        'error'=>$smsApi['errorText'][$key],
                        'fk_client_id'=>$customers[$key],
                    ]);
                }

                $newQty=$qty-count($smsApi['messageId'])*$smsCount;
                $config->update([
                    'sms_quantity'=>$this->simpleCrypt($newQty)
                ]);
            $bug=0;
            }catch(\Exception $e){
                $errors=$e->getmessage();
                $error=explode('):', $errors);
                if(isset($error[1])){
                    $textError=$error[1];
                }else{
                    
                    $textError=$errors;
                }
                $bug=1;
            }
             if($bug==0){
            return redirect()->back()->with('success','Data Successfully Inserted');
            }else{
                return redirect()->back()->with('error','Error: '.$textError);
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
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $input=SmsConfig::first()->first()->toArray();
        $config=[
            'sms_quantity' => $this->simpleCrypt($input['sms_quantity'],'d'),
            'user_name'    => $this->simpleCrypt($input['user_name'],'d'),
            'password'     => $this->simpleCrypt($input['password'],'d'),
            'from'         => $this->simpleCrypt($input['from'],'d'),
        ];
        return view('sms.config',compact('config'));
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
        $input=$request->all();
        SmsConfig::where('id',1)->update([
            'sms_quantity' => $this->simpleCrypt($input['sms_quantity']),
            'user_name'    => $this->simpleCrypt($input['user_name']),
            'password'     => $this->simpleCrypt($input['password']),
            'from'         => $this->simpleCrypt($input['from']),
        ]);
        return redirect()->back()->with('success','Update Successfully');
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
    public function newSms()
    {
        $quantity=SmsConfig::first()->value('sms_quantity');
        $quantity=$this->simpleCrypt($quantity,'d');
        return view('sms.newSms',compact('quantity'));
    }

    public function newStore(Request $request)
    {
        $config=SmsConfig::first();
        $qty=$this->simpleCrypt($config->sms_quantity,'d');
        $user= $this->simpleCrypt($config->user_name,'d');
        $password= $this->simpleCrypt($config->password,'d');
        $from= $this->simpleCrypt($config->from,'d');

        if($qty==0){
            return redirect()->back()->with('error','Insufficient balance ! '); 
        }

        $numbers=$request->number;
        $msg=$request->message;
        $length = $request->length;
        $smsCount=ceil($length/160);
        try{
            $msg=str_replace(' ','%20',$msg);
                $xml = file_get_contents("https://api.mobireach.com.bd/SendTextMultiMessage?Username=$user&Password=$password&From=$from&To=$numbers&Message=$msg");
                $smsApi=array();
                $tag='MessageId';
                preg_match_all("/<".$tag."[^>]*>(.*?)<\/$tag>/si", $xml, $matches);
                $smsApi['messageId']=$matches[1];

                $tag='ErrorText';
                preg_match_all("/<".$tag."[^>]*>(.*?)<\/$tag>/si", $xml, $matches);
                $smsApi['errorText']=$matches[1];

                $tag='CurrentCredit';
                preg_match_all("/<".$tag."[^>]*>(.*?)<\/$tag>/si", $xml, $matches);
                $smsApi['currentCredit']=$matches[1];
                $number=explode(',', $numbers);
                $apiDetails=array();
                $newQty=$qty-count($smsApi['messageId'])*$smsCount;
                $config->update([
                    'sms_quantity'=>$this->simpleCrypt($newQty)
                ]);
                foreach ($smsApi['messageId'] as $key => $value) {
                    $status = file_get_contents("https://api.mobireach.com.bd/GetMessageStatus?Username=$user&Password=$password&MessageId=$value");
                    $tag='Status';
                    preg_match("/<".$tag."[>]*>(.*?)<\/$tag>/si", $status, $matches);
                    $insert=Sms::create([
                        'number'=>$number[$key],
                        'message'=>str_replace('%20',' ',$msg),
                        'status'=>$matches[1],
                        'message_id'=>$value,
                        'error'=>$smsApi['errorText'][$key],

                    ]);

                }

            $bug=0;
            }catch(\Exception $e){
                $errors=$e->getmessage();
                $error=explode('):', $errors);
                if(isset($error[1])){
                    $textError=$error[1];
                }else{
                    
                    $textError=$errors;
                }
                $bug=1;
            }
             if($bug==0){
            return redirect()->back()->with('success','Data Successfully Inserted');
            }else{
                return redirect()->back()->with('error','Error: '.$textError);
            }
        }



 
    function simpleCrypt( $string, $action = 'e' ) {
        // you may change these values to your own
        $secret_key = 'my_simple_secret_key';
        $secret_iv = 'my_simple_secret_iv';
     
        $output = false;
        $encrypt_method = "AES-256-CBC";
        $key = hash( 'sha256', $secret_key );
        $iv = substr( hash( 'sha256', $secret_iv ), 0, 16 );
     
        if( $action == 'e' ) {
            $output = base64_encode( openssl_encrypt( $string, $encrypt_method, $key, 0, $iv ) );
        }
        else if( $action == 'd' ){
            $output = openssl_decrypt( base64_decode( $string ), $encrypt_method, $key, 0, $iv );
        }
     
        return $output;
    }




}
