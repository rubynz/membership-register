Rails.application.routes.draw do
  resources :members, except: :index

  namespace :admin do
    resources :members
  end
end
