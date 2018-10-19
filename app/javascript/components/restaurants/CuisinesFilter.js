import React from "react"

class CuisinesFilter extends React.Component {

    componentDidMount() {

        fetch('http://localhost:3000/restaurants').then( results => {
            return results.json();
        }).then(data => this.mapRestaurants(data))
    }

  render () {
    return (
      <React.Fragment>
      </React.Fragment>
    );
  }
}

export default CuisinesFilter
