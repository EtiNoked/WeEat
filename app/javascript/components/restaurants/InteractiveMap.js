import React, {Component} from 'react';
import GoogleMapReact from 'google-map-react';
import {Icon} from 'react-icons-kit'
import {location} from 'react-icons-kit/icomoon/location'


const RestaurantMarker = ({name}) =>
    <div>
        <Icon size={25} icon={location} style={{color: 'red'}}/>
        <div style={{fontWeight: 'bold'}}>{name}</div>
    </div>;

const RestaurantLabel = ({rest}) =>
    <div className='restaurant-details-div'>
        <div className='rest-name'>{rest.name}</div>
        <div>{rest.cuisine_name}</div>
        <div>{rest.address}</div>
    </div>;

export default class InteractiveMap extends Component {

    static defaultProps = {
        center: {
            lat: 40.7,
            lng: -73.9
        },
        zoom: 11
    };

    markers = () => {
        return this.props.restaurants.map((rest, index) => {
            let name = (this.props.focusedRest
                && this.props.focusedRest.restaurant_id === rest.props.restaurant_id)
                ? "" : rest.props.name;

            return (
                <RestaurantMarker
                    key={index}
                    lat={rest.props.latitude}
                    lng={rest.props.longitude}
                    name={name}
                />
            )
        });
    };

    zoomOnRest = () => {
        const lat = this.props.focusedRest ? this.props.focusedRest.latitude : null;
        const lng = this.props.focusedRest ? this.props.focusedRest.longitude : null;
        const focusedRest = this.props.focusedRest ? (
            <RestaurantLabel
                lat={lat}
                lng={lng}
                rest={this.props.focusedRest}
            />
        ) : null;

        return ({
            center: focusedRest ? ({
                lat: lat,
                lng: lng
            }) : null,
            zoom: focusedRest ? 15 : null,
            focusedRest: focusedRest
        });

    };

    render() {
        const markers = this.markers();
        const zoomInfo = this.zoomOnRest();
        return (
            // Important! Always set the container height explicitly
            <div className='map-container'>
                <GoogleMapReact
                    bootstrapURLKeys={{key: "AIzaSyCgtxZUekCAg5pGCh-lpncLT91Qpwk4TBU"}}
                    defaultCenter={this.props.center}
                    defaultZoom={this.props.zoom}
                    center={zoomInfo.center}
                    zoom={zoomInfo.zoom}
                >
                    {zoomInfo.focusedRest}
                    {markers}
                </GoogleMapReact>
            </div>
        );
    }
}