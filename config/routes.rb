Rails.application.routes.draw do
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'

  resources :users, param: :slug, only: [ :show, :edit, :update ] do
    resources :user_gists, only: [ :index ]
  end
  resources :gist_files, only: [ :show ]
  resources :groups, only: [ :new, :create, :show, :update ] do
    resources :usergroups, only: [ :create ]
  end
  resources :labels, only: [ :new, :create ]
  resources :gist_labels, only: [ :new, :create ]

  post "get_gists", to: "users#get_gists"
  post "star_gist", to: "user_gists#toggle_star"
  post "hide_gist", to: "user_gists#toggle_hide"
end
