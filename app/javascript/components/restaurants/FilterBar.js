import React from "react"
import DynamicBar from 'components/restaurants/DynamicBar'

class FilterBar extends DynamicBar {

    render() {
        return (
            <DynamicBar
              bar={
                <div id='filter-bar'>
                  filter stub
                </div>
              }
            />
        )
    }
}

export default FilterBar
