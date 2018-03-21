Rails.application.routes.draw do
  devise_for :users

  resources :streamings, only: [:new, :create, :show, :index]

  get '/live-streamings', to: 'live_streamings#index', as: :live_streamings

  get '/next-streamings', to: 'next_streamings#index', as: :next_streamings

  root to: 'home#index'
end
