Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  root 'home#index'
  
  mount API::API => '/'
end
