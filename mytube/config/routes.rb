Rails.application.routes.draw do

  # get 'user_channels/:id', to: "user_channels#list"

  devise_for :users
  resources :users, :only => [:index, :show]
  root to: 'home#index'

  get 'home/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :channels
  resources :user_channels do
    collection do
      get 'list/:id', to: "user_channels#list"
    end
  end

end
