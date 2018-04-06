Rails.application.routes.draw do
  
  resources :reservations
  devise_for :customers
  devise_for :users
  root 'restaurants#index'

  resources :restaurants
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'restaurants/:id/preview', to: 'restaurants#preview'

end
