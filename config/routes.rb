Rails.application.routes.draw do
  resources :comments
  devise_for :users, controllers: { registrations: "registrations"}
  post 'bot_actions/process_user_input'

  mount ActionCable.server => '/cable'

  get 'projects/football'

  get 'projects/neca'

  get 'projects/coolcool'

  resources :blogs
  get '/', :to => 'static_pages#home'

  get '/about_me', :to => 'static_pages#about_me'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
