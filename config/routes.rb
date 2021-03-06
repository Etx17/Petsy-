Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'users#new'

  get '/profil', to: 'users#edit', as: :profil
  patch '/profil', to: 'users#update'

  resources :sessions, only: [:new, :create, :destroy]

  resources :users, only: [:new, :create] do
    member do
      get 'confirm'
    end
  end
end
