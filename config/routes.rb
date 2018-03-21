Rails.application.routes.draw do
  devise_for :users

  resources :streamings, only: [:new, :create, :show, :index]

  get '/transmissoes-ao-vivo', to: 'live_streamings#index', as: :live_streamings 

  root to: 'home#index'
end
