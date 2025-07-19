Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "chatroom#index"
  get "login", to: "session#new"
  match "signup", to: "session#signup", via: [:get, :post]
  post 'login', to: 'session#create'
  delete 'logout', to: 'session#destroy'
  post 'message', to: 'messages#create'

  mount ActionCable.server => '/cable'

end
