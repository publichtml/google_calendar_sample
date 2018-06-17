Rails.application.routes.draw do
  get "welcome", to: "welcome#index"

  get "oauth2/authorize"
  get "oauth2/callback"
end
