Rails.application.routes.draw do
  get 'projects/football'

  get 'projects/neca'

  get 'projects/coolcool'

  resources :blogs
  get '/', :to => 'static_pages#home'

  get 'static_pages/help'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
