Rails.application.routes.draw do
  resources :comments
  resources :posts
  resources :duplicates
end
