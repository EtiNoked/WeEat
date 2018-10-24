import React, {Component} from 'react';
import GoogleMapReact from 'google-map-react';
import {Icon} from 'react-icons-kit'
import {location} from 'react-icons-kit/icomoon/location'


const RestaurantMarker = ({name}) =>
    <div>
        <Icon size={25} icon={location} style={{color: 'red'}}/>
        <div style={{fontWeight: 'bold'}}>{name}</div>
    </div>;

class InteractiveMap extends Component {
    static defaultProps = {
        center: {
            lat: 40.7,
            lng: -73.9
        },
        zoom: 11
    };

    markers = () => {
        return this.props.restaurants.map((rest, index) => {
            return (
                <RestaurantMarker
                    key={index}
                    lat={rest.props.latitude}
                    lng={rest.props.longitude}
                    name={rest.props.name}
                />
            )
        });
    }

    render() {
        let markers = this.markers();
        return (
            // Important! Always set the container height explicitly
            <div className='map-container'>
                <GoogleMapReact
                    bootstrapURLKeys={{key: "AIzaSyCgtxZUekCAg5pGCh-lpncLT91Qpwk4TBU"}}
                    defaultCenter={this.props.center}
                    defaultZoom={this.props.zoom}
                >
                    {markers}
                </GoogleMapReact>
            </div>
        );
    }
}

export default InteractiveMap;