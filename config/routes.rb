Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'registrations' }
  root to: 'home#top'
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  get "home/about" => "home#about"

  get "search" => "searches"

  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy] do
      # users/:user_id/relarionships/follows　みたいにしたい
      member do
        get 'follows'
        get 'followers'
      end
    end
  end

  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]
  resources :groups, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resource :group_users, only: [:create, :destroy]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
