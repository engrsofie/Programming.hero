import React from 'react';
import './Salary.css';

const Salary = (props) => {
    const { paid } = props;
    const paidEmployee = props.paid.length;
    const totalPaidAmount = paid.reduce((total, amount) => total + amount.salary, 0);

    return (
        <div className="salary__card">
            <h2 className="salary__summary">Summary</h2>
            <table className="salary__table">
                <tbody>
                    <tr>
                        <td>Paid Employee:</td>
                        <td>{paidEmployee}</td>
                    </tr>
                    <tr>
                        <td>Total Paid:</td>
                        <td>${totalPaidAmount}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    );
};

export default Salary;