Rails.application.routes.draw do
  resources :records, :except => :create
  resources :parameters
  resources :stations

  post '/records', to: 'records#search'
  post '/parameters/:id', to: 'parameters#search'



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

