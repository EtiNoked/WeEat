# frozen_string_literal: true

Rails.application.routes.draw do

  root :to => 'restaurants#index'

  resources :restaurants do
    member do
      get :delete
    end
  end

  resources :cuisines do
    member do
      get :delete
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
