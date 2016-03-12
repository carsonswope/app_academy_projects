# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  description  :text             not null
#  moderator_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class SubsController < ApplicationController

  before_action :ensure_logged_in, only: [:new, :create]

  def edit
    @sub = Sub.find_by(id: params[:id])
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      flash[:message] = "welcome to #{@sub.title}"
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def index
    @subs = Sub.all
  end

  def update
    @sub = Sub.find_by(id: params[:id])
    if @sub.update(sub_params)
      flash[:message] = "Updated #{@sub.title}"
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def show
    @sub = Sub.find_by(id: params[:id])
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
