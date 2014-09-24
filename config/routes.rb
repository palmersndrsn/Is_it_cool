Rails.application.routes.draw do

  resources :events, except: [:new, :edit] do
    resources :reviews, except: [:new, :edit]
  end

  resources :users, except: [:new, :edit]

  get '/logged_in_user', to: 'sessions#logged_in_user'
  post '/login', to: 'sessions#create'

  get '/logout', to: 'sessions#destroy'

  match "*path", to: "site#index", via: "get"
  get 'site/index'
  root 'site#index'

end
