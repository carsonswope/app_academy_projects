Rails.application.routes.draw do
  resources :users
  resource :session
  resources :comments
  resources :goals

  resources :user_comments
  resources :goal_comments

end
