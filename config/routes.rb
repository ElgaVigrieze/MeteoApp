Rails.application.routes.draw do
  resources :records
  resources :parameters
  resources :stations

  # get "/records/parameters", to: "records#parameter"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
