Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "top#index"
  devise_for :users
  resources :books
  resources :top, only:[:index]
  resources :about, only:[:index]
  resources :users, only:[:index,:show,:edit,:update]
end
