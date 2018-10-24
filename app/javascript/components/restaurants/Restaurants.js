import React from "react"
import Restaurant from 'components/restaurants/Restaurant'
import FilterBar from 'components/restaurants/FilterBar'
import SearchBar from 'components/restaurants/SearchBar'
import InteractiveMap from 'components/restaurants/InteractiveMap'

export class Restaurants extends React.Component {

    constructor() {
        super();
        this.state = {
            forceRender: false,
            filteredValues: {
                ten_bis: '',
                cuisine: '',
                rating: ''
            },
            restaurants: [],
            filteredRests: [],
            focusedRest: null
        }
    }

    filterItems = (val, type) => {
        let filteredValues = this.state.filteredValues;
        filteredValues[type] = val;
        this.setState({filteredValues: filteredValues})
    }

    filterSearchedList = (event) => {
        var updatedList = this.state.restaurants;
        let searchedValue = event.target.value;
        updatedList = updatedList.filter(item => {
            return item.props.name.toLowerCase().search(
                searchedValue.toLowerCase()) !== -1;
        });
        this.setState({filteredRests: updatedList});
    }

    filterProperties = ["ten_bis", "cuisine", "rating"];

    filterList = () => {
        let filteredItems = this.state.filteredRests;
        var filteredValues = this.state.filteredValues;
        this.filterProperties.forEach(function (filterBy) {
            var filterValue = filteredValues[filterBy];
            if (filterValue !== '') {
                filteredItems = filteredItems.filter(function (item) {
                    let itemPropVal = item.props[filterBy];
                    let returnValue;
                    switch (typeof(itemPropVal)) {
                        case 'boolean':
                            returnValue = itemPropVal.toString() === filterValue;
                            break;
                        case 'number':
                            returnValue = itemPropVal === Number(filterValue);
                            break;
                        default:
                            returnValue = itemPropVal === filterValue;
                            break;
                    }
                    return returnValue;
                });
            }
        });
        return filteredItems;
    }

    clearFilters = () => {
        this.filterProperties.forEach(filterBy => {
            let filteredValues = this.state.filteredValues;
            filteredValues[filterBy] = '';
            this.setState({filteredValues: filteredValues});
        });
    }

    onRestaurantClicked = (restaurant) => {
        this.setState({focusedRest: restaurant});
    }

    componentDidMount() {
        fetch('/restaurants').then(results => {
            return results.json();
        }).then(data => {
            let rests = data.map(rest => {
                return (
                    <Restaurant
                        key={rest.id}
                        restaurant_id={rest.id}
                        name={rest.name}
                        cuisine={rest.cuisine_name}
                        image_url={rest.image_url}
                        address={rest.address}
                        rating={rest.rating}
                        delivery_time={rest.delivery_time}
                        ten_bis={rest.ten_bis}
                        latitude={rest.latitude}
                        longitude={rest.longitude}
                        onClicked={this.onRestaurantClicked}
                    />
                )
            });
            this.setState({restaurants: rests, filteredRests: rests});
        })
    }

    render() {
        let filteredList = this.filterList();

        return (
            <div className='container-row rest-padding'>
                <div className='container-column center'>
                    <div className='container-column center'>
                        {this.props.isFilterShown ?
                            <FilterBar
                                clearFilters={this.clearFilters}
                                onFilterChange={this.filterItems}
                                filteredValues={this.state.filteredValues}
                                filteredList={this.state.filteredRests}
                            />
                            : null}
                        {this.props.isSearchShown ? <SearchBar onChange={this.filterSearchedList}/> : null}
                    </div>
                    <div className="container-column">
                        {filteredList}
                    </div>
                </div>
                <InteractiveMap
                    restaurants={filteredList}
                    focusedRest={this.state.focusedRest}
                />
            </div>
        );
    }
}

export default Restaurants
