Rails.application.routes.draw do
  # Homepage
  root "listings#index"

  resources :listings

  # User Signup and Authentication
  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
