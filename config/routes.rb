Rails.application.routes.draw do

  resources :restaurants

  root 'restaurants#index'

  get 'restaurants/:id/preview', to: 'restaurants#preview'

  resources :reservations

  devise_for :users, path: 'users', controllers: { sessions: 'users/sessions' }
  # naming routes is supposed to result in: eg. http://localhost:3000/users/sign_in
  # I have some questions/confusion about whether I am correctly overriding routes for users controllers... [some written in EverNote]

  devise_for :customers, path: 'customers', controllers: { sessions: 'customers/sessions' }
  # eg. http://localhost:3000/cutomers/sign_in

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
