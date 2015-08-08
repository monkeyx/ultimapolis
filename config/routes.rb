Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Blogit::Engine => "/news"
  
  resources :citizens, except: [:index, :destroy] do 
    get :inventory
  end
  
  resources :projects, except: [:index, :show]
  resources  :project_members, only: [:new, :create, :destroy]
  resources :facilities, except: [:index]
  
  resources :districts, only: [:index, :show] do 
    resources :district_effects, only: [:show]
  end

  resources :equipment_types, only: [:index, :show]
  
  resources :facility_types, only: [:index, :show]
  
  resources :professions, only: [:index, :show]
  
  resources :skills, only: [:index, :show]
  
  resources :trade_goods, only: [:index, :show]
  
  resources :help_topics, only: [:index, :show]
  
  resources :events, only: [:show]

  resource :global_effects, only: [:index, :show]
  
  devise_for :users
  root 'welcome#index'
end
