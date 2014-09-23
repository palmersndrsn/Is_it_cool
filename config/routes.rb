Rails.application.routes.draw do

  resources :events, except: [:new, :edit] do
    resources :reviews, except: [:new, :edit]
  end

  resources :users, except: [:new, :edit]


  get 'site/index'

  match "*path", to: "site#index", via: "get"

  root 'site#index'

end
