Rails.application.routes.draw do
  devise_for :users,
  controllers: {
    omniauth_callbacks: 'omniauth_callbacks'
  }
  root to: "pages#home"

  resources :users, only: [:index, :show] do
    resources :bookings, only: [:new, :create]
    resources :favorites, only: [:create]
  end

  resources :favorites, only: [:index, :destroy]

  resources :bookings, only: [:edit, :update, :destroy] do
    resources :reviews, only: [:create]
  end

  resource :profile, only: :show

  resources :animals, except: [:show] do
    resources :health_records, only: [:create, :index]
    resources :documents, only: :index
    resources :bookings, only: :index
  end

  resources :health_records, only: [:edit, :update, :destroy]
end
