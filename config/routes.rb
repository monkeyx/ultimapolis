Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :facilities
  resources :district_effects
  resources :global_effects
  resources :events
  resources :projects
  devise_for :users
  resources :citizens
  resources :equipment_types
  resources :facility_types
  resources :trade_goods
  resources :professions
  resources :skills
  resources :districts
  root 'welcome#index'
end
