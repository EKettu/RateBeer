Rails.application.routes.draw do
  resources :styles
  resources :memberships
  resources :beer_clubs
  resources :users
  resources :beers
  resources :breweries
  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :places, only: [:index, :show]
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  resources :users do
    post 'toggle_account', on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'breweries#index'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  # get 'places', to: 'places#index'
  post 'places', to:'places#search'
  get 'beerlist', to:'beers#list'
  get 'brewerylist', to:'breweries#list'

  #get 'kaikki_bisset', to: 'beers#index'
 # get 'ratings', to: 'ratings#index'
 # get 'ratings/new', to:'ratings#new'
 # post 'ratings', to: 'ratings#create'
end


