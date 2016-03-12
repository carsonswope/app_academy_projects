require 'rack'
require_relative '../lib/controller_base'
require_relative '../lib/router'
require_relative '../lib/session'
require_relative '../lib/sql_object'
require_relative '../lib/model/user'

class ApplicationController < ControllerBase
  def log_in(user)
    session['session_token'] = user.reset_session_token!
  end

  def log_out
    current_user.reset_session_token!
    session['session_token'] = nil
  end

  def current_user
    @current_user ||= User.find_by_session_token(session['session_token'])
  end
end

class UsersController < ApplicationController

  def index
    @users = User.all
    render :index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      username: params['user']['username'],
      password: params['user']['password']
    )

    if @user.save
      log_in(@user)
      redirect_to "/users"
    else
      redirect_to "/users/new"
    end
  end

end

class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create

    @user = User.find_by_credentials(
      params['user']['username'],
      params['user']['password']
    )

    if @user
      log_in(@user)
      redirect_to "/users"
    else
      redirect_to "/session/new"
    end
  end

  def destroy
    log_out
    redirect_to "/session/new"
  end
end

router = Router.new
router.draw do
  resources :users, only: [:index, :new, :show, :edit, :create]
  resource :session, only: [:new, :create, :destroy]
end

router.sort_routes!

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  router.run(req, res)
  res.finish
end

Rack::Server.start(
  app: app,
  Port: 3000
)
