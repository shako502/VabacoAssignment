Rails.application.routes.draw do
  get "/posts", to: "posts#index"
  get "/duplicates", to: "duplicates#index"
end
