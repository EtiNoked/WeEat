import React from "react"
import Restaurant from 'components/restaurants/Restaurant'
import FilterBar from 'components/restaurants/FilterBar'
import SearchBar from 'components/restaurants/SearchBar'
import 'stylesheets/restaurants.css'

const queryString = require('query-string');

export class Restaurants extends React.Component {

    constructor() {
        super();
        this.state = {
            forceRender: false,
            restaurants: []
        }
    }

    mapRestaurants = (data) => {
        return data.map(rest => {
            return (
                <Restaurant
                    key={rest.id}
                    name={rest.name}
                    cuisine={rest.cuisine_name}
                    image_url={rest.image_url}
                    address={rest.address}
                    rating={rest.rating}
                    delivery_time={rest.delivery_time}
                    ten_bis={rest.ten_bis}
                />
            )
        });
    }

    componentDidMount() {

        fetch('http://localhost:3000/restaurants').then(results => {
            return results.json();
        }).then(data => {
            let rests = this.mapRestaurants(data);
            this.setState({restaurants: rests});
        })
    }

    isSearchShown = () => {
        return queryString.parse(this.props.location.search, {ignoreQueryPrefix: true}).search;
    }

    render() {

        return (
            <div className='container-column'>
                <div className='container-row'>
                    {this.props.isSearchShown ? <SearchBar/> : null}
                    {this.props.isFilterShown ? <FilterBar/> : null}
                </div>
                <div className="container-column">
                    {this.state.restaurants}
                </div>
            </div>
        );
    }
}

export default Restaurants
