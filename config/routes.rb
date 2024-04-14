Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :amusement_parks, only: [:show] # get "/amusement_parks/:id", to: "amusement_parks#show"

  resources :mechanics, only: [:show, :create] # get "/mechanics/:id", to: "mechanics#show"

  # I'm not that great with resources, but I couldn't get 
  # this to work for me in the above ^ :mechanics resources tab
  # Any advice for fixing this would be awesome!

  post "/mechanics/:id/rides", to: "mechanic_rides#create"
end