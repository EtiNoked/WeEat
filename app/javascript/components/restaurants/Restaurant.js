import React from 'react'

export default class Restaurant extends React.Component {
    render() {

        let stars = (no_of_stars) => {
            let starArr = []

            for (let i = 0; i < no_of_stars; i++) {
                starArr.push(<img key={i} id='rating-star' src={'images/star.png'}/>)
            }
            return starArr
        }

        return (
            <button onClick={this.props.onClicked.bind(this, this.props)} className="rest-line">
                <div className="rest-container">
                    <img src={this.props.image_url || 'images/Dinner-Icon.png'} className="rest-icon"/>
                    <div className="rest-padding">
                        <div className="horizontal">
                            <h4 className="rest-info-line rest-name">{this.props.name}</h4>
                            <div>
                                {this.props.ten_bis ? (
                                    <img id='ten-bis-icon' src='images/10bis.png'/>
                                ) : null}
                            </div>
                        </div>
                        <div className="rest-info-line horizontal">
                            <div className='rest-info-line'> {this.props.cuisine} </div>
                            <div id='rating' className='rest-info-line detail-icon'>{stars(this.props.rating)}</div>
                        </div>
                        <div className="rest-info-line">{this.props.address}</div>
                        <div className="rest-info-line">{this.props.delivery_time}</div>
                    </div>
                </div>
            </button>
        );
    }
}