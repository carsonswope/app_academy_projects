# == Schema Information
#
# Table name: goals
#
#  id          :integer          not null, primary key
#  description :text             not null
#  user_id     :integer          not null
#  completed   :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  pprivate    :boolean          default(FALSE), not null
#

class GoalsController < ApplicationController

  before_action :redirect_unless_logged_in
  before_action :require_correct_user!, only: [:edit, :update, :destroy]

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    @goal.completed = false
    if @goal.save
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def update
    @goal = find_goal
    if @goal.update(goal_params)
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def edit
    @goal = find_goal
  end

  def destroy
    @goal = find_goal
    @goal.destroy
    redirect_to user_url(current_user)
  end

  def show
    @goal = find_goal
  end

  private

  def goal_params
    params.require(:goal).permit(:description, :completed, :pprivate)
  end

  def require_correct_user!
    redirect_to new_session_url unless find_goal.user_id == current_user.id
  end

  def find_goal
    Goal.find_by_id(params[:id])
  end

end
