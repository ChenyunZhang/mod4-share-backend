Rails.application.routes.draw do

  get "/users", to: "users#index"
  post "/users", to: "users#login"
  get "/users/keep_logged_in", to: "users#keep_logged_in"
  patch "/users/:id", to: "users#update"
  
  get "/posts", to: "posts#index"
  post "/posts", to: "posts#create"
  delete "/posts/:id", to: "posts#destroy"

  get "/likes", to: "likes#index"
  post "/likes", to: "likes#create"
  delete "/likes/:id", to: "likes#destroy"

  get "/comments", to: "comments#index"
  post "/comments", to: "comments#create"
  delete "/comments/:id", to: "comments#destroy"

  get "/relationships", to: "relationships#index"
  post "/relationships", to: "relationships#create"
  delete "/relationships/:id", to: "relationships#destroy"
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
