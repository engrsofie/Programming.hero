//  kilometerToMeter

function kilometerToMeter (kilometer){

    var meter = kilometer * 1000;
    return meter;
}
var permeter = kilometerToMeter(3);
console.log(permeter);


//  budgetCalculator
function budgetCalculator (watch, phone, leptop){
var watchTotalCost = watch * 50;
var phoneTotalCost = phone * 80;
var leptopTotalCost = leptop * 100;
return total = watchTotalCost+phoneTotalCost+leptopTotalCost;
}
var totalcost = budgetCalculator(5, 7, 9)
console.log(totalcost);

// hotelCost

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
var count = hotelCost (28);
var result = count;
console.log (result);


// megafriend

function megafriend(friend) {
    var max = friend[0];
    for (var i = 0; i < friend.length; i++) {
        var elment = friend[i];
        if (elment.length > max.length) {
            max = elment;
        }
        
    }
    return max;
}

var friend = ["nadim", "sany", "abdullah", "shehab"];
var bigfriend = megafriend(["nadim", "sany", "abdullah", "shehab"]);
console.log(bigfriend);
