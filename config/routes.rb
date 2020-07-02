Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :users, param: :slug, only: [ :show ]
  resources :gist_files, only: [ :show ]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
