import React from "react"

class DynamicBar extends React.Component {
    constructor() {
        super()
        this.state = {
            isVisibile: true
        }
    }

    toggleVisible () {
        this.setState({
            isVisibile: !this.state.isVisibile
        })
    }

    dynamicBar = () => {
        return (this.state.isVisibile ? (
                this.props.bar
            ) : null
        )
    }

    render() {
        return (
            <div>
                {this.dynamicBar()}
            </div>
        )
    }
}

export default DynamicBar
