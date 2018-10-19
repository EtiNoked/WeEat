import React from "react"
import DynamicBar from 'components/restaurants/DynamicBar'

class SearchBar extends DynamicBar {

    render() {
        return (
            <DynamicBar
                bar={
                    <div id='filter-bar'>
                        search stub
                    </div>
                }
            />
        )
    }
}

export default SearchBar
