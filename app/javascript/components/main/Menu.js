import React from "react"
import {BrowserRouter, NavLink, Switch, Route} from 'react-router-dom'
import {Icon} from 'react-icons-kit'
import {filter, search} from 'react-icons-kit/icomoon'

import SearchBar from 'components/restaurants/SearchBar'

class ToggledButton extends React.Component {
    constructor() {
        super()
        this.state = {
            isActive: false
        }
    }

    getIcon = () => {
        return (
            this.props.icon == 'filter' ? filter : (
                this.props.icon == 'search' ? search : null
            )
        )
    }

    toggleActivation = () => {
        this.setState({isActive: !this.state.isActive});
        this.props.handler();
    }

    render() {
        let icon = this.getIcon();
        return (
            <button
                id={this.props.button_id}
                style={{color: this.state.isActive ? 'orange' : 'white'}}
                onClick={this.toggleActivation}
            >
                <Icon size={28} icon={icon}/>
            </button>
        )
    }
}

class Menu extends React.Component {

    toggleSearch = () => {
        this.props.toggleSearchHandler();
    }

    toggleFilter = () => {
        this.props.toggleFilterHandler();
    }

    searchFilterButtons = () => {
        return (
            this.props.selectedMenu === "Restaurants" ? (
                <ul className='navigation right'>
                    <li>
                        <ToggledButton id='filter-button' icon='filter' handler={this.toggleFilter}/>
                    </li>
                    <li>
                        <ToggledButton id='search-button' icon='search' handler={this.toggleSearch}/>
                    </li>
                </ul>
            ) : null
        )
    }

    render() {

        let buttons = this.searchFilterButtons();

        return (
            <div id='menu'>
                <div>
                    <ul className='navigation left'>
                        {this.props.linksMarkup}
                    </ul>
                </div>
                <div>
                    {buttons}
                </div>
            </div>
        );
    }
}

export default Menu
