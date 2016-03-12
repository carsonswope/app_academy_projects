Rails.application.routes.draw do

  root to: 'roots#root'

  resource :api, only: [] do
    resources :todos, only: [:index, :create, :destroy, :show, :update]
  end



end
