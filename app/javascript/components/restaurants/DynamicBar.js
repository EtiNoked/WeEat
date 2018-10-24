import React from "react"

class DynamicBar extends React.Component {
    constructor() {
        super()
        this.state = {
            isVisible: true
        }
    }

    toggleVisible () {
        this.setState({
            isVisible: !this.state.isVisible
        })
    }

    dynamicBar = () => {
        return (this.state.isVisible ? this.props.bar : null)
    }

    render() {
        return (
            <div className='dynamic-bar'>
                {this.dynamicBar()}
            </div>
        )
    }
}

export default DynamicBar
