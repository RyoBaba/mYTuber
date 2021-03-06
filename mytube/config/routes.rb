Rails.application.routes.draw do

  # get 'user_channels/:id', to: "user_channels#list"

  devise_for :users
  resources :users, :only => [:index, :show]
  root to: 'home#index'

  get 'home/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :channels, only: %w(show new create) do
    collection do
      get ':id/:year/',       to: "channels#back_number"
      get ':id/:year/:month', to: "channels#back_number"
    end
  end
  resources :user_channels, except: %w(destroy) do
    collection do
      get 'list/:user_id',  to: "user_channels#list"
      get 'refresh/:id',    to: "user_channels#refresh"
    end
  end

end
