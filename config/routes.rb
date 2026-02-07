Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"

  match "/auth/learn/callback", to: "sessions#learn", via: [:get, :post]
  get "/auth/failure", to: "sessions#failure"
  delete "/logout", to: "sessions#destroy", as: :logout

  if Rails.env.test?
    post "/test/auth/learn/callback", to: "sessions#learn"
  end
end
