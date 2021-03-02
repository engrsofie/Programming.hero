import React, { useEffect, useState } from 'react';
import Employee from '../Employee/Employee';
import Popup from '../Popup/Popup';
import Salary from '../Salary/Salary';
import './EmployeeSalary.css';

const EmployeeSalary = () => {
    const [employees, setEmployees] = useState([]);
    const [paid, setPaid] = useState([]);
    const [popupPerson, setPopupPerson] = useState({});
    const [popupVisible, setPopupVisible] = useState(false);

    useEffect(() => {
        fetch('https://api.mocki.io/v1/17be48c3')
            .then(res => res.json())
            .then(data => setEmployees(data))
    }, [])

    const handleSalary = salary => setPaid([...paid, salary]);
    const handlePopup = person => setPopupPerson(person);
    const handlePopupVisible = () => setPopupVisible(!popupVisible);

    return (
        <main>
            <section className="emloyee__salary">
                <div className="container">
                    <div className="employee__salary--inner">
                        <div className="employee">
                            {
                                employees.map(employee => <Employee employee={employee} handleSalary={handleSalary} handlePopup={handlePopup} handlePopupVisible={handlePopupVisible} key={employee.login.username} />)
                            }
                        </div>
                        <div className="salary">
                            <Salary paid={paid} />
                        </div>
                        <Popup popupPerson={popupPerson} popupVisible={popupVisible} handlePopupVisible={handlePopupVisible} />
                    </div>
                </div>
            </section>
        </main>
    );
};

export default EmployeeSalary;