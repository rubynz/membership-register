Rails.application.routes.draw do
  root to: 'application#home'

  resources :members, except: :index
  resources :membership_inquiries, only: [:new, :create]

  namespace :admin do
    resources :members
  end
end
