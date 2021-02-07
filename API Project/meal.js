document.getElementById('search-btn').addEventListener(
    'click', () => {
    const mealName = document.getElementById('input-field').value;
    fetch(`https://www.themealdb.com/api/json/v1/1/search.php?s=${mealName}`)
      .then((res) => res.json())
      .then((data) => displayMeals(data.meals))
      .catch((error) => alert("no meals found"));
    }
)
const displayMeals = meal => {

    const ul = document.getElementById("meals-container");
    for (let i = 0; i < meal.length; i++) {
        const food = meal[i];
        let foodList = document.createElement('div');
        foodList.className = "meal-container";
        foodList.innerHTML = `
            <img src= '${food.strMealThumb}'>
            <h3>${food.strMeal}</h3>
            <button onclick="foodListDetails(${food.idMeal})">Show details</button>
        `;
       
        ul.appendChild(foodList);
    }
}

const foodListDetails = name => {
    const url = `https://www.themealdb.com/api/json/v1/1/lookup.php?i=${name}`;
    fetch(url)
    .then(res => res.json())
    .then(data => {
        foodInfo(data.meals[0]);
    })
}
const foodInfo = food => {
    console.log(food);
    const foodDiv = document.getElementById("food-details");
    foodDiv.innerHTML = `
        <img  src="${food.strMealThumb}" alt="Card image cap">
        <h4>${food.strMeal}</h4>
        <li>${food.strIngredient1}</li>
        <li>${food.strIngredient2}</li>
        <li>${food.strIngredient3}</li>
        <li>${food.strIngredient4}</li>
        <li>${food.strIngredient5}</li>
    `;
    
}