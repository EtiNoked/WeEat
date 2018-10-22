import React from "react"
import DynamicBar from 'components/restaurants/DynamicBar'
import {Icon} from 'react-icons-kit'
import {search, cross} from 'react-icons-kit/icomoon'

class SearchBar extends DynamicBar {

    render() {
        return (
            <DynamicBar
                bar={
                    <div className="dynamic-bar">
                        <Icon size={25} icon={search}/>
                        <input
                            id='search-input-bar'
                            className='rounded shadow'
                            placeholder="Search Restaurant"
                            onChange={this.props.onChange} />
                    </div>
                }
            />
        )
    }
}

export default SearchBar
