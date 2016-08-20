Rails.application.routes.draw do
  root to: 'application#home'

  resources :members, except: :index
  resource :membership_inquiry, only: [:new, :create, :show]

  namespace :admin do
    resources :members
  end
end
