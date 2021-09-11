Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'registrations' }
  root to: 'home#top'
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy]

  get  "home/about"  => "home#about"

  resources :users, only: [:index, :show, :edit, :update]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
