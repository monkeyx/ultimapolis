Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Commontator::Engine => '/vox-populi'
  
  resources :citizens, except: [:index]
  
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

  resources :exchange_equipments, only: [:new, :create]
  resources :exchange_trade_goods, only: [:new, :create]
  
  resources :petitions do 
    member do 
      post :vote_for
      post :vote_against
    end
  end

  devise_for :users

  get 'charts/total_land', to: 'district_charts#total_land'
  get 'charts/free_land', to: 'district_charts#free_land'
  get 'charts/transport_capacity', to: 'district_charts#transport_capacity'
  get 'charts/civilians', to: 'district_charts#civilians'
  get 'charts/automatons', to: 'district_charts#automatons'
  get 'charts/unrest', to: 'district_charts#unrest'
  get 'charts/health', to: 'district_charts#health'
  get 'charts/policing', to: 'district_charts#policing'
  get 'charts/social', to: 'district_charts#social'
  get 'charts/environment', to: 'district_charts#environment'
  get 'charts/housing', to: 'district_charts#housing'
  get 'charts/education', to: 'district_charts#education'
  get 'charts/community', to: 'district_charts#community'
  get 'charts/creativity', to: 'district_charts#creativity'
  get 'charts/aesthetics', to: 'district_charts#aesthetics'
  get 'charts/crime', to: 'district_charts#crime'
  get 'charts/corruption', to: 'district_charts#corruption'
  get 'charts/infrastructure', to: 'global_charts#infrastructure'
  get 'charts/grid', to: 'global_charts#grid'
  get 'charts/power', to: 'global_charts#power'
  get 'charts/stability', to: 'global_charts#stability'
  get 'charts/climate', to: 'global_charts#climate'
  get 'charts/liberty', to: 'global_charts#liberty'
  get 'charts/security', to: 'global_charts#security'
  get 'charts/borders', to: 'global_charts#borders'
  get 'charts/inflation', to: 'global_charts#inflation'
  get 'charts/citizens', to: 'global_charts#citizens'
  get 'charts/gdp', to: 'global_charts#gdp'
  get 'charts', to: 'global_charts#index'

  root 'welcome#index'

  get 'test_exception_notifier', :controller => 'application', :action => 'test_exception_notifier'
end
