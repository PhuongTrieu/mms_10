Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"

  get "home" => "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"

  resources :users do
    resources :skill_users
    get "add_skills" => "skill_users#show"
  end

  namespace :admin do
    root "users#index"
    resources :skills, :users, :teams
  end
end
