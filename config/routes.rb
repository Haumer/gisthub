Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :users, param: :slug, only: [ :show ]
  resources :gist_files, only: [ :show, :test ]
  resources :groups, only: [ :new, :create ]
  resources :labels, only: [ :new, :create ]
  resources :gist_labels, only: [ :new, :create ]

  post "get_gists", to: "users#get_gists"
  post "star_gist", to: "gists#star"
  post "hide_gist", to: "gists#hide"
end
