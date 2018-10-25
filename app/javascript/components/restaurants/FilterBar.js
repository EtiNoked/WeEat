import React from "react"
import DynamicBar from 'components/restaurants/DynamicBar'
import {Icon} from 'react-icons-kit'
import {filter, cross} from 'react-icons-kit/icomoon'

class FilterForm extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            cuisineOptions: [],
            tenBisOptions: ['', true, false],
            ratingOptions: ['', 1, 2, 3, 4, 5]
        }
    }

    render() {
        return (
            <div className="container">
                <FilterOptions
                    tenBisOptions={this.state.tenBisOptions}
                    cuisineOptions={this.state.cuisineOptions}
                    ratingOptions={this.state.ratingOptions}
                    changeOption={this.props.onFilterChange}
                    filteredValues={this.props.filteredValues}
                    filteredList={this.props.filteredList}
                />
            </div>
        )
    }
};

let FilterOption = (id, value, options) => {
    return (
        <div id="main-selection" className="rounded shadow">
            <select
                id={id}
                value={value}
                onChange={this.changeOption.bind(this, id)}
            >
                {options.map(function (option) {
                    return (
                        <option key={option} value={option}>
                            {option === true ? 'Accepted' : (option === false) ? 'Not Accpeted' : ''}
                        </option>
                    )
                })}
            </select>
        </div>
    )
}

class FilterOptions extends React.Component {
    changeOption = (type, event) => {
        var val = event.target.value;
        this.props.changeOption(val, type);
    }

    cuisineOptions = () => {
        let cuisines = this.props.filteredList.map(item => {
            return item.props.cuisine
        });
        let uniqueCuisines = cuisines.filter(function(item, pos, self) {
            return self.indexOf(item) == pos;
        });

        uniqueCuisines.unshift("");
        return uniqueCuisines;
    }

    render() {
        const cuisines = this.cuisineOptions();

        return (
            <div className="filter-options">
                <div className="filter-option">
                    <label>10Bis</label>
                    <div id="main-selection" className="rounded shadow">
                        <select
                            id="ten_bis"
                            value={this.props.filteredValues.ten_bis}
                            onChange={this.changeOption.bind(this, 'ten_bis')}
                        >
                            {this.props.tenBisOptions.map(function (option) {
                                return (
                                    <option key={option} value={option}>
                                        {option === true ? 'Accepted' : (option === false) ? 'Not Accpeted' : ''}
                                    </option>
                                )
                            })}
                        </select>
                    </div>
                </div>
                <div className="filter-option">
                    <label>Cuisine</label>
                    <div id="main-selection" className="rounded shadow">
                        <select
                            id="cuisine"
                            value={this.props.filteredValues.cuisine}
                            onChange={this.changeOption.bind(this, 'cuisine')}
                        >
                            {cuisines.map(function (option, index) {
                                return (<option key={index} value={option}>{option}</option>)
                            })}
                        </select>
                    </div>
                </div>
                <div className="filter-option">
                    <label>Rating</label>
                    <div id="main-selection" className="rounded shadow">
                        <select
                            id="rating"
                            value={this.props.filteredValues.rating}
                            onChange={this.changeOption.bind(this, 'rating')}
                        >
                            {this.props.ratingOptions.map(function (option) {
                                return (<option key={option} value={option}>{option}</option>)
                            })}
                        </select>
                    </div>
                </div>
            </div>

        );
    }
}

export default class FilterBar extends DynamicBar {
    render() {
        return (
            <DynamicBar
                bar={
                    <div className="dynamic-bar">
                        <Icon size={25} icon={filter}/>
                        <FilterForm
                            onFilterChange={this.props.onFilterChange}
                            filteredValues={this.props.filteredValues}
                            filteredList={this.props.filteredList}
                        />
                        <button onClick={this.props.clearFilters}>
                            <Icon size={25} icon={cross} style={{color: '#464646'}}/>
                        </button>
                    </div>
                }
            />
        )
    }
}

