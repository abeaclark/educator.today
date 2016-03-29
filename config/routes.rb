Rails.application.routes.draw do

  root 'posts#index'

  #Oauth / Login / Logout
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/login', to: 'welcome#login'
  delete '/logout', to: 'sessions#destroy'

  get 'posts/preview', to: 'posts#preview'

  resources :posts

  post '/posts/:post_id/votes/', to: 'votes#create'
  delete '/posts/:post_id/votes/', to: 'votes#destroy'

  get '/users/:username', to: 'users#show'

end