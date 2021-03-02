import React, { useState } from 'react';
import './Employee.css'

const Employee = (props) => {
    const { name, picture, salary } = props.employee;
    const fullName = `${name.title}. ${name.first} ${name.last}`;
    const handleSalary = props.handleSalary;
    const handlePopup = props.handlePopup;
    const handlePopupVisible = props.handlePopupVisible;
    const [btnDisable, setBtnDisable] = useState(false);

    return (
        <div className="employee__card">
            <div className="employee__img--box">
                <img src={picture.large} alt={fullName} className="employee__img" />
            </div>
            <div className="employee__info--box">
                <h2 className="employee__name">{fullName}</h2>
                <h3 className="employee__salary">${salary}</h3>
                <div className="employee__btn--box">
                    <button className={btnDisable ? "employee__btn disabled" : "employee__btn"} onClick={() => {
                        handleSalary(props.employee);
                        setBtnDisable(true);
                    }}>Pay salary</button>
                    <button className="employee__btn" onClick={() => {
                        handlePopup(props.employee);
                        handlePopupVisible();
                    }}>More details</button>
                </div>
            </div>
        </div>
    );
};

export default Employee;