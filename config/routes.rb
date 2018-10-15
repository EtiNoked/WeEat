# frozen_string_literal: true

Rails.application.routes.draw do

  root :to => 'restaurants#index'

  resources :restaurants, defaults: {format: :json}
  resources :cuisines
  resources :reviews

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
