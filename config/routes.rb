Rails.application.routes.draw do
  get "/users", to: "users#index"
  post "/users", to: "users#login"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
