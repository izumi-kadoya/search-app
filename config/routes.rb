Rails.application.routes.draw do
  resources :searches, only: [:index, :create]
  root to: 'searches#index'
end
