Rails.application.routes.draw do
  resources :records, :except => :create
  resources :parameters
  resources :stations

  root to: "records#index"
  get '/fun', to: 'records#fun'
  get '/overview', to: 'records#overview'
  get '/parameters/:id/show' => 'parameters#show2', :as => :parameter_show_path




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

