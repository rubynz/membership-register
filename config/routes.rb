Rails.application.routes.draw do
  root to: 'application#home'

  resources :members, except: :index

  namespace :admin do
    resources :members
  end
end
