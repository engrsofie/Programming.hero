import React from 'react';

const Country = (props) => {
    const {name, population, region, flag} = props.country;
    const flagStyle = {height:'80px'}
    return (
      <div>
        <h2>Country Name :  {name}</h2>
        <img style={flagStyle} src={flag} alt="" />
        <h4>Population: {population}</h4>
        <h4>
          {" "}
          <small> Region : {region}</small>
        </h4>
      </div>
    );
};

export default Country;