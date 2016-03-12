Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :index, :show]
  resources :subs, except: :destroy do
    resources :posts, only: :new
  end

  resources :posts, except: :index

  root to: 'subs#index'
end
