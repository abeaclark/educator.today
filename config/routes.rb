Rails.application.routes.draw do

  resources :posts

  root 'feed#index'

  #Oauth / Login / Logout
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/login', to: 'welcome#login'
  delete '/logout', to: 'sessions#destroy'

  #Feed
  get '/feed', to: 'feed#index'

  get '/users/me', to: 'users#me'
  get '/users/:username', to: 'users#profile'

end