class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    # custom_timeline
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      # custom_timeline
      render :index, alert: 'Post was not created.'
    end
  end


  private

  # def timeline_posts
  #   @timeline_posts ||= Post.all.ordered_by_most_recent.includes(:user)
  #   @custom_timeline = custom_timeline
  # end



  def post_params
    params.require(:post).permit(:content)
  end
end
