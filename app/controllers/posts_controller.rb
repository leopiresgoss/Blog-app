class PostsController < ApplicationController
  def index
    @current_user_id = current_user.id.to_i
    user_id = params[:user_id].to_i
    @user = User.includes(:posts).find(user_id)
    @posts = @user.posts
  end

  def new
    @current_user_id = current_user.id.to_i
    post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: } }
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
    @post = Post.find(post_id)
    @liked = @current_user.likes.find_by(post: @post)
  end

  private

  def post_params
    params.require(:post).permit(:text, :title)
  end
end
