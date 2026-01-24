Rails.application.routes.draw do
  root to: "application#home"

  resources :members, except: :index
  resource :membership_inquiry, only: [:new, :create, :show]
  resource :membership_confirmation, only: [:new, :create, :show]
  resources :vote_requests, only: [:new, :create]

  namespace :admin do
    resources :members
  end
end
