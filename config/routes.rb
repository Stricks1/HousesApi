Rails.application.routes.draw do
  #devise_for :users
  namespace :v1, defaults: { format: :json } do
    resource :users, only: %i[create]
    post "/login", to: "auth#login"
    get "/auto_login", to: "auth#auto_login"
    get "/user_is_authed", to: "auth#user_is_authed"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
