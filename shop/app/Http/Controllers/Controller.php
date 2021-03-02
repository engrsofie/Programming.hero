<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
// use App\Models\Categorys;
// use App\Models\Articles;
// use App\Models\Authors;
// use App\Models\Opinions;
// use App\Models\CopyRights;
// use App\Models\AboutUs;
// use App\Models\SocialMedias;
// use App\Models\Logo;
// use App\Models\Quizes;
// use App\Models\Notice;

// use App\Models\AnalyticsCodes;
// use App\Models\InstantArticle_app_infos;
// use App\Models\InstantAtriclePageInfos;
use Session;
use DB;

class Controller extends BaseController
{
    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;
    public function __construct(){
    	// $engDATE = array(1,2,3,4,5,6,7,8,9,0,'January','February','March','April','May','June','July','August','September','October','November','December','Saturday','Sunday','Monday','Tuesday','Wednesday','Thursday','Friday');
     //    $bangDATE = array('১','২','৩','৪','৫','৬','৭','৮','৯','০','জানুয়ারী','ফেব্রুয়ারী','মার্চ','এপ্রিল','মে','জুন','জুলাই','আগস্ট','সেপ্টেম্বর','অক্টোবর','নভেম্বর','ডিসেম্বর','শনিবার','রবিবার','সোমবার','মঙ্গলবার','
     //    বুধবার','বৃহস্পতিবার','শুক্রবার' 
     //    );
     //    $logo=Logo::first();
     //    $facebook=SocialMedias::where('socialName','facebook')->first();
     //    $featuredNews = Articles::featuredNews(10);
    	// $commonData=array(
     //        'engDATE'       => $engDATE,
     //        'bangDATE'      => $bangDATE,
     //        'app_info'      => InstantArticle_app_infos::first(),
     //        'page_info'     => InstantAtriclePageInfos::first(),
     //        'logo'          => $logo,
     //        'category'      => DB::table('category')->orderBy('category.serial_number','asc')
     //                            ->get(),
     //        'aboutUsData'   => AboutUs::first(),
     //        'copyRightData' => CopyRights::first(),
     //        'analyticsCodes'=> AnalyticsCodes::all(),
     //        'socialMedia'   => SocialMedias::get(),
     //        'featuredNews'  => $featuredNews,
     //        'facebook'      => $facebook,
     //        'notice'        => Notice::activeNotice(10),
     //        'photoBlog'     => Articles::idWiseCategoryPost(35,9),
     //        'recentQuiz'    => DB::table('quiz')
     //    ->leftJoin('quiz_category','quiz.quiz_category_id','=','quiz_category.id')
     //    ->where('published_date','<=', date('Y-m-d h:i:s'))
     //    ->where('quiz.show_quiz','=','1')
     //    ->select('quiz.*','quiz_category.quiz_category_name','quiz_category.id as quiz_category_id')
     //    ->orderBy('quiz.id','desc')
     //    ->paginate(9),
     //        );
    	// Session::put('commonData',$commonData);
    }
}
