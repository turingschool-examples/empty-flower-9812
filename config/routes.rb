Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources(
    :mechanics, controller: "mechanics", only: %i[show]
  )

  resources(
    :ride_mechanics, controller: "ride_mechanics", only: %i[create]
  )
end
