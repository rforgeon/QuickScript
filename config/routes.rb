Rails.application.routes.draw do

  resources :charges, only: [:new, :create]

  resources :pages

  devise_for :users

  root "welcome#index"
end
