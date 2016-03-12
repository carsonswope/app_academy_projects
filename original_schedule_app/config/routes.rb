Rails.application.routes.draw do

  root 'static_pages#home'
  get 'new_team' => 'teams#new'
  get 'new_league' => 'leagues#new'
  get 'delete_league' => 'leagues#delete'
  get 'auto_schedule_home' => 'auto_schedule#home'

  match 'auto_schedule_execute', to: 'auto_schedule#execute', via: [:post]

  resources :teams
  resources :leagues
  resources :league_team_lists, only: [:create, :destroy]
  resources :fields
  resources :games

  get 'static_pages/contact'

end
