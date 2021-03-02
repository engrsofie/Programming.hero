import React from 'react';
import './Header.css';

const Header = () => {
    return (
        <header className="header">
            <div className="navbar">
                <div className="container">
                    <nav className="navbar__nav">
                        <h2 className="navbar__logo">Employee Salary</h2>
                    </nav>
                </div>
            </div>
        </header>
    );
};

export default Header;