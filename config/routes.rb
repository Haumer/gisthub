Rails.application.routes.draw do
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # root to: "pages#home"
  unauthenticated :user do
    root to: "pages#home"
  end
  authenticated :user do
    root to: "users#dashboard", as: :user_root
  end

  get "dashboard", to: "users#dashboard"

  # Admin
  get "admin_dashboard", to: "users#admin_dashboard", as: "admin_dashboard"
  post "import_for_group", to: "users#import_for_group"
  post "admin_create", to: "users#admin_create"
  get "access", to: "pages#access"

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, param: :slug, only: [ :create, :show, :edit, :update ] do
    resources :user_gists, only: [ :index ]
  end
  resources :gist_files, only: [ :show ]
  resources :groups, only: [ :new, :create, :show, :update ] do
    resources :usergroups, only: [ :create ]
  end
  resources :labels, only: [ :new, :create ]
  resources :gist_labels, only: [ :new, :create ]
  resources :group_gists

  post "get_gists", to: "users#get_gists"
  post "star_gist", to: "user_gists#toggle_star"
  post "hide_gist", to: "user_gists#toggle_hide"
  get "howto", to: "pages#howto"
end
