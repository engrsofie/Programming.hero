<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\User;
use App\Models\InventoryBranch;
use Validator;
use Hash;
use Auth;
use DB;
class UsersController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $allUsers=User::leftJoin('inventory_branch','users.fk_branch_id','inventory_branch.id')->leftJoin('role_user','users.id','role_user.user_id')->leftJoin('roles','role_user.role_id','roles.id')->select('users.*','roles.name as type_name','branch_name')->where('users.email','!=','admin@smartsoft.com')->orderBy('users.id','DESC')->paginate(20);

        return view('user.index',compact('allUsers'));
    }

    /**
     * Show the form for creating a new Admin.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $roles=DB::table('roles')->where('system',1)->pluck('name','id');
        $branch=InventoryBranch::orderBy('id','desc')->where('status',1)->pluck('branch_name','id');
        return view('user.create',compact('roles','branch'));
    }

    /**
     * Store a newly created Admin in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
       $validator = Validator::make($request->all(), [
                    'name' => 'required|max:20',
                    'email' => 'email|required|unique:users',
                    'password' => 'required|min:6|confirmed',
                    /*enable   extension=php_fileinfo*/ 
                ]);
                if ($validator->fails()) {
                    return redirect('users/create')
                        ->withErrors($validator)
                        ->withInput();
                }
                
            $input = $request->all();
            $input['password']=bcrypt($input['password']);
            $input['created_by']=Auth::user()->id;
           $insertId= User::create($input)->id;
           $oldRole=DB::table('role_user')->where('user_id',$insertId)->first();
           if($oldRole!=null){
                DB::table('role_user')->where('user_id',$insertId)->update(['role_id'=>$request->type]);
           }else{
            DB::table('role_user')->insert(['role_id'=>$request->type,'user_id'=>$insertId]);
           }
            try{

            $bug=0;
            }catch(\Exception $e){
                $bug=$e->errorInfo[1];
            }
             if($bug==0){
            return redirect('users')->with('success','Data Successfully Inserted');
            }elseif($bug==1062){
                return redirect('users')->with('error','The Email has already been taken.');
            }else{
                return redirect('users')->with('error','Something Error Found ! ');
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
        $data=User::findOrFail($id);
        $roles=DB::table('roles')->where('system',1)->pluck('name','id');
        $branch=InventoryBranch::orderBy('id','desc')->where('status',1)->pluck('branch_name','id');
        return view('user.show',compact('data','roles','branch'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $data=User::findOrFail($id);
        return view('user.password',compact('data'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request)
    {
        //return $request->all();
        $data=User::findOrFail($request->id);
        
        $validator = Validator::make($request->all(), [
                    'name'          => 'required|max:50',
                    'email'         => 'email|required'
                ]);
        
                if ($validator->fails()) {
                    return redirect()->back()
                        ->withErrors($validator)
                        ->withInput();
                }

        $input=$request->all();
            /*return $input;*/
                $data->update($input);
            if(isset($request->type)){

                $oldRole=DB::table('role_user')->where('user_id',$request->id)->first();
                   if($oldRole!=null){
                        DB::table('role_user')->where('user_id',$request->id)->update(['role_id'=>$request->type]);
                   }else{
                    DB::table('role_user')->insert(['role_id'=>$request->type,'user_id'=>$request->id]);
                   }
            }
            try{
                $result=0;
            }catch(\Exception $e){
                $result = $e->errorInfo[1];
            }

        if($result==0){
        return redirect()->back()->with('success','Profile Successfully Updated');
        }elseif($result==1062){
            return redirect()->back()->with('error','The name has already been taken.');
        }else{
        return redirect()->back()->with('error','Something Error Found ! ');
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
       $data=User::findOrFail($id);
       try{
            $data->delete();
            $bug=0;
            $error=0;
        }catch(\Exception $e){
            $bug=$e->errorInfo[1];
            $error=$e->errorInfo[2];
        }
        if($bug==0){
       return redirect('users')->with('success','Data has been Successfully Deleted!');
        }elseif($bug==1451){
       return redirect('users')->with('error','This Data is Used anywhere ! ');

        }
        elseif($bug>0){
       return redirect('users')->with('error','Some thing error found !');

        }
    }

    public function password(Request $request){
        $input=$request->all();
        $newPass=$input['password'];
        $validator = Validator::make($request->all(),[
                    'password' => 'required|min:6|confirmed',
                ]);
                if ($validator->fails()) {
                    return redirect()->back()->withErrors($validator)->withInput();
                }
                $input['password']=bcrypt($newPass);
             $data=User::findOrFail($request->id);
        try{
            $data->update($input);
            $bug=0;
        }catch(\Exception $e){
            $bug=$e->errorInfo[1];
        }
        if($bug==0){
            return redirect()->back()->with('success','Password Changed Successfully !');
        }else{
            return redirect()->back()->with('error','Something is wrong !');

        }
    }
    public function profile(){
        $id=Auth::user()->id;
        $data=User::findOrFail($id);
        $type=DB::table('user_type')->where('type',Auth::user()->type)->pluck('type_name','type');
        return view('profile.show',compact('data','type'));
    }

    public function changePass()
    {
        $id=Auth::user()->id;
        $data=User::findOrFail($id);
        return view('profile.password',compact('data'));
    }
}
