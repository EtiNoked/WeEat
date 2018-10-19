/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import React from 'react'
import ReactDOM from 'react-dom'
import Root from 'components/main/Root'
import Restaurants from 'components/restaurants/Restaurants'
import About from 'components/main/About'
import { BrowserRouter, Route } from 'react-router-dom'

document.addEventListener('DOMContentLoaded', () => {

    const App = () => (
        <BrowserRouter>
            <div className="sans-serif">
                <Route path="/" component={Root} />
                <Route path="/restaurants" component={Restaurants} />
                <Route path="/about" component={About} />
            </div>
        </BrowserRouter>
    );

    ReactDOM.render(
        <App />,
        document.body.appendChild(document.createElement('div'))
    )
})