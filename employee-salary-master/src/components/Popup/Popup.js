import React from 'react';
import './Popup.css';

const Popup = (props) => {
    const { popupPerson, popupVisible, handlePopupVisible } = props;
    if (!popupVisible) {
        return '';
    }
    const { name, gender, dob, email, location, picture, salary } = popupPerson;
    const fullName = `${name.title}. ${name.first} ${name.last}`;
    const age = dob.age;
    const { city, country } = location;

    return (
        <div className="employee__popup">
            <div className="popup">
                <div className="popup__card">
                    <div className="popup__img--box">
                        <img src={picture.large} alt={fullName} className="popup__img" />
                    </div>
                    <div className="popup__info--box">
                        <h2 className="popup__name">{fullName}</h2>
                        <table className="popup__table">
                            <tbody>
                                <tr>
                                    <td>Gender</td>
                                    <td>{gender}</td>
                                </tr>
                                <tr>
                                    <td>Age</td>
                                    <td>{age}</td>
                                </tr>
                                <tr>
                                    <td>Salary</td>
                                    <td>${salary}</td>
                                </tr>
                                <tr>
                                    <td>Email</td>
                                    <td>{email}</td>
                                </tr>
                                <tr>
                                    <td>City</td>
                                    <td>{city}</td>
                                </tr>
                                <tr>
                                    <td>Country</td>
                                    <td>{country}</td>
                                </tr>
                            </tbody>
                        </table>
                        <div className="popup__btn--box">
                            <button className="popup__btn" onClick={handlePopupVisible}>Go back</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default Popup;