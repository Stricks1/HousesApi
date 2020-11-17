Rails.application.routes.draw do
  #devise_for :users
  namespace :v1, defaults: { format: :json } do
    resources :places
    resources :rent_dates, only: [:index, :show, :create, :destroy]
    resources :images, only: [:create, :destroy]
    resources :favorites, only: [:index, :create, :destroy]
    resource :users, only: %i[create]
    post "/occupied/:id", to: "places#occupied"
    get "/logout", to: "auth#logout"
    post "/login", to: "auth#login"
    get "/logout", to: "auth#logout"
    get "/auto_login", to: "auth#auto_login"
    get "/user_is_authed", to: "auth#user_is_authed"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
