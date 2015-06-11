Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"

  get "home" => "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"

  resources :users

  namespace :admin do
    root "dashboard#show"
    resources :skills
  end
end
