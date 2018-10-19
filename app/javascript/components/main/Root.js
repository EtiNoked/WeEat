import React from "react"
import PropTypes from "prop-types"
import Banner from 'components/main/Banner'
import Menu from 'components/main/Menu'
import Restaurants from 'components/restaurants/Restaurants'


class Root extends React.Component {

  render () {
      const links = [
          { lable: 'Home', link: '/' },
          { lable: 'About', link: '/about' },
          { lable: 'Restaurants', link: '/restaurants' }
      ];

    return (
      <div>
        <Banner />
        <Menu links={links}/>
      </div>
    );
  }
}

export default Root
