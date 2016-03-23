Rails.application.routes.draw do

root 'welcome#index'

#Oauth / Login / Logout
get '/auth/:provider/callback', to: 'sessions#create'
get '/login', to: 'welcome#login'
delete '/logout', to: 'sessions#destroy'

#Feed
get '/feed', to: 'feed#index'

end