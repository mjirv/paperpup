Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :collections
  resources :posts
  resources :sources

  root to: "collections#index"
end
