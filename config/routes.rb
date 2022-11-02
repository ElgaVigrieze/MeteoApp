Rails.application.routes.draw do
  resources :records
  resources :parameters
  resources :stations

  post '/search', to: 'records#search'
  post '/parameters/:id', to: 'parameters#search'



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
