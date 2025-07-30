Rails.application.routes.draw do
  # Root route
  root "chatroom#index"

  # Authentication
  get "login", to: "session#new"
  match "signup", to: "session#signup", via: [:get, :post]
  post "login", to: "session#create"
  delete "logout", to: "session#destroy"

  # General public chatroom message route (restored!)
  post "message", to: "messages#create"

  # Private chats
  resources :conversations, only: [:index, :show, :create] do
    resources :messages, only: [:create], module: :conversations
  end

  # ActionCable
  mount ActionCable.server => "/cable"
end
