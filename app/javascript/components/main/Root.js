import React from "react"
import PropTypes from "prop-types"
import {BrowserRouter, Route, NavLink} from 'react-router-dom'
import Banner from 'components/main/Banner'
import Menu from 'components/main/Menu'
import About from 'components/main/About'
import Restaurants from 'components/restaurants/Restaurants'

class Root extends React.Component {
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

    render() {
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
                <BrowserRouter>
                    <div className="sans-serif">
                        <Banner/>
                        <Menu
                            selectedMenu={this.state.selectedMenu}
                            linksMarkup={linksMarkup}
                            toggleSearchHandler={this.toggleSearchBar}
                            toggleFilterHandler={this.toggleFilterBar}
                        />
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
                </BrowserRouter>
            </div>
        );
    }
}

export default Root
