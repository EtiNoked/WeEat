import React from "react"
import {BrowserRouter, NavLink, Switch, Route} from 'react-router-dom'
import {Icon} from 'react-icons-kit'
import {filter, search} from 'react-icons-kit/icomoon'
import About from 'components/main/About'
import Restaurants from 'components/restaurants/Restaurants'

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
                style={{color: this.props.isActive ? 'orange' : 'white'}}
                onClick={this.toggleActivation}
            >
                <Icon size={28} icon={icon}/>
            </button>
        )
    }
}

class Menu extends React.Component {
    constructor() {
        super()
        this.state = {
            isSearchActive: false,
            isFilterActive: false,
            selectedMenu: 'Home'
        }
    }

    setSelectedMenu = (lable) => {
        this.setState({selectedMenu: lable});
    }

    toggleSearchBar = () => {
        this.setState({isSearchActive: !this.state.isSearchActive})
    }

    toggleFilterBar = () => {
        this.setState({isFilterActive: !this.state.isFilterActive})
    }

    searchFilterButtons = () => {
        return (

            this.state.selectedMenu === "Restaurants" ? (
                <ul className='navigation right'>
                    <li>
                        <ToggledButton
                            id='filter-button'
                            icon='filter'
                            isActive={this.state.isFilterActive}
                            handler={this.toggleFilterBar}
                        />
                    </li>
                    <li>
                        <ToggledButton
                            id='search-button'
                            icon='search'
                            isActive={this.state.isSearchActive}
                            handler={this.toggleSearchBar}
                        />
                    </li>
                </ul>
            ) : null
        )
    }

    render() {

        let buttons = this.searchFilterButtons();

        const links = [
            {lable: 'Home', link: '/'},
            {lable: 'About', link: '/about'},
            {lable: 'Restaurants', link: '/restaurants'}
        ];

        const linksMarkup = links.map((link, index) => {
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

        return (
            <div>
                <div>
                    <BrowserRouter>
                        <div>
                            <div id='menu' className='horizontal-bar'>
                                <ul className='navigation left'>
                                    {linksMarkup}
                                </ul>
                                <div>
                                    {buttons}
                                </div>
                            </div>
                            <div className='content-container'>
                                <Route
                                    exact path="/restaurants"
                                    render={(props) =>
                                        <Restaurants
                                            isSearchShown={this.state.isSearchActive}
                                            isFilterShown={this.state.isFilterActive}
                                            {...props}
                                        />
                                    }
                                />
                                <Route path="/about" component={About}/>
                            </div>
                        </div>
                    </BrowserRouter>
                </div>
            </div>
        );
    }
}

export default Menu
