Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :mechanics, only: [:show] do
    resources :rides, only: [:create], controller: "mechanic_rides"
  end

  resources :amusement_parks, only: [:show]
end
