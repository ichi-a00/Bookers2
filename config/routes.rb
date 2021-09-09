Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy]

  get  "homes/about"  => "homes#about"
  resources :users, only: [:index,:show]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
