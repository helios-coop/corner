# frozen_string_literal: true

Rails.application.routes.draw do
  # Homepage
  root "listings#index"

  resources :listings

  # User Signup, Login, Logout
  get  "/signup" => "users#new"
  post "/users"  => "users#create"
  get  "/login"  => "sessions#new"
  post "/login"  => "sessions#create"
  get  "/logout" => "sessions#destroy"

  # Contact Us
  get  "/contact" => "users#contact"
  post "/contact" => "users#message"

  # Donations
  get "/donate" => "donations#index"

  # Admin pages
  namespace :admin do
    resources :currencies
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
