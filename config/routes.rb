Rails.application.routes.draw do
  get "welcome", to: "welcome#index"

  get "oauth2/request"
end
