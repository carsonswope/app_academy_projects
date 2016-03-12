# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in!(@user)
      flash[:message] = "signed up, and logged in!"
      redirect_to users_url
    else
      flash.now[:message] = "sign up better please next time"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password)
  end
end
