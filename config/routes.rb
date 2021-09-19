Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'registrations' }
  root to: 'home#top'
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  get  "home/about"  => "home#about"

  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy] do
      #users/:user_id/relarionships/follows　みたいにしたい
      member do
        get 'follows'
        get 'followers'
      end
    end
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
