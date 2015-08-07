Rails.application.routes.draw do

  root 'appliances#index'

  resources :targets, only: [:index, :show, :update]
  resources :appliances, only: [:index, :show]

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :appliances, only: [:index, :show]
      resources :targets, only: [:index, :show, :update]
    end
  end
end
