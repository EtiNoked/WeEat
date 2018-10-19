import React from "react"
import {NavLink} from 'react-router-dom'
import {MdSearch} from 'react-icons/md'
import {TiFilter} from 'react-icons/ti'
import { Icon } from 'react-icons-kit'
import { filter, search } from 'react-icons-kit/icomoon'

import SearchBar from 'components/restaurants/SearchBar'

class ToggleButton extends React.Component {
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
        this.setState({isActive: !this.state.isActive})
    }

    render() {
        let icon = this.getIcon();
        return (
            <button
                id={this.props.button_id}
                style={{color: this.state.isActive? 'orange' : 'white'}}
                onClick={this.toggleActivation}
            >
                <Icon size={28} icon={icon}/>
            </button>
        )
    }
}

class Menu extends React.Component {

    constructor() {
        super();
        this.state = {
            selectedMenu: "Home"
        }
    }

    setSelectedMenu = (lable) => {
        this.setState({selectedMenu: lable});
    }

    searchFilterButtons = () => {
        return (
            this.state.selectedMenu === "Restaurants" ? (
                <ul className='navigation right'>
                    <li>
                        <ToggleButton id='filter-button' icon='filter'/>
                    </li>
                    <li>
                        <ToggleButton id='search-button' icon='search'/>
                    </li>
                </ul>
            ) : null
        )
    }

    render() {
        let linksMarkup = this.props.links.map((link, index) => {
            return (
                <li key={index}>
                    <NavLink
                        activeStyle={{
                            fontWeight: "bold",
                            color: "orange"
                        }}
                        exact to={link.link}
                        onClick={this.setSelectedMenu.bind(this, link.lable)}
                    >
                        {link.lable}
                    </NavLink>
                </li>
            )
        })

        let buttons = this.searchFilterButtons();

        return (
            <div id='menu'>
                <div>
                    <ul className='navigation left'>
                        {linksMarkup}
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
