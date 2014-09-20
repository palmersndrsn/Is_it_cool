Rails.application.routes.draw do

  get 'users/index'

  get 'users/create'

  get 'users/show'

  get 'users/update'

  get 'users/destroy'

  get 'events/index'

  get 'events/create'

  get 'events/show'

  get 'events/update'

  get 'events/destroy'

  resources :events, except: [:new, :edit]

  resources :users, except: [:new, :edit]

  get 'site/index'

  match "*path", to: "site#index", via: "get"

  root 'site#index'

end
