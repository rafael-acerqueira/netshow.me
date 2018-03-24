Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  devise_for :users

  resources :streamings, only: [:new, :create, :show, :index, :update], param: :slug

  get '/live-streamings/:slug', to: 'live_streamings#show', as: :live_streaming

  get '/live-streamings', to: 'live_streamings#index', as: :live_streamings

  get '/next-streamings', to: 'next_streamings#index', as: :next_streamings

  root to: 'home#index'
end
