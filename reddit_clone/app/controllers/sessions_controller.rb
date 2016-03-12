class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:name],
      params[:user][:password]
    )

    if @user

      log_in!(@user)
      flash[:message] = "welcome to rednot"
      redirect_to root_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end

  end

  def destroy
    log_out!(current_user)
    flash[:message] = "logged out!"
    redirect_to root_url
  end

end
