Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/mechanic/:id", to: "mechanic#show"
  get "/mechanic/:id/new", to: "mechanic#new"

  post "/mechanic/:id/rides", to: "mechanic_rides#create"
end
