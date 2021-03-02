@extends('layout.app')
    @section('content')
    <style type="text/css">
    .card { border-radius: 4px; box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05), 0 0 0 1px rgba(63, 63, 68, 0.1); background-color: #FFFFFF; margin-bottom: 30px; width: 100%; overflow: hidden; padding: 10px;}
    .card .image img {width: 100%;}
    .author{width: 50%; margin: 0 auto; text-align: center;}
    .author img{width: 100%; height: auto;}
    </style>
    @if(isset($getMyProfile))

    <div id="content" class="content">
        <div class="row">
            <div class="col-md-8">
                <div class="card">
                    <div class="header">
                        <h4 class="title">My Profile</h4>
                    </div>
                    <hr>
                        <form>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Name</label>
                                        <input type="text" class="form-control" value="{{$getMyProfile->name}}" readonly="readonly">
                                    </div>        
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Gender</label>
                                        <input type="text" class="form-control" value="{{ $getMyProfile->gender }}" readonly="readonly">
                                    </div>        
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Email</label>
                                        <input type="text" class="form-control" value="{{ $getMyProfile->email }}" readonly="readonly">
                                    </div>        
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Phone Number</label>
                                        <input type="text" class="form-control" value="{{ $getMyProfile->phone_number }}" readonly="readonly">
                                    </div>        
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Address</label>
                                        <input type="text" class="form-control" value="{{ $getMyProfile->address }}" readonly="readonly">
                                    </div>        
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Country Name</label>
                                        <input type="text" class="form-control" value="{{ $getMyProfile->country_name }}" readonly="readonly">
                                    </div>        
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>City Name</label>
                                        <input type="text" class="form-control" value="{{ $getMyProfile->city_name }}" readonly="readonly">
                                    </div>        
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Zip Code</label>
                                        <input type="text" class="form-control" value="{{ $getMyProfile->zip_code }}" readonly="readonly">
                                    </div>        
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Division</label>
                                        <input type="text" class="form-control" value="{{ $getMyProfile->division }}" readonly="readonly">
                                    </div>        
                                </div>
                            </div>
                            
                            <?php $userId = Auth::user()->id; ?>
                            <a href='{{ URL::to("my-profile/$userId/edit")}}' class="btn btn-info btn-fill pull-right">Update Profile</a>
                            <div class="clearfix"></div>
                        </form>
                    
                </div>
            </div>
            <div class="col-md-4">
                <div class="card card-user">
                    
                    <div class="">
                        <div class="author">
                             <a href="#">
                            <img class="avatar border-gray" src='images/users/{{$getMyProfile->profile_image}}' alt="..."/>
                           
                              <h4 class="title">{{ $getMyProfile->name }}<br />
                                 
                              </h4>
                            </a>
                        </div> 
                    </div>
                    <hr>
                    
                </div>
            </div>
        </div>                    
    </div>

@endif
<script src="{{asset('public/plugins/jquery/jquery-1.9.1.min.js')}}"></script>           

<script type="text/javascript">
    $(document).ready(function() {
        App.init();
        DashboardV2.init();
        //
    });
    //

</script>


@endsection