
// github link :  https://github.com/anisur770/assignment-3/blob/main/assignment-3.js
// namber-1 : kilometerToMeter
function kilometerToMeter (kilometer){

    var meter = kilometer * 1000;
    return meter;
}
var permeter = kilometerToMeter(8);
console.log("Kilometer to Meter calculator Result:", permeter);
//  number 2 : budgetCalculator
function budgetCalculator(ghori, phone, laptop){
    var ghoriTotalCost  =  ghori * 50;
    var phoneTotalCost  =  phone * 100;
    var laptopTotalCost  = laptop * 500;
    return  total = ghoriTotalCost + phoneTotalCost + laptopTotalCost;
   }
   var totalcost =  budgetCalculator ( 2,3,4);
   console.log ( "Total  Budget (ghori/phone/leptop ) : ", totalcost ,"$");
 
//    nember -3 :  hotelCost
function hotelCost(day){
    var totalday = 0;
    if( day <=10){
        totalday= day*100;
    }
    else if ( day <= 20){
        var firstTenDay = 10 * 100;
        var remaining = day - 10;
        var secondTenDay  =remaining *  80;
        totalday = firstTenDay + secondTenDay;
    }
    else {
        var firstTenDay = 10 * 100;
        var secondTenDay = 10 *  80;
        var remaining = day - 20;
        var thirtTenDay = remaining * 50;
        totalday = firstTenDay + secondTenDay + thirtTenDay;
    
    }
    return totalday;

}
var count = hotelCost (25);
var result = count;
console.log ("Totaly Hotel cost:", result, "$");
// number -4 : megaFriend

function megaFriend(friend) {
    var max = friend[0];
    for (var i = 0; i < friend.length; i++) {
        var elment = friend[i];
        if (elment.length > max.length) {
            max = elment;
        }
        
    }
    return max;
}

// var friend = ["Anas", "Sohel", "Rejaul", "Roy"];
var megaFriendName = megaFriend(["Anas", "Sohel", "Rejaul", "Roy"]);
console.log("Mega name of fridnds:", megaFriendName);
