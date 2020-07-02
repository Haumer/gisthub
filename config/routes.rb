Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :users, param: :slug, only: [ :show ]
  resources :gist_files, only: [ :show, :test ]

  post "get_gists", to: "users#get_gists"
end
