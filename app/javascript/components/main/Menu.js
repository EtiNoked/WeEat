import React from "react"
import {NavLink} from 'react-router-dom'
import {MdSearch} from 'react-icons/md'
import {TiFilter} from 'react-icons/ti'

import SearchBar from 'components/restaurants/SearchBar'

class Menu extends React.Component {

    constructor() {
        super();
        this.state = {
            selectedMenu: "Home"
        }
    }

    setSelectedMenu = (lable) => {
        console.error("lable: " + lable)
        this.setState({selectedMenu: lable});
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

        let additionalButtons = this.props.children ?
            this.props.children.map((child, index) => {
                return (
                    <li>
                        child
                    </li>
                )
            }) : null

        return (
            <div id='menu'>
                <div>
                    <ul className='navigation left'>
                        {linksMarkup}
                    </ul>
                </div>
                <div>
                    {
                        this.state.selectedMenu === "Restaurants" ? (
                            <ul className='navigation right'>
                                <li>
                                    <button id='search-button'><TiFilter color='white' size={30}/></button>
                                </li>
                                <li>
                                    <button id='search-button'><MdSearch color='white' size={30}/></button>
                                </li>
                            </ul>
                        ) : null
                    }
                </div>
            </div>
        );
    }
}

export default Menu
