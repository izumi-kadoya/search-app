Rails.application.routes.draw do
  resources :scraps, only: [:index, :create]
  resources :searches, only: [:index, :create]
  root to: 'scraps#index'
end
