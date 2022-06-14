class PostsController < ApplicationController
  def index
    @current_user = current_user
    @current_user_id = current_user.id.to_i if current_user
    user_id = params[:user_id].to_i
    @user = User.includes(:posts).find(user_id)
    @posts = @user.posts.includes(:comments)
  end

  def new
    @current_user = current_user
    @current_user_id = current_user.id.to_i
    post_new = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: post_new } }
    end
  end

  def create
    post = current_user.posts.new(post_params)

    respond_to do |format|
      format.html do
        if post.save
          flash[:success] = 'Post added!'
        else
          flash[:error] = 'Something went wrong'
        end
        redirect_to user_posts_path(current_user)
      end
    end
  end

  def show
    @current_user = current_user
    post_id = params[:id].to_i
    @post = Post.includes(:comments).find(post_id)
    @liked = @current_user.likes.find_by(post: @post) if current_user
  end

  private

  def post_params
    params.require(:post).permit(:text, :title)
  end
end
