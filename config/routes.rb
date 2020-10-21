Rails.application.routes.draw do

  get "/users", to: "users#index"
  post "/users", to: "users#login"
  get "/users/keep_logged_in", to: "users#keep_logged_in"
  get "/posts", to: "posts#index"
  post "/posts", to: "posts#create"
  delete "/posts/:id", to: "posts#destroy"
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
