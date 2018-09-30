# frozen_string_literal: true

Rails.application.routes.draw do

  root :to => 'restaurant#index'

  resources :restaurant do
    member do
      get :delete
    end
  end

  resources :cuisine do
    member do
      get :delete
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
