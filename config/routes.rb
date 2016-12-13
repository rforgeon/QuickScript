Rails.application.routes.draw do

  resources :charges, only: [:new, :create] do
    get 'downgrade'
    post 'execute_downgrade'
  end


  resources :pages
  
  resources :collaborators

  devise_for :users

  root "welcome#index"

end
