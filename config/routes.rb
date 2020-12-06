Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "top#index"
  get  "home"  => "home#index"
  get  "home/about"  => "home#about"
  resources :books do
    resources :book_comments, only:[:index,:create,:edit,:destroy,:update]
    resource :favorites, only:[:create,:destroy]
  end
  resources :top, only:[:index]
  resources :users, only:[:index,:show,:edit,:update]
end
