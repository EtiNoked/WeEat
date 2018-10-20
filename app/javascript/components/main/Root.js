import React from "react"
import PropTypes from "prop-types"
import {BrowserRouter, Route, NavLink} from 'react-router-dom'
import Banner from 'components/main/Banner'
import Menu from 'components/main/Menu'

class Root extends React.Component {
    render() {
        return (
            <div>
                <div className="sans-serif">
                    <Banner/>
                    <Menu/>
                </div>
            </div>
        );
    }
}

export default Root
