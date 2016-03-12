# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  sub_id     :integer          not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostsController < ApplicationController
  before_action :ensure_logged_in, except: :show

  def new
    @post = Post.new
    @subs = Sub.all
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.sub_ids = params[:post][:sub_ids].reject { |sub_id| sub_id == "" }
    @post.author_id = current_user.id

    if @post.save

      @post.sub_ids.each do |sub_id|
        PostSub.create!(post_id: @post.id, sub_id: sub_id)
      end

      flash[:message] = "Post created!"
      redirect_to post_url(@post)
    else
      @subs = Sub.all
      flash.now[:errors] = "your post sucks"
      render :new
    end
  end

  def destroy
  end

  def update
  end

  def edit
  end
  private

  def post_params
    params.require(:post).permit(:title,:content,:url)
  end

end
