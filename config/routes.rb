Rails.application.routes.draw do

  get 'site/index'

  match "*path", to: "site#index", via: "get"

  root 'site#index'

end
