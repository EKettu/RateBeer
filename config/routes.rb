Rails.application.routes.draw do
  resources :users
  resources :beers
  resources :breweries
  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'breweries#index'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  #get 'kaikki_bisset', to: 'beers#index'
 # get 'ratings', to: 'ratings#index'
 # get 'ratings/new', to:'ratings#new'
 # post 'ratings', to: 'ratings#create'
end


