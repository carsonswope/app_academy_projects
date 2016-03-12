# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  body             :text             not null
#  commentable_type :string           not null
#  commentable_id   :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class CommentsController < ApplicationController

  before_action :redirect_unless_logged_in

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to url_for(@comment.commentable)
    elsif @comment.commentable_type && @comment.commentable_id
      flash[:errors] = @comment.errors.full_messages
      redirect_to url_for(@comment.commentable)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to user_url(current_user)
    end
  end

  def destroy
    @comment = Comment.find_by_id(params[:id])
    @comment.destroy
    redirect_to url_for(@comment.commentable)
  end

  private

  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :body)
  end


end
