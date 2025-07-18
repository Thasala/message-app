Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "chatroom#index"
  get "login", to: "session#new"
  get "signup", to: "session#signup"
  post 'login', to: 'session#create'
  delete 'logout', to: 'session#destroy'

end
