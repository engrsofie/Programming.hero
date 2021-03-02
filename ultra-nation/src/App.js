import logo from './logo.svg';
import './App.css';
import { useEffect, useState } from 'react';
import Country from './components/Country/Country';

function App() {
  const [countrys, setCountrys] = useState([]);
useEffect (()=>{
  fetch("https://restcountries.eu/rest/v2/all")
    .then((res) => res.json())
    .then((data) => {

      setCountrys(data);
      data.map(country => country.name)
    })
 
}, [])

  return (
    <div className="App">
     
      <ul>
        {
        countrys.map(country => <Country country={country}>{country}</Country>)
        }
      </ul>
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}

export default App;
