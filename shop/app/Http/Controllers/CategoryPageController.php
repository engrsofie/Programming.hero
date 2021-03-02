<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;

use App\Models\Articles;
use App\Models\Categorys;
use App\Models\Notice;


use Session;
use DB;
class CategoryPageController extends Controller
{
    public function __construct(){
        Controller::__construct();
    }
    public function index($name){
    	
        /*category wise Post*/
        $input=array('name'=>$name);
        $validator = \Validator::make($input,[
            'name' => 'exists:category,categoryName',
        ]);
        if($validator->fails()){
            return view('frontend.error');
        }
        $allData = Articles::categoryWisePost($name,15);
        $getCategoryWiseArticle = Articles::getCategoryWiseArticle($name);
        $category=Categorys::where('categoryName',$name)->first();
        $CategoryWithOutThis=Categorys::where('categoryName','!=',$name)->get();
        /*--For Meta info--*/
        $seeAlso=array();
        foreach ($CategoryWithOutThis as $cat) {
            $seeAlso[]=\URL::to('/').'/'.$cat->categoryName;
        }
        
        \Session::put('title_msg',$name);
        
        \Session::put('metaDescription',$category->metaName);
        \Session::put('metaKeywords',$category->category_keyword);
        \Session::put('seeAlso',$seeAlso);
        
        return view('frontend.postPage', compact('allData','name','getCategoryWiseArticle'));
        
                
    }

    public function errorPage(){
        $seeAlso=array();
        \Session::put('title_msg','Error');
        \Session::put('metaDescription','Page not found!');
        \Session::put('metaKeywords','Error page');
        \Session::put('seeAlso',$seeAlso);
        return view('frontend.error'); 
    }

     public function notice(){
        
        $allData = Notice::activeNotice(12);
        /*--For Meta info--*/
        $seeAlso=array();
        \Session::put('title_msg','নোটিশ');
        \Session::put('metaDescription',' আমাদের সকল নোটিশ ');
        \Session::put('metaKeywords','নোটিশ');
        \Session::put('seeAlso',$seeAlso);
        
        return view('frontend.notice', compact('allData'));
        
                
    }









}
