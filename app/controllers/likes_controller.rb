class LikesController < ApplicationController
  def create
    post_id = params[:post_id].to_i
    post = Post.find(post_id)

    like = post.likes.new
    like.author = current_user

    respond_to do |format|
      format.html do
        if like.save
          flash[:success] = 'Like added!'
          redirect_back_or_to(post)
        else
          flash[:error] = 'Something went wrong'
          redirect_back_or_to(post)
        end
      end
    end
  end
end
