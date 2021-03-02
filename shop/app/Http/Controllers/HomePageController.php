<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Categorys;
use App\Models\Tags;
use App\Models\Articles;
use App\Models\Notice;

use App\Models\BreakingNewss;
use App\Models\ArticlesVideos;
use App\Models\ArticlesImages;
use App\Models\Authors;
use App\Models\Opinions;
use App\Models\CopyRights;
use App\Models\AboutUs;
use App\Models\SocialMedias;
use App\Models\Logo;
use App\Models\Quizes;

use App\Models\AnalyticsCodes;
use App\Models\InstantArticle_app_infos;
use App\Models\InstantAtriclePageInfos;
use Session;
use DB;

class HomePageController extends Controller
{
    public function index(){
    	$tags = Tags::all();
        $feturedCategory = DB::table('category')
        ->where('featured',1)
        ->orderBy('category.serial_number','asc')
        ->get();
        foreach ($feturedCategory as $fCat) {
            $categoryWiseArticle[]=Articles::categoryWiseArticle($fCat->categoryName,9);
        }

        /*article join tag and article join image and tag join category  query(table)*/
    	$popularPostWithImages = Articles::popularPostWithImages(24);
        /*top featured news article table*/
        $topFeaturedNews = Articles::topFeaturedNews();

        /*featured news article table*/
        $featuredNews = Articles::featuredNews(12);
        /*--Recent Video --*/
        $recentVideo = Articles::recentVideo(4);
        /*all post*/
        $allArticle = Articles::getAllArticle();


        $articleBodyVideo = Articles::articleBodyVideo(4);
        foreach ($articleBodyVideo as $videos) {
            preg_match('/<iframe.*src=\"(.*)\".*><\/iframe>/isU', $videos->details, $match);
            $articleVideo[]=$match[1];
        }
        /*---Photo Gallery--*/
        $photoCategory = Articles::idWiseCategoryPost(29,1);
        $photoBlog = Articles::idWiseCategoryPost(35,9);
       
        $engDATE = array(1,2,3,4,5,6,7,8,9,0,'January','February','March','April','May','June','July','August','September','October','November','December','Saturday','Sunday','Monday','Tuesday','Wednesday','Thursday','Friday');
        $bangDATE = array('১','২','৩','৪','৫','৬','৭','৮','৯','০','জানুয়ারী','ফেব্রুয়ারী','মার্চ','এপ্রিল','মে','জুন','জুলাই','আগস্ট','সেপ্টেম্বর','অক্টোবর','নভেম্বর','ডিসেম্বর','শনিবার','রবিবার','সোমবার','মঙ্গলবার','
        বুধবার','বৃহস্পতিবার','শুক্রবার' 
        );
        $authorList = DB::table('author')
        ->where('author.status','=', '1')
        ->orderBy('author_serial_number','asc')
        ->paginate(21);

        $postWiseAuthorList = Articles::join('author','author.id','article.authorID')
        ->select('author.authorName','article.id','author.author_profile','author.id as author_id')
        ->orderBy('article.id','desc')
        ->pluck('author.authorName','author.author_id');
        $authorNameList=array();
        $i=0;
        foreach ($postWiseAuthorList as $key => $value) {
            $authorNameList[$i++]=$key;
        }
        for ($i=0; $i <sizeof($authorNameList) ; $i++) { 
           $authorDataList[] = DB::table('author')->where('id',$authorNameList[$i])->select('authorName','author_profile')->get();
        }

        /*echo"<pre>";
        print_r($authorDataList[2][0]->author_profile);exit;*/
        $logo=Logo::first();
        $facebook=SocialMedias::where('socialName','facebook')->first();
        $socialMedias=SocialMedias::all();
        /*googel analysis code*/
        $google_analysis = AnalyticsCodes::all();
        $commonData=array(
            'engDATE'       => $engDATE,
            'bangDATE'      => $bangDATE,
            'app_info'      => InstantArticle_app_infos::first(),
            'page_info'     => InstantAtriclePageInfos::first(),
            'logo'          => $logo,
            'category'      => DB::table('category')
                                ->orderBy('category.serial_number','asc')->get(),
            'aboutUsData'   => AboutUs::first(),
            'copyRightData' => CopyRights::first(),
            'analyticsCodes'=> AnalyticsCodes::all(),
            'socialMedia'   => SocialMedias::get(),
            'featuredNews'  => $featuredNews,
            'facebook'      =>$facebook,
            'notice'        =>Notice::activeNotice(10),
            'photoBlog'        =>$photoBlog,
            'recentQuiz'    => DB::table('quiz')
        ->leftJoin('quiz_category','quiz.quiz_category_id','=','quiz_category.id')
        ->where('published_date','<=', date('Y-m-d h:i:s'))
        ->where('quiz.show_quiz','=','1')
        ->select('quiz.*','quiz_category.quiz_category_name','quiz_category.id as quiz_category_id')
        ->orderBy('quiz.id','desc')
        ->paginate(9),
            );
	    $title = $logo->logoHeadline;
	    
        $category= DB::table('category')->orderBy('category.serial_number','asc')->get();
        /*--For Meta info--*/
        $seeAlso=array();
        foreach ($commonData['category'] as $cat) {
            $seeAlso[]=\URL::to('/').'/'.$cat->categoryName;
        }
        \Session::forget('title_msg');
        
        \Session::forget('metaDescription');
        \Session::forget('metaKeywords');
        \Session::put('seeAlso',$seeAlso);
        \Session::put('commonData',$commonData);
    	return view('frontend.index',compact('popularPostWithImages','topFeaturedNews','featuredNews','engDATE','bangDATE','title','feturedCategory','categoryWiseArticle','facebook','recentVideo','photoCategory','authorList','category','articleBodyVideo','articleVideo','photoBlog','authorDataList','allArticle','socialMedias'));
    }

    public function tos(){
        return view('frontend.terms_condition');
    }
    public function pp(){
        return view('frontend.privacy_policy');
    }





}
