Rails.application.routes.draw do

  resources :events, except: [:new, :edit] do
    resources :reviews, except: [:new, :edit]
  end

  resources :users, except: [:new, :edit]

  post '/login', to: 'session#create'
  get '/logged_in_user', to: 'session#logged_in_user'

  get 'site/index'

  match "*path", to: "site#index", via: "get"

  root 'site#index'

end
