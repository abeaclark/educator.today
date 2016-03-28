Rails.application.routes.draw do



  root 'posts#index'

  #Oauth / Login / Logout
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/login', to: 'welcome#login'
  delete '/logout', to: 'sessions#destroy'

  get 'posts/preview', to: 'posts#preview'
  resources :posts

  get '/users/me', to: 'users#me'
  get '/users/:username', to: 'users#show'

end