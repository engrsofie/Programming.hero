import React, { useEffect, useState } from 'react';
import logo from './logo.svg';
import './App.css';

function App() {
const nayoks = ['Manna', 'Rubel', 'Riyaz', 'Dipjol']
const friends = ['Nuhu', 'Nadim', 'Shamim', 'Anwar', 'Asadul']

const friendsName = friends.map(friend=>friend);



const products = [
  { name: "Photoshop", price: "$99.00" },
  { name: "Illistrator", price: "80.00" },
  { name: "Adobe Reader", price: "50.00" }
]



  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <Counter></Counter>
        <Users> </Users>
        <ul>
          {nayoks.map((nayok) => (
            <li>{nayok}</li>
          ))}
          <li>{nayoks[0]}</li>
          <li>{nayoks[1]}</li>
          <li>{nayoks[2]}</li>
          <li>{nayoks[3]}</li>
          <li>{friends[0]}</li>
          <li>{friends[1]}</li>
          <li>{friends[2]}</li>
          <li>{friends[3]}</li>
          <li>{friends[4]}</li>
        </ul>

        <Product product={products[0]}></Product>
        <Product product={products[1]}></Product>
        <Product product={products[2]}></Product>
      </header>
    </div>
  );
}

function Counter(){
  const [count, setCount] = useState(10);
  const handleIncrease = () => setCount(count + 1);
  
  return (
    <div>
      <h1>Count: {count}</h1>
      <button onClick={handleIncrease}>Incrase</button>
    </div>
  );
}
function Users() {
  const [user, setUsers] = useState([]);
  useEffect(()=>{
  fetch("https://jsonplaceholder.typicode.com/users")
  .then(res => res.json())
  .then(data => setUsers(data))
  },[])
  return(
<div>
  <h3>Dynamic user: {user.length}</h3>
 <ul>
   {
     user.map(user=> <li>{user.name}</li>)
   }
 </ul>
</div>

  )
}


function Product(props) {
  const productStyle = { 
  border: "5px solid yellow", 
  borderRadius:"15px",
  backgroundColor:"lightgray",
  height: "300px",
  width: "300px",
  float: "left",
   margin: "10px" 
  }
  const {name, price} = props.product;

  return (
    <div style={productStyle}>
      <h2>{name}</h2>
      <p>{price}</p>
      <button>Buy now</button>
    </div>
  );
}

export default App;
