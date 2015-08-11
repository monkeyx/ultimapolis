Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Blogit::Engine => "/news"
  mount Commontator::Engine => '/vox-populi'
  
  resources :citizens, except: [:index, :destroy] do 
    get :inventory
  end
  
  resources :projects, except: [:index, :show]
  resources :project_members, only: [:create, :destroy]
  resources :facilities, except: [:index]
  resources :loans, except: [:index, :edit, :update, :show]
  resources :bonds, except: [:index, :edit, :update, :show]
  
  resources :districts, only: [:index, :show]

  resources :equipment_types, only: [:index, :show]
  
  resources :facility_types, only: [:index, :show]
  
  resources :professions, only: [:index, :show]
  
  resources :skills, only: [:index, :show]
  
  resources :trade_goods, only: [:index, :show]
  
  resources :help_topics, only: [:index, :show]
  
  resources :events, only: [:show]
  
  devise_for :users
  root 'welcome#index'
end
