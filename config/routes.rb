Rails.application.routes.draw do
  resources :records, :except => :create
  resources :parameters
  resources :stations


  post '/overview', to: 'records#search'
  post '/parameters/:id', to: 'parameters#search'
  get '/fun', to: 'records#fun'
  get '/overview', to: 'records#overview'
  root to: "records#index"



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

